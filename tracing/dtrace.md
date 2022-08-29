# Darwin

## Dtrace objects

### Get type of object

Any translation should be defined in this directory `/usr/lib/dtrace/`.

Examples below.

#### `curthread` struct

`curthread` is defined as a `struct thread`. How do I know?

```
$ sudo dtrace -n 'profile-997hz { @[curthread->invalid_member] = count(); }'
dtrace: invalid probe specifier profile-997hz { @[curthread->invalid_member] = count(); }: in action list: invalid_member is not a member of struct thread
```

#### `proc` struct

```
$ sudo dtrace -n 'profile-997hz { @[(curthread->t_tro->tro_proc)->invalid_member] = count(); }'
Password:
dtrace: invalid probe specifier profile-997hz { @[(curthread->t_tro->tro_proc)->invalid_member] = count(); }: in action list: invalid_member is not a member of struct proc
```


### Find type defintion/Find dtrace type tranlator

Examples below

#### `curthread` translator

**Hint**: I added `grep translator` to show less output.  
          I know about `translators` in dtrace now.  
          I did not when I was looking for `curthread`.

**Hint**: I assumed `thread` is the same as `thread_t`.

```
$ grep -r thread /usr/lib/dtrace/ | grep translator
/usr/lib/dtrace/darwin.d: * kthread_t-to-psinfo_t translator, below.
/usr/lib/dtrace/darwin.d:translator psinfo_t < thread_t T > {
/usr/lib/dtrace/darwin.d:translator lwpsinfo_t < thread_t T > {

$ grep -rFA 25 'translator lwpsinfo_t < thread_t T >' /usr/lib/dtrace/
/usr/lib/dtrace/darwin.d:translator lwpsinfo_t < thread_t T > {
/usr/lib/dtrace/darwin.d-       pr_flag = 0; /* lwp flags (DEPRECATED; do not use) */
/usr/lib/dtrace/darwin.d-       pr_lwpid = (id_t)T->thread_id;
/usr/lib/dtrace/darwin.d-       pr_addr = (uintptr_t)T;
/usr/lib/dtrace/darwin.d-       pr_wchan = (uintptr_t)(((uthread_t)&T[1])->uu_wchan);
/usr/lib/dtrace/darwin.d-
/usr/lib/dtrace/darwin.d-       pr_stype = SOBJ_NONE; /* XXX Undefined synch object (or none) XXX */
/usr/lib/dtrace/darwin.d-       pr_state = curproc->p_stat;
/usr/lib/dtrace/darwin.d-       pr_sname = (curproc->p_stat == SIDL) ? 'I' :
/usr/lib/dtrace/darwin.d-                       (curproc->p_stat == SRUN) ? 'R' :
/usr/lib/dtrace/darwin.d-                       (curproc->p_stat == SSLEEP) ? 'S' :
/usr/lib/dtrace/darwin.d-                       (curproc->p_stat == SSTOP) ? 'T' :
/usr/lib/dtrace/darwin.d-                       (curproc->p_stat == SZOMB) ? 'Z' : '?';
/usr/lib/dtrace/darwin.d-
/usr/lib/dtrace/darwin.d-       pr_syscall = ((uthread_t)&T[1])->uu_code;
/usr/lib/dtrace/darwin.d-       pr_pri = T->sched_pri;
/usr/lib/dtrace/darwin.d-
/usr/lib/dtrace/darwin.d-       pr_clname = (T->sched_mode & 0x0001) ? "RT" :
/usr/lib/dtrace/darwin.d-                       (T->sched_mode & 0x0002) ? "TS" : "SYS";
/usr/lib/dtrace/darwin.d-
/usr/lib/dtrace/darwin.d-       pr_onpro = (T->last_processor == PROCESSOR_NULL) ? -1 : T->last_processor->cpu_id;
/usr/lib/dtrace/darwin.d-       pr_bindpro = -1; /* Darwin does not bind threads to processors. */
/usr/lib/dtrace/darwin.d-       pr_bindpset = -1; /* Darwin does not partition processors. */
/usr/lib/dtrace/darwin.d-       pr_thstate = T->state;
/usr/lib/dtrace/darwin.d-};
```

##### Check if this translator is the one we are looking for

```
$ sudo dtrace -n 'profile-997hz { @[curthread->last_processor] = count(); }'
dtrace: description 'profile-997hz ' matched 1 probe
^C

    -549391900872              210
     -45001752392              210
     -45001741232              210
     -45001730072              210
     -45001718912              210
     -45001707752              210
     -45001696592              210
     -45001685432              210
     -45001674272              210
     -45001663112              210
     -45001651952              210
     -45001640792              210

$ sudo dtrace -n 'profile-997hz { @[curthread->state] = count(); }'
dtrace: description 'profile-997hz ' matched 1 probe
^C

       13                1
        4              657
      132             1166

$ sudo dtrace -n 'profile-997hz { @[curthread->thread_id] = count(); }'
dtrace: description 'profile-997hz ' matched 1 probe
^C

              853                1
          8793325               76
          8793464               78
              102               87
              173              104
...
```

#### `proc` struct translator

```
$ grep -r 'proc ' /usr/lib/dtrace/
/usr/lib/dtrace/darwin.d:inline struct proc * curproc =
/usr/lib/dtrace/darwin.d:       ((struct proc *)(curthread->t_tro->tro_proc)) != NULL ? ((struct proc *)(curthread->t_tro->tro_proc)) :
/usr/lib/dtrace/darwin.d:translator psinfo_t < struct proc * P > {
```

```
translator psinfo_t < struct proc * P > {
        pr_nlwp =       ((struct task *)(P->task))->thread_count;
        pr_pid =        P->p_pid;
        pr_ppid =       P->p_ppid;
        pr_pgid =       P->p_pgrp.__hazard_ptr->pg_id;
 
...
};
```

##### Resolve something in the `proc` struct

Get `thread_count` for the task of the process `curthread` is running in

**Hint**: `task` in `tro_proc` has to be casted, otherwise the `task` member
          will be `void *`. Dtrace requires type info to access members of objects.

**Hint**: This is how I knew how to cast the the `task` object:

  ```
  $ grep -rF 'task ' /usr/lib/dtrace/
  /usr/lib/dtrace/darwin.d:       taskid_t pr_taskid; /* task id */
  /usr/lib/dtrace/darwin.d:       pr_nlwp =       ((struct task *)(P->task))->thread_count;
  ```

###### Cast to struct task pointer

```
sudo dtrace -n 'profile-997hz { @[((struct task *)curthread->t_tro->tro_proc->task)->thread_count] = count(); }'
```

### Cast dtrace object | Casting dtrace object

[Example](#cast-to-struct-task-pointer)
