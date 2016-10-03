# mod_garbageman

## Overview
Sometimes Erlang can be a real jerk.  For instance, in version 16.09 of eJabberd
the garbage collector seems to never run when you need it, allowing RAM to spiral
out of control.  Moreover, in some production boxes we've seen it take over the
box until the OOM killer came along to kill it.

The `mod_garbageman` eJabberd module provides a function you can use along
with `mod_cron` to run garbage collection on a regular schedule.  Two functions
are provided.

**Collect/0**
Forces garbage collection on all processes.

**CollectTopN/1**
Forces garbage collection on only the largest N processes.

## Installation

To install in ejabberd:

```bash
cd ~/.ejabberd-modules/sources
git clone git@github.com:genexp/mod_garbageman.git
ejabberdctl module_install mod_message_truncate
ejabberdctl restart
```
