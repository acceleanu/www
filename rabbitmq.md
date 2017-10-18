# RabbitMQ on my slackware box

- used sbopkg for installation
- had to create user and group as kindly suggested as part of the installation
- also it has a dependency on erlang so had to install that as well
- my attempt to start the server failed without any obvious sign of trouble:

```
bash-4.3$ rabbitmq-server 

              RabbitMQ 3.6.10. Copyright (C) 2007-2017 Pivotal Software, Inc.
  ##  ##      Licensed under the MPL.  See http://www.rabbitmq.com/
  ##  ##
  ##########  Logs: /var/log/rabbitmq/rabbit.log
  ######  ##        /var/log/rabbitmq/rabbit-sasl.log
  ##########
              Starting broker...


BOOT FAILED
===========

Error description:
   {could_not_start,rabbit,
       {error,
           {{shutdown,{failed_to_start_child,rabbit_epmd_monitor,badarg}},
            {child,undefined,rabbit_epmd_monitor_sup,
                {rabbit_restartable_sup,start_link,
                    [rabbit_epmd_monitor_sup,
                     {rabbit_epmd_monitor,start_link,[]},
                     false]},
                transient,infinity,supervisor,
                [rabbit_restartable_sup]}}}}

Log files (may contain more information):
   /var/log/rabbitmq/rabbit.log
   /var/log/rabbitmq/rabbit-sasl.log

{"init terminating in do_boot",{could_not_start,rabbit,{error,{{shutdown,{failed_to_start_child,rabbit_epmd_monitor,badarg}},{child,undefined,rabbit_epmd_monitor_sup,{rabbit_restartable_sup,start_link,[rabbit_epmd_monitor_sup,{rabbit_epmd_monitor,start_link,[]},false]},transient,infinity,supervisor,[rabbit_restartable_sup]}}}}}
init terminating in do_boot ()

Crash dump is being written to: erl_crash.dump...done
```
- in order to invstigate this I recall of an old trick I learned from Erik Forsberg (strace):

