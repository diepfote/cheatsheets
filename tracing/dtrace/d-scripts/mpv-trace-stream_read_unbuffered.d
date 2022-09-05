#!/usr/bin/env dtrace  -s

/* taken from `Dtrace Review` by Brian Cantrill */
/* https://www.youtube.com/watch?v=TgmA48fILq8 */

#pragma D option flowindent

pid56141::stream_read_unbuffered:entry
{
  /* thread local var */
  self->follow = 1;
}


/* light up the entire process
 * will take forever on startup and shutdown */
pid56141:::entry,
pid56141:::return
/self->follow/
{}

pid56141::stream_read_unbuffered:return
{
  self->follow=0;
}
