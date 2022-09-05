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


## Find origin of `read` system call in mpv on Darwin

### Check if there is a `read` system call + get PID

probefunc = syscall in this case

```
sudo dtrace -n 'syscall:::entry /execname == "mpv"/ { @[pid, probefunc] = count(); }'
```

### List functions to trace for `read`

Checked if `syscall::*read*:entry` would find more read syscalls for this process. It did not.

```
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

```
sudo dtrace -n 'pid56141::stream_read_unbuffered:entry'
```

Show timestamp for function entry:

```
sudo dtrace -n 'pid56141::stream_read_unbuffered:entry { printf("Called stream_read_unbuffered at %Y", walltimestamp); }'
CPU     ID                    FUNCTION:NAME
  6   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:32
  8   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:33
  2   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:34
  5   2099     stream_read_unbuffered:entry Called stream_read_unbuffered at 2022 Sep  5 03:36:35
^C
```

Follow all instructions in the process after they passed through `stream_read_unbuffered` ([mpv-trace-stream_read_unbuffered](./d-scripts/mpv-trace-stream_read_unbuffered.d)):

```
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

```
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

Which files are read by the `read` syscall requested by `mpv`?

```
$ sudo dtrace  -n 'syscall::read:entry /execname == "mpv"/ { @[fds[3].fi_pathname] = count(); @[fds[4].fi_pathname] = count(); }'
dtrace: description 'syscall::read:entry ' matched 1 probe
^C

  ??/Logs/mpv.log                                                   1
  ??/Movies/Dtrace Review [TgmA48fILq8].mp4                         1
```

```
$ sudo dtrace  -n 'syscall::read:entry /execname == "mpv"/ { @[fds[arg0].fi_pathname] = count(); }'
^C

  ??/Logs/mpv.log                                                   1
  ??/Movies/Dtrace Review [TgmA48fILq8].mp4                         1
```