```
sh-4.3$ strace rabbitmq-server
execve("/usr/bin/rabbitmq-server", ["rabbitmq-server"], [/* 33 vars */]) = 0
brk(NULL)                               = 0xa059000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb76db000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=162900, ...}) = 0
mmap2(NULL, 162900, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76b3000
close(3)                                = 0
open("/lib/libtermcap.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10280, ...}) = 0
mmap2(NULL, 13192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb76af000
mmap2(0xb76b2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xb76b2000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\n\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=17408, ...}) = 0
mmap2(NULL, 16492, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb76aa000
mmap2(0xb76ad000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xb76ad000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\210\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1848528, ...}) = 0
mmap2(NULL, 1669660, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7512000
mprotect(0xb76a3000, 4096, PROT_NONE)   = 0
mmap2(0xb76a4000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x191000) = 0xb76a4000
mmap2(0xb76a7000, 10780, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76a7000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7511000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7510000
set_thread_area({entry_number:-1, base_addr:0xb7510700, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0 (entry_number:6)
mprotect(0xb76a4000, 8192, PROT_READ)   = 0
mprotect(0xb76ad000, 4096, PROT_READ)   = 0
mprotect(0x8138000, 4096, PROT_READ)    = 0
mprotect(0xb7705000, 4096, PROT_READ)   = 0
munmap(0xb76b3000, 162900)              = 0
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
brk(NULL)                               = 0xa059000
brk(0xa05a000)                          = 0xa05a000
brk(0xa05b000)                          = 0xa05b000
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2997, ...}) = 0
brk(0xa05d000)                          = 0xa05d000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2997
brk(0xa05e000)                          = 0xa05e000
brk(0xa05f000)                          = 0xa05f000
read(3, "", 4096)                       = 0
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_IDENTIFICATION", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=366, ...}) = 0
mmap2(NULL, 366, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76da000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MEASUREMENT", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=28, ...}) = 0
mmap2(NULL, 28, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d9000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_TELEPHONE", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64, ...}) = 0
mmap2(NULL, 64, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d8000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_ADDRESS", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=160, ...}) = 0
mmap2(NULL, 160, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d7000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_NAME", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=82, ...}) = 0
mmap2(NULL, 82, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d6000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_PAPER", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=39, ...}) = 0
mmap2(NULL, 39, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d5000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MESSAGES", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=62, ...}) = 0
mmap2(NULL, 62, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d4000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MONETARY", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=291, ...}) = 0
mmap2(NULL, 291, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d3000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_TIME", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2459, ...}) = 0
mmap2(NULL, 2459, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d2000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_NUMERIC", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=59, ...}) = 0
mmap2(NULL, 59, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76d1000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_CTYPE", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=273952, ...}) = 0
mmap2(NULL, 273952, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb74cd000
close(3)                                = 0
getuid32()                              = 1004
getgid32()                              = 1004
geteuid32()                             = 1004
getegid32()                             = 1004
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
sysinfo({uptime=98315, loads=[79936, 112512, 106624], totalram=1016412, freeram=53706, sharedram=33917, bufferram=58153, totalswap=1953023, freeswap=1937783, procs=410, totalhigh=806978, freehigh=10189, mem_unit=4096}) = 0
brk(0xa060000)                          = 0xa060000
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTART}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTART}, {SIG_DFL, [], SA_RESTART}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN, [], 0}, {SIG_DFL, [], 0}, 8) = 0
uname({sysname="Linux", nodename="14", ...}) = 0
brk(0xa061000)                          = 0xa061000
stat64("/var/lib/rabbitmq", {st_mode=S_IFDIR|0755, st_size=168, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=168, ...}) = 0
getpid()                                = 20297
brk(0xa062000)                          = 0xa062000
getppid()                               = 20295
brk(0xa063000)                          = 0xa063000
brk(0xa064000)                          = 0xa064000
getpgrp()                               = 20295
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {SIG_DFL, [], SA_RESTART}, 8) = 0
ugetrlimit(RLIMIT_NPROC, {rlim_cur=31756, rlim_max=31756}) = 0
brk(0xa065000)                          = 0xa065000
open("/usr/lib/locale/en_US/LC_COLLATE", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=19459, ...}) = 0
mmap2(NULL, 19459, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76cc000
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/usr/bin/rabbitmq-server", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, TCGETS, 0xbfa4ecdc)            = -1 ENOTTY (Inappropriate ioctl for device)
_llseek(3, 0, [0], SEEK_CUR)            = 0
read(3, "#!/bin/sh\n##  The contents of th"..., 80) = 80
_llseek(3, 0, [0], SEEK_SET)            = 0
ugetrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=4*1024}) = 0
fcntl64(255, F_GETFD)                   = -1 EBADF (Bad file descriptor)
dup2(3, 255)                            = 255
close(3)                                = 0
fcntl64(255, F_SETFD, FD_CLOEXEC)       = 0
fcntl64(255, F_GETFL)                   = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat64(255, {st_mode=S_IFREG|0755, st_size=10971, ...}) = 0
_llseek(255, 0, [0], SEEK_CUR)          = 0
brk(0xa067000)                          = 0xa067000
read(255, "#!/bin/sh\n##  The contents of th"..., 8176) = 8176
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=56095, ...}) = 0
brk(0xa069000)                          = 0xa069000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
brk(0xa06a000)                          = 0xa06a000
brk(0xa06b000)                          = 0xa06b000
read(3, "1002//\tJUS_I.B1.002//\nmodule\tJUS"..., 4096) = 4096
brk(0xa06c000)                          = 0xa06c000
brk(0xa06d000)                          = 0xa06d000
brk(0xa06e000)                          = 0xa06e000
read(3, "ISO-IR-110//\t\tISO-8859-4//\nalias"..., 4096) = 4096
brk(0xa06f000)                          = 0xa06f000
brk(0xa070000)                          = 0xa070000
brk(0xa071000)                          = 0xa071000
read(3, "\t\tISO-8859-14//\nalias\tISO_8859-1"..., 4096) = 4096
brk(0xa072000)                          = 0xa072000
brk(0xa073000)                          = 0xa073000
read(3, "IC-ES//\nalias\tEBCDICES//\t\tEBCDIC"..., 4096) = 4096
brk(0xa074000)                          = 0xa074000
brk(0xa075000)                          = 0xa075000
brk(0xa076000)                          = 0xa076000
read(3, "DIC-CP-ES//\t\tIBM284//\nalias\tCSIB"..., 4096) = 4096
brk(0xa077000)                          = 0xa077000
brk(0xa078000)                          = 0xa078000
brk(0xa079000)                          = 0xa079000
read(3, "//\nalias\tCSIBM864//\t\tIBM864//\nal"..., 4096) = 4096
brk(0xa07a000)                          = 0xa07a000
brk(0xa07b000)                          = 0xa07b000
brk(0xa07c000)                          = 0xa07c000
read(3, "BM939//\nmodule\tIBM939//\t\tINTERNA"..., 4096) = 4096
brk(0xa07d000)                          = 0xa07d000
brk(0xa07e000)                          = 0xa07e000
brk(0xa07f000)                          = 0xa07f000
read(3, "EUC-CN//\nalias\tCN-GB//\t\t\tEUC-CN/"..., 4096) = 4096
brk(0xa080000)                          = 0xa080000
brk(0xa081000)                          = 0xa081000
brk(0xa082000)                          = 0xa082000
read(3, "T//\nmodule\tISO-2022-CN-EXT//\tINT"..., 4096) = 4096
brk(0xa083000)                          = 0xa083000
brk(0xa084000)                          = 0xa084000
read(3, "//\t\tISO_5428//\nalias\tISO_5428:19"..., 4096) = 4096
brk(0xa085000)                          = 0xa085000
brk(0xa086000)                          = 0xa086000
brk(0xa087000)                          = 0xa087000
read(3, "CII-8\t1\n\n#\tfrom\t\t\tto\t\t\tmodule\t\tc"..., 4096) = 4096
brk(0xa088000)                          = 0xa088000
brk(0xa089000)                          = 0xa089000
brk(0xa08a000)                          = 0xa08a000
read(3, "\tfrom\t\t\tto\t\t\tmodule\t\tcost\nalias\t"..., 4096) = 4096
brk(0xa08b000)                          = 0xa08b000
brk(0xa08c000)                          = 0xa08c000
brk(0xa08d000)                          = 0xa08d000
read(3, "712//\t\tINTERNAL\t\tIBM12712\t\t1\nmod"..., 4096) = 2847
brk(0xa08e000)                          = 0xa08e000
read(3, "", 4096)                       = 0
close(3)                                = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\4\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=11408, ...}) = 0
brk(0xa08f000)                          = 0xa08f000
mmap2(NULL, 12324, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb76c8000
mmap2(0xb76ca000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xb76ca000
close(3)                                = 0
mprotect(0xb76ca000, 4096, PROT_READ)   = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -7335, [841], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20298
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/bin\n", 128)              = 9
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20298, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20298
waitpid(-1, 0xbfa4e2b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 9
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
open("/usr/bin/rabbitmq-env", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=12095, ...}) = 0
brk(0xa093000)                          = 0xa093000
read(3, "#!/bin/sh -e\n##  The contents of"..., 12095) = 12095
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0xa094000)                          = 0xa094000
lstat64("/usr/bin/rabbitmq-server", {st_mode=S_IFLNK|0777, st_size=61, ...}) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20299
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 64
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20299, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20299
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
lstat64("/usr/lib/erlang/lib/rabbitmq_server-3.6.10/sbin/rabbitmq-server", {st_mode=S_IFREG|0755, st_size=10971, ...}) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20301
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 48
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20301, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20301
waitpid(-1, 0xbfa4dbf8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0xa095000)                          = 0xa095000
brk(0xa096000)                          = 0xa096000
brk(0xa097000)                          = 0xa097000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20303
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 43
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20303, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20303
waitpid(-1, 0xbfa4dc38, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
open("/usr/lib/erlang/lib/rabbitmq_server-3.6.10/sbin/rabbitmq-defaults", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=1869, ...}) = 0
brk(0xa098000)                          = 0xa098000
read(3, "#!/bin/sh -e\n##  The contents of"..., 1869) = 1869
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/usr/lib/erlang/lib/rabbitmq_server-3.6.10/erlang.mk", 0xbfa4e1b0) = -1 ENOENT (No such file or directory)
stat64("/etc/rabbitmq/rabbitmq-env.conf", {st_mode=S_IFREG|0644, st_size=120, ...}) = 0
open("/etc/rabbitmq/rabbitmq-env.conf", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=120, ...}) = 0
read(3, "NODENAME=rabbit\nNODE_IP_ADDRESS="..., 120) = 120
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0xa099000)                          = 0xa099000
brk(0xa09a000)                          = 0xa09a000
brk(0xa09b000)                          = 0xa09b000
brk(0xa09c000)                          = 0xa09c000
brk(0xa09d000)                          = 0xa09d000
brk(0xa09e000)                          = 0xa09e000
brk(0xa09f000)                          = 0xa09f000
brk(0xa0a0000)                          = 0xa0a0000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20304
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/rabbitmq\n", 128) = 23
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20304, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20304
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20305
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/rabbitmq\n", 128) = 23
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20305, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20305
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20308
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20308, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20308
waitpid(-1, 0xbfa4d5f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq\n", 128)     = 18
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20309
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq\n", 128)     = 18
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20309, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20309
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20312
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia\n", 128) = 25
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20312, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20312
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20313
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia\n", 128) = 25
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20313, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20313
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20316
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit\n", 128) = 32
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20316, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20316
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20317
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit\n", 128) = 32
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20317, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20317
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20320
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit."..., 128) = 36
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20320, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20320
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20321
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit."..., 128) = 36
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20321, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20321
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20324
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit-"..., 128) = 47
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20324, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20324
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20325
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit-"..., 128) = 47
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20325, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20325
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20328
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20328, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20328
waitpid(-1, 0xbfa4d4f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/enabled_plugins\n", 128) = 30
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20329
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/enabled_plugins\n", 128) = 30
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20329, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20329
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20332
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 51
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20332, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20332
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20333
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 51
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20333, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20333
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0xa0a1000)                          = 0xa0a1000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20336
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit.log\n", 128) = 29
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20336, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20336
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20337
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit.log\n", 128) = 29
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20337, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20337
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20340
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit-sasl.lo"..., 128) = 34
read(3, "", 128)                        = 0
close(3)                                = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20340, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20340
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20341
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit-sasl.lo"..., 128) = 34
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20341, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20341
waitpid(-1, 0xbfa4d7b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20344
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit\n", 128) = 32
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20344, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20344
waitpid(-1, 0xbfa4d878, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20345
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/rabbitmq\n", 128) = 23
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20345, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20345
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20346
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/rabbitmq\n", 128) = 23
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20346, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20346
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20347
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq\n", 128)     = 18
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20347, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20347
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20348
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq\n", 128)     = 18
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20348, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20348
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20349
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit."..., 128) = 36
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20349, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20349
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20350
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit."..., 128) = 36
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20350, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20350
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20356
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit-"..., 128) = 47
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20356, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20356
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20357
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia/rabbit-"..., 128) = 47
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20357, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20357
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20358
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/enabled_plugins\n", 128) = 30
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20358, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20358
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20359
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/etc/rabbitmq/enabled_plugins\n", 128) = 30
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20359, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20359
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20360
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20360, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20360
waitpid(-1, 0xbfa4d5f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 51
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20361
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 51
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20361, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20361
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20362
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit.log\n", 128) = 29
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20362, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20362
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20363
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit.log\n", 128) = 29
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20363, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20363
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20369
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit-sasl.lo"..., 128) = 34
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20369, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20369
waitpid(-1, 0xbfa4d778, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20370
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/log/rabbitmq/rabbit-sasl.lo"..., 128) = 34
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20370, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20370
waitpid(-1, 0xbfa4d838, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0xa0a2000)                          = 0xa0a2000
brk(0xa0a3000)                          = 0xa0a3000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20376
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/usr/lib/erlang/lib/rabbitmq_ser"..., 128) = 51
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20376, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20376
waitpid(-1, 0xbfa4d8f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
stat64("/usr/lib/erlang/lib/rabbitmq_server-3.6.10/plugins", {st_mode=S_IFDIR|0755, st_size=1568, ...}) = 0
read(255, "\nRABBITMQ_START_RABBIT=\n[ \"x\" = "..., 8176) = 8176
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -6476, [2541], SEEK_CUR)   = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20379
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "Linux\n", 128)                 = 6
read(3, "", 128)                        = 0
close(3)                                = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20379, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20379
waitpid(-1, 0xbfa4e1f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20380
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x808b630, [], SA_RESTART}, {0x808b630, [], SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/var/lib/rabbitmq/mnesia\n", 128) = 25
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20380, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 20380
waitpid(-1, 0xbfa4db38, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 25
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=168, ...}) = 0
stat64("/usr/lib/go1.7.3/go/bin/mkdir", 0xbfa4e570) = -1 ENOENT (No such file or directory)
stat64("/usr/local/bin/mkdir", 0xbfa4e570) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/mkdir", X_OK)          = 0
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/mkdir", R_OK)          = 0
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/mkdir", X_OK)          = 0
stat64("/usr/bin/mkdir", {st_mode=S_IFREG|0755, st_size=38604, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/mkdir", R_OK)          = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20381
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 20381
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20381, si_uid=1004, si_status=0, si_utime=0, si_stime=0} ---
waitpid(-1, 0xbfa4deb8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
open("/var/lib/rabbitmq/mnesia/rabbit.pid", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
fcntl64(1, F_GETFD)                     = 0
fcntl64(1, F_DUPFD, 10)                 = 10
fcntl64(1, F_GETFD)                     = 0
fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
dup2(3, 1)                              = 1
close(3)                                = 0
write(1, "20297\n", 6)                  = 6
dup2(10, 1)                             = 1
fcntl64(10, F_GETFD)                    = 0x1 (flags FD_CLOEXEC)
close(10)                               = 0
read(255, "\nRABBITMQ_EBIN_ROOT=\"${RABBITMQ_"..., 8176) = 8176
stat64(".", {st_mode=S_IFDIR|0755, st_size=168, ...}) = 0
stat64("/usr/lib/go1.7.3/go/bin/erl", 0xbfa4ea50) = -1 ENOENT (No such file or directory)
stat64("/usr/local/bin/erl", 0xbfa4ea50) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/erl", X_OK)            = 0
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/erl", R_OK)            = 0
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/erl", X_OK)            = 0
stat64("/usr/bin/erl", {st_mode=S_IFREG|0755, st_size=848, ...}) = 0
geteuid32()                             = 1004
getegid32()                             = 1004
getuid32()                              = 1004
getgid32()                              = 1004
access("/usr/bin/erl", R_OK)            = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -7094, [3623], SEEK_CUR)   = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20382
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {SIG_DFL, [], 0}, 8) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 20382
rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20382, si_uid=1004, si_status=0, si_utime=21, si_stime=3} ---
waitpid(-1, 0xbfa4e3b8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
read(255, "\nPRELAUNCH_RESULT=$?\nif [ ${PREL"..., 8176) = 7348
stat64("/etc/rabbitmq/rabbitmq.config", 0xbfa4e9d0) = -1 ENOENT (No such file or directory)
rt_sigaction(SIGHUP, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGHUP, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP], [], 8) = 0
rt_sigaction(SIGHUP, {0x80a1150, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGTERM, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTERM, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [TERM], [], 8) = 0
rt_sigaction(SIGTERM, {0x80a1150, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGTSTP, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTSTP, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [TSTP], [], 8) = 0
rt_sigaction(SIGTSTP, {0x80a1150, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT], [], 8) = 0
rt_sigaction(SIGINT, {0x80a1150, [], 0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7510768) = 20411
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x80885d0, [], 0}, {0x80a1150, [], 0}, 8) = 0
waitpid(-1,
              RabbitMQ 3.6.10. Copyright (C) 2007-2017 Pivotal Software, Inc.
  ##  ##      Licensed under the MPL.  See http://www.rabbitmq.com/
  ##  ##
  ##########  Logs: /var/log/rabbitmq/rabbit.log
  ######  ##        /var/log/rabbitmq/rabbit-sasl.log
  ##########
              Starting broker...


BOOT FAILED
===========

Error description:
   {could_not_start,rabbit,
       {error,
           {{shutdown,{failed_to_start_child,rabbit_epmd_monitor,badarg}},
            {child,undefined,rabbit_epmd_monitor_sup,
                {rabbit_restartable_sup,start_link,
                    [rabbit_epmd_monitor_sup,
                     {rabbit_epmd_monitor,start_link,[]},
                     false]},
                transient,infinity,supervisor,
                [rabbit_restartable_sup]}}}}

Log files (may contain more information):
   /var/log/rabbitmq/rabbit.log
   /var/log/rabbitmq/rabbit-sasl.log

{"init terminating in do_boot",{could_not_start,rabbit,{error,{{shutdown,{failed_to_start_child,rabbit_epmd_monitor,badarg}},{child,undefined,rabbit_epmd_monitor_sup,{rabbit_restartable_sup,start_link,[rabbit_epmd_monitor_sup,{rabbit_epmd_monitor,start_link,[]},false]},transient,infinity,supervisor,[rabbit_restartable_sup]}}}}}
init terminating in do_boot ()

Crash dump is being written to: erl_crash.dump...done
[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 20411
rt_sigaction(SIGINT, {0x80a1150, [], 0}, {0x80885d0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=20411, si_uid=1004, si_status=1, si_utime=278, si_stime=494} ---
waitpid(-1, 0xbfa4ddf8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn({mask=[]})                    = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
read(255, "", 8176)                     = 0rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
exit_group(0)                           = ?
+++ exited with 0 +++

```

