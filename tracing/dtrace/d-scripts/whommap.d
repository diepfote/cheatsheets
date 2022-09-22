#!/usr/bin/env dtrace -s

/* taken from `Dtrace Review` by Brian Cantrill */
/* https://www.youtube.com/watch?v=TgmA48fILq8 */

/* Basically who made you, "less", allocate memory */
/* Not very meaningful on Mac OS X */
/* ``` */
/* $ sudo ./whommap.d */
/* dtrace: script './whommap.d' matched 2 probes */
/* ^C */


/*              0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef */
/*          0: 6c 65 73 73 00 69 74 74 79 00 6b 00 00 00 00 00  less.itty.k..... */
/*                 2 */
/* ``` */


syscall::mmap:entry
/execname == "less"/
{
  self->interested = 1;
}

sched:::wakeup
/self->interested/
{
  /* $ grep -rF 'pr_fname' /usr/lib/dtrace/ */
  /* /usr/lib/dtrace/darwin.d:       char pr_fname[16];      /1* name of execed file *1/ */
  /* /usr/lib/dtrace/darwin.d:       pr_fname =      P->p_comm; */
  /* /usr/lib/dtrace/darwin.d:       pr_fname = xlate <psinfo_t> (T->t_tro->tro_proc).pr_fname; */
  @[args[1]->pr_fname] = count();
  self->interested = 0;
}

