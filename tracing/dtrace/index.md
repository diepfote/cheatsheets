# Darwin

## Dtrace objects


---

Based on Dtrace Dynamic Tracing in Oracle Solaris, Mac OS X, And FreeBSD
Brendan Gregg, Jim Mauro

---

### Get type of object

Any translation should be defined in this directory `/usr/lib/dtrace/`.

Examples below.

#### `curthread` struct

`curthread` is defined as a `struct thread`. How do I know?

```text
$ sudo dtrace -n 'profile-997hz { @[curthread->invalid_member] = count(); }'
dtrace: invalid probe specifier profile-997hz { @[curthread->invalid_member] = count(); }: in action list: invalid_member is not a member of struct thread
```

#### `proc` struct

```text
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

<details><p>

```text
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

</p></details>

##### Check if this translator is the one we are looking for

<details><p>

```text
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

</details></p>

#### `proc` struct translator

```text
$ grep -r 'proc ' /usr/lib/dtrace/
/usr/lib/dtrace/darwin.d:inline struct proc * curproc =
/usr/lib/dtrace/darwin.d:       ((struct proc *)(curthread->t_tro->tro_proc)) != NULL ? ((struct proc *)(curthread->t_tro->tro_proc)) :
/usr/lib/dtrace/darwin.d:translator psinfo_t < struct proc * P > {
```

```text
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

  ```text
  $ grep -rF 'task ' /usr/lib/dtrace/
  /usr/lib/dtrace/darwin.d:       taskid_t pr_taskid; /* task id */
  /usr/lib/dtrace/darwin.d:       pr_nlwp =       ((struct task *)(P->task))->thread_count;
  ```

###### Cast to struct task pointer

```text
sudo dtrace -n 'profile-997hz { @[((struct task *)curthread->t_tro->tro_proc->task)->thread_count] = count(); }'
```

### Cast dtrace object | Casting dtrace object

[Example](#cast-to-struct-task-pointer)


## Find origin of `read` system call in mpv on Darwin

### Check if there is a `read` system call + get PID

probefunc = syscall in this case

```text
sudo dtrace -n 'syscall:::entry /execname == "mpv"/ { @[pid, probefunc] = count(); }'
```

### List functions to trace for `read`

Checked if `syscall::*read*:entry` would find more read syscalls for this process. It did not.

```text
sudo dtrace -n 'syscall::read:entry /execname == "mpv"/ { @[ustack()] = count(); }'
              libsystem_kernel.dylib`read+0xa
              mpv`stream_read_unbuffered+0x41
              mpv`stream_read_more+0xe5
              mpv`stream_read_partial+0x91
              mpv`mp_read+0x2e
              libavformat.58.dylib`0x000000010d4e5f5d+0x13
                2
```

We will take a look at where `stream_read_unbuffered` leads us.

### What does `stream_read_unbuffered` do?

----

Based on `Dtrace Review` by Brian Cantrill
https://www.youtube.com/watch?v=TgmA48fILq8

---

The pid provider traces every instruction in a given PID.
We filter by function.  
Detect every function entry:

```text
sudo dtrace -n 'pid56141::stream_read_unbuffered:entry'
```

Show timestamp for function entry:

```text
sudo dtrace -n 'pid56141::stream_read_unbuffered:entry { printf("Called stream_read_unbuffered at %Y", walltimestamp); }'
CPU     ID                    FUNCTION:NAME
  6   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:32
  8   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:33
  2   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:34
  5   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:35
^C
```

Follow all instructions in the process after they passed through `stream_read_unbuffered` ([mpv-trace-stream_read_unbuffered](./d-scripts/mpv-trace-stream_read_unbuffered.d)):

```text
dtrace: script './mpv-trace-stream_read_unbuffered.d' matched 67031 ([] probes
CPU FUNCTION
  0  -> stream_read_unbuffered
  0    -> mp_cancel_test
  0    <- mp_cancel_test
  0    -> read
  0    <- read
  0  <- stream_read_unbuffered
  4  -> stream_read_unbuffered
  4    -> mp_cancel_test
  4    <- mp_cancel_test
  4    -> read
  4    <- read
  4  <- stream_read_unbuffered
  6  -> stream_read_unbuffered
  6    -> mp_cancel_test
  6    <- mp_cancel_test
  6    -> read
  6    <- read
  6  <- stream_read_unbuffered
```

Follow every action stream_read_unbuffered triggered in the kernel ([mpv-trace-stream_read_unbuffered-in-the-kernel](./d-scripts/mpv-trace-stream_read_unbuffered-in-the-kernel.d)):

<details><p>

```text
dtrace: script './mpv-trace-stream_read_unbuffered.d' matched 193402 probes
 10  -> lck_rw_done
 10  <- lck_rw_done
 10  <- user_trap
 10  -> unix_syscall64
 10    -> proc_ucred
 10    <- proc_ucred
 10    -> audit_syscall_enter
 10    <- audit_syscall_enter
 10    -> read
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10      -> vfs_context_current
 10      <- vfs_context_current
 10      -> uio_addiov
 10      <- uio_addiov
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10      -> vnode_getiocount
 10      <- vnode_getiocount
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10      -> mac_vnode_check_read
 10      <- mac_vnode_check_read
 10      -> apfs_vnop_read
 10        -> uio_resid
 10        <- uio_resid
 10        -> uio_offset
 10        <- uio_offset
 10        -> vnode_mount
 10        <- vnode_mount
 10        -> vfs_fsprivate
 10        <- vfs_fsprivate
 10        -> vnode_fsnode
 10        <- vnode_fsnode
 10        -> _ZN18APFSOSNumberAtomic8addValueEx
 10        <- _ZN18APFSOSNumberAtomic8addValueEx
 10        -> is_operation_allowed
 10        <- is_operation_allowed
 10        -> apfs_decmpfs_file_is_compressed
 10        <- apfs_decmpfs_file_is_compressed
 10        -> apfs_should_scan_for_fragmentation
 10        <- apfs_should_scan_for_fragmentation
 10        -> lck_rw_lock_shared
 10        <- lck_rw_lock_shared
 10        -> lck_rw_lock_shared
 10        <- lck_rw_lock_shared
 10        -> apfs_get_file_size
 10        <- apfs_get_file_size
 10        -> lck_rw_unlock_shared
 10          -> lck_rw_done
 10          <- lck_rw_done
 10        <- lck_rw_unlock_shared
 10        -> cluster_read
 10        <- cluster_read
 10        -> cluster_read_ext
 10          -> lck_mtx_try_lock
 10          <- lck_mtx_try_lock
 10          -> memory_object_control_uiomove
 10            -> vm_object_lock
 10            <- vm_object_lock
 10            -> lck_rw_lock_exclusive
 10            <- lck_rw_lock_exclusive
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> lck_rw_done
 10            <- lck_rw_done
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> uiomove64
 10              -> uio_update
 10              <- uio_update
 10            <- uiomove64
 10            -> vm_object_lock
 10            <- vm_object_lock
 10            -> lck_rw_lock_exclusive
 10            <- lck_rw_lock_exclusive
 10            -> vm_page_lru
 10            <- vm_page_lru
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> vm_page_lru
 10              -> vm_page_queues_remove
 10                -> vm_page_balance_inactive
 10                <- vm_page_balance_inactive
 10              <- vm_page_queues_remove
 10            <- vm_page_lru
 10            -> vm_page_enqueue_inactive
 10            <- vm_page_enqueue_inactive
 10            -> lck_mtx_unlock_slow
 10            <- lck_mtx_unlock_slow
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> pmap_lock_phys_page
 10            <- pmap_lock_phys_page
 10            -> pmap_unlock_phys_page
 10            <- pmap_unlock_phys_page
 10            -> task_update_logical_writes
 10            <- task_update_logical_writes
 10            -> lck_rw_done
 10            <- lck_rw_done
 10          <- memory_object_control_uiomove
 10          -> vm_object_range_op
 10            -> lck_rw_lock_exclusive
 10            <- lck_rw_lock_exclusive
 10            -> vm_page_lookup
 10            <- vm_page_lookup
 10            -> lck_rw_done
 10            <- lck_rw_done
 10          <- vm_object_range_op
 10        <- cluster_read_ext
 10        -> lck_rw_lock_shared
 10        <- lck_rw_lock_shared
 10        -> update_atime
 10          -> vfs_flags
 10          <- vfs_flags
 10          -> vnode_israge
 10          <- vnode_israge
 10          -> vfs_ctx_skipatime
 10            -> get_bsdthreadtask_info
 10            <- get_bsdthreadtask_info
 10          <- vfs_ctx_skipatime
 10          -> vfs_flags
 10          <- vfs_flags
 10        <- update_atime
 10        -> uio_resid
 10        <- uio_resid
 10        -> _ZN18APFSOSNumberAtomic8addValueEx
 10        <- _ZN18APFSOSNumberAtomic8addValueEx
 10        -> _ZN18APFSOSNumberAtomic8addValueEx
 10        <- _ZN18APFSOSNumberAtomic8addValueEx
 10        -> lck_rw_unlock_shared
 10          -> lck_rw_done
 10          <- lck_rw_done
 10        <- lck_rw_unlock_shared
 10        -> lck_rw_unlock_shared
 10          -> lck_rw_done
 10          <- lck_rw_done
 10        <- lck_rw_unlock_shared
 10      <- apfs_vnop_read
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10      -> lck_mtx_unlock_slow
 10      <- lck_mtx_unlock_slow
 10    <- read
 10    -> user_trap
 10      -> proc_ucred
 10      <- proc_ucred
 10      -> lck_rw_lock_shared
 10      <- lck_rw_lock_shared
```

</p></details>

Which files are read by the `read` syscall requested by `mpv`?

```text
$ sudo dtrace  -n 'syscall::read:entry /execname == "mpv"/ { @[fds[3].fi_pathname] = count(); @[fds[4].fi_pathname] = count(); }'
dtrace: description 'syscall::read:entry ' matched 1 probe
^C

  ??/Logs/mpv.log                                                   1
  ??/Movies/Dtrace Review [TgmA48fILq8].mp4                         1
```

```text
$ sudo dtrace  -n 'syscall::read:entry /execname == "mpv"/ { @[fds[arg0].fi_pathname] = count(); }'
^C

  ??/Logs/mpv.log                                                   1
  ??/Movies/Dtrace Review [TgmA48fILq8].mp4                         1
```

Which libraries does `mpv` load (well this shows more -> any mmap file)?

<details><p>

```text
$ sudo dtrace  -n 'syscall::mmap:entry /execname == "mpv"/ { @[fds[arg4].fi_pathname] = count(); }'
dtrace: description 'syscall::mmap:entry ' matched 1 probe
^C

  ??/16777237_9765376/functions.data                                1
  ??/31001/libraries.data                                           1
  ??/AppExceptions.bundle/Exceptions.plist                          1
  ??/C/com.apple.IntlDataCache.le.kbdx                              1
  ??/Fonts/Helvetica.ttc                                            1
  ??/Fonts/SFCompact.ttf                                            1
  ??/Fonts/SFNS.ttf                                                 1
  ??/Resources/AppleKeyboardLayouts-L.dat                           1
  ??/Resources/Aqua.car                                             1
  ??/Resources/Assets.car                                           1
  ??/Resources/Exceptions.plist                                     1
  ??/Resources/Extras2.rsrc                                         1
  ??/Resources/FauxVibrantLight.car                                 1
  ??/Resources/FunctionRowAppearance.car                            1
  ??/Resources/SystemAppearance.car                                 1
  ??/Resources/VibrantDark.car                                      1
  ??/Resources/VibrantLight.car                                     1
  ??/icu/icudt70l.dat                                               1
  ??/io.mpv.savedState/window_1.data                                1
  ??/lib/libobjc-trampolines.dylib                                  3
  <unknown (not a vnode)>                                           4
  ??/DisplayVendorID-610/DisplayProductID-a044                      4
  ??/Overrides/Icons.plist                                          4
  ??/lib/libarchive.13.dylib                                        4
  ??/lib/libass.9.dylib                                             4
  ??/lib/libavcodec.58.dylib                                        4
  ??/lib/libavdevice.58.dylib                                       4
  ??/lib/libavfilter.7.dylib                                        4
  ??/lib/libavformat.58.dylib                                       4
  ??/lib/libavresample.4.dylib                                      4
  ??/lib/libavutil.56.dylib                                         4
  ??/lib/libb2.1.dylib                                              4
  ??/lib/libcrypto.1.1.dylib                                        4
  ??/lib/libdav1d.5.dylib                                           4
  ??/lib/libfontconfig.1.dylib                                      4
  ??/lib/libfreetype.6.dylib                                        4
  ??/lib/libfribidi.0.dylib                                         4
  ??/lib/libglib-2.0.0.dylib                                        4
  ??/lib/libgraphite2.3.dylib                                       4
  ??/lib/libharfbuzz.0.dylib                                        4
  ??/lib/libintl.8.dylib                                            4
  ??/lib/liblcms2.2.dylib                                           4
  ??/lib/liblua.5.1.dylib                                           4
  ??/lib/liblz4.1.dylib                                             4
  ??/lib/liblzma.5.dylib                                            4
  ??/lib/libmujs.so                                                 4
  ??/lib/libogg.0.dylib                                             4
  ??/lib/libopenjp2.7.dylib                                         4
  ??/lib/libopus.0.dylib                                            4
  ??/lib/libpcre.1.dylib                                            4
  ??/lib/libpng16.16.dylib                                          4
  ??/lib/libpostproc.55.dylib                                       4
  ??/lib/librubberband.2.dylib                                      4
  ??/lib/libsamplerate.0.dylib                                      4
  ??/lib/libsoxr.0.dylib                                            4
  ??/lib/libsrt.1.4.dylib                                           4
  ??/lib/libssh.4.dylib                                             4
  ??/lib/libssl.1.1.dylib                                           4
  ??/lib/libswresample.3.dylib                                      4
  ??/lib/libswscale.5.dylib                                         4
  ??/lib/libtheoradec.1.dylib                                       4
  ??/lib/libtheoraenc.1.dylib                                       4
  ??/lib/libuchardet.0.dylib                                        4
  ??/lib/libvorbis.0.dylib                                          4
  ??/lib/libvorbisenc.2.dylib                                       4
  ??/lib/libvpx.7.dylib                                             4
  ??/lib/libzimg.2.dylib                                            4
  ??/lib/libzstd.1.dylib                                            4
  ??/MacOS/AMDRadeonX6000GLDriver                                   5
  ??/MacOS/CoreAudio                                                5
  <none>                                                          137
```

</details></p>

### python provider

----

Taken from `Dtrace Review` by Brian Cantrill
https://www.youtube.com/watch?v=TgmA48fILq8

---

### List probes

```text
$ sudo dtrace -l -P pyth\*
   ID   PROVIDER            MODULE                          FUNCTION NAME
16797 python14473            Python                         sys_audit audit
16798 python14473            Python                  sys_audit_tstate audit
16799 python14473            Python          _PyEval_EvalFrameDefault function-entry
16800 python14473            Python             dtrace_function_entry function-entry
16801 python14473            Python          _PyEval_EvalFrameDefault function-return
16802 python14473            Python            dtrace_function_return function-return
16803 python14473            Python                   gc_collect_main gc-done
16804 python14473            Python                   gc_collect_main gc-start
16805 python14473            Python  PyImport_ImportModuleLevelObject import-find-load-done
16806 python14473            Python  PyImport_ImportModuleLevelObject import-find-load-start
16807 python14473            Python          _PyEval_EvalFrameDefault line
16808 python14473            Python                 maybe_dtrace_line line
16929 python14419            Python                         sys_audit audit
16930 python14419            Python                  sys_audit_tstate audit
16931 python14419            Python          _PyEval_EvalFrameDefault function-entry
16932 python14419            Python             dtrace_function_entry function-entry
16933 python14419            Python          _PyEval_EvalFrameDefault function-return
16934 python14419            Python            dtrace_function_return function-return
16935 python14419            Python                   gc_collect_main gc-done
16936 python14419            Python                   gc_collect_main gc-start
16937 python14419            Python  PyImport_ImportModuleLevelObject import-find-load-done
16938 python14419            Python  PyImport_ImportModuleLevelObject import-find-load-start
16939 python14419            Python          _PyEval_EvalFrameDefault line
16940 python14419            Python                 maybe_dtrace_line line
71546 python94111            Python                         sys_audit audit
71547 python94111            Python                  sys_audit_tstate audit
71548 python94111            Python          _PyEval_EvalFrameDefault function-entry
71549 python94111            Python             dtrace_function_entry function-entry
71550 python94111            Python          _PyEval_EvalFrameDefault function-return
71551 python94111            Python            dtrace_function_return function-return
71552 python94111            Python                   gc_collect_main gc-done
71553 python94111            Python                   gc_collect_main gc-start
71554 python94111            Python  PyImport_ImportModuleLevelObject import-find-load-done
71555 python94111            Python  PyImport_ImportModuleLevelObject import-find-load-start
71556 python94111            Python          _PyEval_EvalFrameDefault line
71557 python94111            Python                 maybe_dtrace_line line
71678 python94025            Python                         sys_audit audit
71679 python94025            Python                  sys_audit_tstate audit
71680 python94025            Python          _PyEval_EvalFrameDefault function-entry
71681 python94025            Python             dtrace_function_entry function-entry
71682 python94025            Python          _PyEval_EvalFrameDefault function-return
71683 python94025            Python            dtrace_function_return function-return
71684 python94025            Python                   gc_collect_main gc-done
71685 python94025            Python                   gc_collect_main gc-start
71686 python94025            Python  PyImport_ImportModuleLevelObject import-find-load-done
71687 python94025            Python  PyImport_ImportModuleLevelObject import-find-load-start
71688 python94025            Python          _PyEval_EvalFrameDefault line
71689 python94025            Python                 maybe_dtrace_line line
```

### show module name & function name for Python

```text
$ sudo dtrace  -n 'python*:::function-entry { printf("%s %s\n", copyinstr(arg0), copyinstr(arg1)) }'
 10   2911 dtrace_function_entry:function-entry /tmp/test-signal.py run_default_behavior

  6   2911 dtrace_function_entry:function-entry /tmp/test-signal.py sigint_handler
```

## Pre-written dtrace scripts/Pre-provided dtrace scripts

### Where to find them on Mac OS

<details><p>

```text
$ find / -executable -type f -exec sh -c 'grep -m 1 -H -F "/usr/sbin/dtrace" "$0" 2>/dev/null' {} \; 2>/dev/null
/usr/bin/loads.d:#!/usr/sbin/dtrace -s
/usr/bin/syscallbypid.d:#!/usr/sbin/dtrace -s
/usr/bin/fddist:/usr/sbin/dtrace -n '
/usr/bin/iofileb.d:#!/usr/sbin/dtrace -s
/usr/bin/errinfo:/usr/sbin/dtrace -n '
/usr/bin/topsyscall:/usr/sbin/dtrace -n '
/usr/bin/iofile.d:#!/usr/sbin/dtrace -s
/usr/bin/iotop:/usr/sbin/dtrace -n '
/usr/bin/cpuwalk.d:#!/usr/sbin/dtrace -s
/usr/bin/dispqlen.d:#!/usr/sbin/dtrace -s
/usr/bin/lastwords:/usr/sbin/dtrace -n '
/usr/bin/syscallbyproc.d:#!/usr/sbin/dtrace -s
/usr/bin/timer_analyser.d:/usr/sbin/dtrace -n "$dtrace" $1
/usr/bin/execsnoop:/usr/sbin/dtrace -n '
/usr/bin/opensnoop:/usr/sbin/dtrace -n '
/usr/bin/newproc.d:#!/usr/sbin/dtrace -s
/usr/bin/syscallbysysc.d:#!/usr/sbin/dtrace -s
/usr/bin/pathopens.d:#!/usr/sbin/dtrace -s
/usr/bin/rwbytype.d:#!/usr/sbin/dtrace -s
/usr/bin/timerfires:    /usr/sbin/dtrace -xdisallow_dsym -Cqn "$dtrace" | /usr/bin/perl -w -e "$aggregator"
/usr/bin/dtruss:#       /usr/sbin/dtrace -x dynvarsize=$buf -x evaltime=postinit -n "$dtrace" \
/usr/bin/kill.d:#!/usr/sbin/dtrace -qs
/usr/bin/imptrace:      /usr/sbin/dtrace -s $SCRIPTFILE
/usr/bin/priclass.d:#!/usr/sbin/dtrace -s
/usr/bin/topsysproc:/usr/sbin/dtrace -n '
/usr/bin/seeksize.d:#!/usr/sbin/dtrace -s
/usr/bin/setuids.d:#!/usr/sbin/dtrace -s
/usr/bin/bitesize.d:#!/usr/sbin/dtrace -s
/usr/bin/iosnoop:/usr/sbin/dtrace -n '
/usr/bin/iopending:/usr/sbin/dtrace -n '
/usr/bin/rwbypid.d:#!/usr/sbin/dtrace -s
/usr/bin/procsystime:   /usr/sbin/dtrace -n "$dtrace" -x evaltime=exec -c "$command" >&2
/usr/bin/pridist.d:#!/usr/sbin/dtrace -s
/usr/bin/sigdist.d:#!/usr/sbin/dtrace -s
/usr/bin/dappprof:      /usr/sbin/dtrace -x dynvarsize=$buf -x evaltime=preinit -Z -n "$dtrace" \
/usr/bin/rwsnoop:/usr/sbin/dtrace -n '
/usr/bin/creatbyproc.d:#!/usr/sbin/dtrace -s
/usr/bin/pidpersec.d:#!/usr/sbin/dtrace -s
/usr/bin/sampleproc:/usr/sbin/dtrace -n '
/usr/bin/filebyproc.d:#!/usr/sbin/dtrace -s
/usr/bin/cpu_profiler.d:/usr/sbin/dtrace -n "$dtrace"
/usr/bin/iopattern:/usr/sbin/dtrace -n '
/usr/bin/hotspot.d:#!/usr/sbin/dtrace -s
/usr/bin/dapptrace:     /usr/sbin/dtrace -x dynvarsize=$buf -x evaltime=preinit -Z -n "$dtrace" \
/usr/libexec/dtrace/vm_map_delete_permanent_deny.d:#!/usr/sbin/dtrace -s
/usr/libexec/dtrace/log_unnest_badness.d:#!/usr/sbin/dtrace -s
/usr/libexec/dtrace/vm_object_ownership.d:#!/usr/sbin/dtrace -s
/usr/libexec/dtrace/vm_map_delete_permanent.d:#!/usr/sbin/dtrace -s
/usr/libexec/dtrace/vm_map_delete_permanent_prot_none.d:#!/usr/sbin/dtrace -s
/usr/libexec/dtrace/smbtrace.d:#! /usr/sbin/dtrace -C -s
/usr/libexec/dtrace/suspicious_task_vm_info_count.d:#!/usr/sbin/dtrace -s
/System/Library/Extensions/autofs.kext/Contents/Resources/watch_for_automounts:#!/usr/sbin/dtrace -s
/System/Library/Extensions/IOHIDFamily.kext/Contents/PlugIns/IOHIDLib.plugin/Contents/Resources/hiddtraceutil:validEventProbe=$(echo $(/usr/sbin/dtrace -l | grep $grepStrEvent | cut -d' ' -f 2) | cut -d' ' -f 1)
```

</details></p>

### Show files openend by process

```text
$ sudo opensnoop -p 63183
Password:


  UID    PID COMM          FD PATH
  501  63183 rsync          0 Compiler programming livestreams/53 Scope speedup, part 1-RsuZx8TxCpk.mp4
  501  63183 rsync          0 Compiler programming livestreams/54 Scope speedup, part 2-Jc1X3sdv9-k.mp4
```


# Display network activity via read and write system calls

Note: Obviously these calls can be either local or remote write/reads.
      This only works if you know the applications talks to the network.
      Otherwise you need to also display the path it is reading from or
      writing to.

Show last 20 syscalls in the last 10 seconds including the buffer size
they operated on

```text
$ sudo dtrace -p "$(ps -ef | grep -v grep | grep kubectl | awk '{ print $2 }')"  -n 'syscall::read:entry,syscall::write:entry /pid == $target/ { @iosize[probefunc, timestamp] = sum(arg2); } tick-10sec { trunc(@iosize, 20); printa(@iosize); }'
dtrace: description 'syscall::read:entry,syscall::write:entry ' matched 3 probes
CPU     ID                    FUNCTION:NAME
  0 500833                      :tick-10sec
  read                                                   414573712695            40870
  read                                                   414574224934            40870
  read                                                   413613772247            40872
  read                                                   413614178744            40872
  read                                                   420176099965            40872
  read                                                   420177271532            40872
  read                                                   416930462730            40930
  read                                                   416931065835            40930
  read                                                   416473476100            40932
  read                                                   416474150262            40932
  read                                                   415871678372            40934
  read                                                   415872751171            40934
  read                                                   415369604460            40936
  read                                                   415370663830            40936
  read                                                   414513020823            40938
  read                                                   414514626577            40938
  read                                                   413516276239            40940
  read                                                   413516325316            40940
  read                                                   420070217621            40940
  read                                                   420070275581            40940

  write                                                  420972849369               23
  write                                                  420972858378             9569
  write                                                  420959001064            24576
  write                                                  420342166732            32768
  write                                                  420395788760            32768
  write                                                  420466818116            32768
  write                                                  420496814581            32768
  write                                                  420546572194            32768
  write                                                  420594005810            32768
  write                                                  420626161704            32768
  write                                                  420680709445            32768
  write                                                  420726899148            32768
  write                                                  420791960338            32768
  write                                                  420864622197            32768
  write                                                  420929456447            32768
```