- the most interesting line above is the one that reads:
```
stat64("/etc/rabbitmq/rabbitmq.config", 0xbfa4e9d0) = -1 ENOENT (No such file or directory)
```
- so we do need to provide some config
- still getting the same failure after providing config:
```
cp /etc/rabbitmq/rabbitmq.config.example /etc/rabbitmq/rabbitmq.config
```
- the /etc/rabbitmq/rabbitmq-env.conf looks like:
```
NODENAME=rabbit
NODE_IP_ADDRESS=0.0.0.0
NODE_PORT=5672

LOG_BASE=/var/log/rabbitmq
MNESIA_BASE=/var/lib/rabbitmq/mnesia
```
- there seems to be a problem with the NODE* settings so need to remove them
- got the following error now:
```
ERROR: epmd error for host 14: badarg (unknown POSIX error)
```
- added a HOSTNAME setting and /etc/rabbitmq/rabbitmq-env.conf looks like this:
```
HOSTNAME=localhost

LOG_BASE=/var/log/rabbitmq
MNESIA_BASE=/var/lib/rabbitmq/mnesia
```
- successfully running the server now:
```
bash-4.3$ rabbitmq-server -detached
Warning: PID file not written; -detached was passed.
bash-4.3$ rabbitmqctl status
Status of node rabbit@localhost
[{pid,23685},
 {running_applications,
     [{rabbit,"RabbitMQ","3.6.10"},
      {rabbit_common,
          "Modules shared by rabbitmq-server and rabbitmq-erlang-client",
          "3.6.10"},
      {compiler,"ERTS  CXC 138 10","7.0.4"},
      {os_mon,"CPO  CXC 138 46","2.4.2"},
      {ranch,"Socket acceptor pool for TCP protocols.","1.3.0"},
      {ssl,"Erlang/OTP SSL application","8.1.1"},
      {xmerl,"XML parser","1.3.13"},
      {public_key,"Public key infrastructure","1.4"},
      {crypto,"CRYPTO","3.7.3"},
      {asn1,"The Erlang ASN1 compiler version 4.0.4","4.0.4"},
      {syntax_tools,"Syntax tools","2.1.1"},
      {mnesia,"MNESIA  CXC 138 12","4.14.3"},
      {sasl,"SASL  CXC 138 11","3.0.3"},
      {stdlib,"ERTS  CXC 138 10","3.3"},
      {kernel,"ERTS  CXC 138 10","5.2"}]},
 {os,{unix,linux}},
 {erlang_version,
     "Erlang/OTP 19 [erts-8.3] [source] [smp:4:4] [async-threads:64] [hipe] [kernel-poll:true]\n"},
 {memory,
     [{total,31321632},
      {connection_readers,0},
      {connection_writers,0},
      {connection_channels,0},
      {connection_other,0},
      {queue_procs,1452},
      {queue_slave_procs,0},
      {plugins,0},
      {other_proc,12547448},
      {mnesia,32864},
      {metrics,92812},
      {mgmt_db,0},
      {msg_index,21840},
      {other_ets,1081904},
      {binary,137624},
      {code,11402295},
      {atom,691713},
      {other_system,5403040}]},
 {alarms,[]},
 {listeners,[{clustering,25672,"::"},{amqp,5672,"0.0.0.0"}]},
 {vm_memory_high_watermark,0.4},
 {vm_memory_limit,858993459},
 {disk_free_limit,50000000},
 {disk_free,5226827776},
 {file_descriptors,
     [{total_limit,924},{total_used,2},{sockets_limit,829},{sockets_used,0}]},
 {processes,[{limit,1048576},{used,154}]},
 {run_queue,0},
 {uptime,12},
 {kernel,{net_ticktime,60}}]

```
- a useful link in the investigation has been:
 <https://stackoverflow.com/questions/45425286/rabbitmq-server-dont-start-unable-to-connect-to-epmd-ubuntu-16-04#45475646>

- enable the management plugin
```
 rabbitmq-plugins enable rabbitmq_management
```
- open http://localhost:15672 in the browser and login with guest/guest

