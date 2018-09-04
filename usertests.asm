
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 3e 4d 00 00       	push   $0x4d3e
      16:	6a 01                	push   $0x1
      18:	e8 13 3a 00 00       	call   3a30 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 52 4d 00 00       	push   $0x4d52
      26:	e8 d7 38 00 00       	call   3902 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 bc 54 00 00       	push   $0x54bc
      3a:	6a 01                	push   $0x1
      3c:	e8 ef 39 00 00       	call   3a30 <printf>
    exit();
      41:	e8 7c 38 00 00       	call   38c2 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 52 4d 00 00       	push   $0x4d52
      52:	e8 ab 38 00 00       	call   3902 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 8b 38 00 00       	call   38ea <close>

  argptest();
      5f:	e8 8c 35 00 00       	call   35f0 <argptest>
  createdelete();
      64:	e8 97 11 00 00       	call   1200 <createdelete>
  linkunlink();
      69:	e8 52 1a 00 00       	call   1ac0 <linkunlink>
  concreate();
      6e:	e8 3d 17 00 00       	call   17b0 <concreate>
  fourfiles();
      73:	e8 98 0f 00 00       	call   1010 <fourfiles>
  sharedfd();
      78:	e8 d3 0d 00 00       	call   e50 <sharedfd>

  bigargtest();
      7d:	e8 0e 32 00 00       	call   3290 <bigargtest>
  bigwrite();
      82:	e8 59 23 00 00       	call   23e0 <bigwrite>
  bigargtest();
      87:	e8 04 32 00 00       	call   3290 <bigargtest>
  bsstest();
      8c:	e8 7f 31 00 00       	call   3210 <bsstest>
  sbrktest();
      91:	e8 9a 2c 00 00       	call   2d30 <sbrktest>
  validatetest();
      96:	e8 c5 30 00 00       	call   3160 <validatetest>

  opentest();
      9b:	e8 50 03 00 00       	call   3f0 <opentest>
  writetest();
      a0:	e8 db 03 00 00       	call   480 <writetest>
  writetest1();
      a5:	e8 b6 05 00 00       	call   660 <writetest1>
  createtest();
      aa:	e8 81 07 00 00       	call   830 <createtest>

  openiputtest();
      af:	e8 3c 02 00 00       	call   2f0 <openiputtest>
  exitiputtest();
      b4:	e8 47 01 00 00       	call   200 <exitiputtest>
  iputtest();
      b9:	e8 62 00 00 00       	call   120 <iputtest>

  mem();
      be:	e8 bd 0c 00 00       	call   d80 <mem>
  pipe1();
      c3:	e8 48 09 00 00       	call   a10 <pipe1>
  preempt();
      c8:	e8 e3 0a 00 00       	call   bb0 <preempt>
  exitwait();
      cd:	e8 1e 0c 00 00       	call   cf0 <exitwait>

  rmdot();
      d2:	e8 f9 26 00 00       	call   27d0 <rmdot>
  fourteen();
      d7:	e8 b4 25 00 00       	call   2690 <fourteen>
  bigfile();
      dc:	e8 df 23 00 00       	call   24c0 <bigfile>
  subdir();
      e1:	e8 1a 1c 00 00       	call   1d00 <subdir>
  linktest();
      e6:	e8 b5 14 00 00       	call   15a0 <linktest>
  unlinkread();
      eb:	e8 20 13 00 00       	call   1410 <unlinkread>
  dirfile();
      f0:	e8 5b 28 00 00       	call   2950 <dirfile>
  iref();
      f5:	e8 56 2a 00 00       	call   2b50 <iref>
  forktest();
      fa:	e8 71 2b 00 00       	call   2c70 <forktest>
  bigdir(); // slow
      ff:	e8 cc 1a 00 00       	call   1bd0 <bigdir>

  uio();
     104:	e8 77 34 00 00       	call   3580 <uio>

  exectest();
     109:	e8 b2 08 00 00       	call   9c0 <exectest>

  exit();
     10e:	e8 af 37 00 00       	call   38c2 <exit>
     113:	66 90                	xchg   %ax,%ax
     115:	66 90                	xchg   %ax,%ax
     117:	66 90                	xchg   %ax,%ax
     119:	66 90                	xchg   %ax,%ax
     11b:	66 90                	xchg   %ax,%ax
     11d:	66 90                	xchg   %ax,%ax
     11f:	90                   	nop

00000120 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     126:	68 e4 3d 00 00       	push   $0x3de4
     12b:	ff 35 e8 5d 00 00    	pushl  0x5de8
     131:	e8 fa 38 00 00       	call   3a30 <printf>

  if(mkdir("iputdir") < 0){
     136:	c7 04 24 77 3d 00 00 	movl   $0x3d77,(%esp)
     13d:	e8 e8 37 00 00       	call   392a <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 77 3d 00 00       	push   $0x3d77
     151:	e8 dc 37 00 00       	call   3932 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 74 3d 00 00       	push   $0x3d74
     169:	e8 a4 37 00 00       	call   3912 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 99 3d 00 00       	push   $0x3d99
     17d:	e8 b0 37 00 00       	call   3932 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 1c 3e 00 00       	push   $0x3e1c
     191:	ff 35 e8 5d 00 00    	pushl  0x5de8
     197:	e8 94 38 00 00       	call   3a30 <printf>
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 50 3d 00 00       	push   $0x3d50
     1a8:	ff 35 e8 5d 00 00    	pushl  0x5de8
     1ae:	e8 7d 38 00 00       	call   3a30 <printf>
    exit();
     1b3:	e8 0a 37 00 00       	call   38c2 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 9b 3d 00 00       	push   $0x3d9b
     1bf:	ff 35 e8 5d 00 00    	pushl  0x5de8
     1c5:	e8 66 38 00 00       	call   3a30 <printf>
    exit();
     1ca:	e8 f3 36 00 00       	call   38c2 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 7f 3d 00 00       	push   $0x3d7f
     1d6:	ff 35 e8 5d 00 00    	pushl  0x5de8
     1dc:	e8 4f 38 00 00       	call   3a30 <printf>
    exit();
     1e1:	e8 dc 36 00 00       	call   38c2 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 5e 3d 00 00       	push   $0x3d5e
     1ed:	ff 35 e8 5d 00 00    	pushl  0x5de8
     1f3:	e8 38 38 00 00       	call   3a30 <printf>
    exit();
     1f8:	e8 c5 36 00 00       	call   38c2 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     206:	68 ab 3d 00 00       	push   $0x3dab
     20b:	ff 35 e8 5d 00 00    	pushl  0x5de8
     211:	e8 1a 38 00 00       	call   3a30 <printf>

  pid = fork();
     216:	e8 9f 36 00 00       	call   38ba <fork>
  if(pid < 0){
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 82 00 00 00    	js     2a8 <exitiputtest+0xa8>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     226:	75 48                	jne    270 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 77 3d 00 00       	push   $0x3d77
     230:	e8 f5 36 00 00       	call   392a <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 96 00 00 00    	js     2d6 <exitiputtest+0xd6>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 77 3d 00 00       	push   $0x3d77
     248:	e8 e5 36 00 00       	call   3932 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	78 6b                	js     2bf <exitiputtest+0xbf>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	68 74 3d 00 00       	push   $0x3d74
     25c:	e8 b1 36 00 00       	call   3912 <unlink>
     261:	83 c4 10             	add    $0x10,%esp
     264:	85 c0                	test   %eax,%eax
     266:	78 28                	js     290 <exitiputtest+0x90>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     268:	e8 55 36 00 00       	call   38c2 <exit>
     26d:	8d 76 00             	lea    0x0(%esi),%esi
  }
  wait();
     270:	e8 55 36 00 00       	call   38ca <wait>
  printf(stdout, "exitiput test ok\n");
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 ce 3d 00 00       	push   $0x3dce
     27d:	ff 35 e8 5d 00 00    	pushl  0x5de8
     283:	e8 a8 37 00 00       	call   3a30 <printf>
}
     288:	83 c4 10             	add    $0x10,%esp
     28b:	c9                   	leave  
     28c:	c3                   	ret    
     28d:	8d 76 00             	lea    0x0(%esi),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 7f 3d 00 00       	push   $0x3d7f
     298:	ff 35 e8 5d 00 00    	pushl  0x5de8
     29e:	e8 8d 37 00 00       	call   3a30 <printf>
      exit();
     2a3:	e8 1a 36 00 00       	call   38c2 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     2a8:	51                   	push   %ecx
     2a9:	51                   	push   %ecx
     2aa:	68 91 4c 00 00       	push   $0x4c91
     2af:	ff 35 e8 5d 00 00    	pushl  0x5de8
     2b5:	e8 76 37 00 00       	call   3a30 <printf>
    exit();
     2ba:	e8 03 36 00 00       	call   38c2 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2bf:	50                   	push   %eax
     2c0:	50                   	push   %eax
     2c1:	68 ba 3d 00 00       	push   $0x3dba
     2c6:	ff 35 e8 5d 00 00    	pushl  0x5de8
     2cc:	e8 5f 37 00 00       	call   3a30 <printf>
      exit();
     2d1:	e8 ec 35 00 00       	call   38c2 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2d6:	52                   	push   %edx
     2d7:	52                   	push   %edx
     2d8:	68 50 3d 00 00       	push   $0x3d50
     2dd:	ff 35 e8 5d 00 00    	pushl  0x5de8
     2e3:	e8 48 37 00 00       	call   3a30 <printf>
      exit();
     2e8:	e8 d5 35 00 00       	call   38c2 <exit>
     2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     2f6:	68 e0 3d 00 00       	push   $0x3de0
     2fb:	ff 35 e8 5d 00 00    	pushl  0x5de8
     301:	e8 2a 37 00 00       	call   3a30 <printf>
  if(mkdir("oidir") < 0){
     306:	c7 04 24 ef 3d 00 00 	movl   $0x3def,(%esp)
     30d:	e8 18 36 00 00       	call   392a <mkdir>
     312:	83 c4 10             	add    $0x10,%esp
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 88 00 00 00    	js     3a5 <openiputtest+0xb5>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     31d:	e8 98 35 00 00       	call   38ba <fork>
  if(pid < 0){
     322:	85 c0                	test   %eax,%eax
     324:	0f 88 92 00 00 00    	js     3bc <openiputtest+0xcc>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     32a:	75 34                	jne    360 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     32c:	83 ec 08             	sub    $0x8,%esp
     32f:	6a 02                	push   $0x2
     331:	68 ef 3d 00 00       	push   $0x3def
     336:	e8 c7 35 00 00       	call   3902 <open>
    if(fd >= 0){
     33b:	83 c4 10             	add    $0x10,%esp
     33e:	85 c0                	test   %eax,%eax
     340:	78 5e                	js     3a0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     342:	83 ec 08             	sub    $0x8,%esp
     345:	68 74 4d 00 00       	push   $0x4d74
     34a:	ff 35 e8 5d 00 00    	pushl  0x5de8
     350:	e8 db 36 00 00       	call   3a30 <printf>
      exit();
     355:	e8 68 35 00 00       	call   38c2 <exit>
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
    exit();
  }
  sleep(1);
     360:	83 ec 0c             	sub    $0xc,%esp
     363:	6a 01                	push   $0x1
     365:	e8 00 36 00 00       	call   396a <sleep>
  if(unlink("oidir") != 0){
     36a:	c7 04 24 ef 3d 00 00 	movl   $0x3def,(%esp)
     371:	e8 9c 35 00 00       	call   3912 <unlink>
     376:	83 c4 10             	add    $0x10,%esp
     379:	85 c0                	test   %eax,%eax
     37b:	75 56                	jne    3d3 <openiputtest+0xe3>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     37d:	e8 48 35 00 00       	call   38ca <wait>
  printf(stdout, "openiput test ok\n");
     382:	83 ec 08             	sub    $0x8,%esp
     385:	68 18 3e 00 00       	push   $0x3e18
     38a:	ff 35 e8 5d 00 00    	pushl  0x5de8
     390:	e8 9b 36 00 00       	call   3a30 <printf>
     395:	83 c4 10             	add    $0x10,%esp
}
     398:	c9                   	leave  
     399:	c3                   	ret    
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit();
    }
    exit();
     3a0:	e8 1d 35 00 00       	call   38c2 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     3a5:	51                   	push   %ecx
     3a6:	51                   	push   %ecx
     3a7:	68 f5 3d 00 00       	push   $0x3df5
     3ac:	ff 35 e8 5d 00 00    	pushl  0x5de8
     3b2:	e8 79 36 00 00       	call   3a30 <printf>
    exit();
     3b7:	e8 06 35 00 00       	call   38c2 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3bc:	52                   	push   %edx
     3bd:	52                   	push   %edx
     3be:	68 91 4c 00 00       	push   $0x4c91
     3c3:	ff 35 e8 5d 00 00    	pushl  0x5de8
     3c9:	e8 62 36 00 00       	call   3a30 <printf>
    exit();
     3ce:	e8 ef 34 00 00       	call   38c2 <exit>
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     3d3:	50                   	push   %eax
     3d4:	50                   	push   %eax
     3d5:	68 09 3e 00 00       	push   $0x3e09
     3da:	ff 35 e8 5d 00 00    	pushl  0x5de8
     3e0:	e8 4b 36 00 00       	call   3a30 <printf>
    exit();
     3e5:	e8 d8 34 00 00       	call   38c2 <exit>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <opentest>:

// simple file system tests

void
opentest(void)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     3f6:	68 2a 3e 00 00       	push   $0x3e2a
     3fb:	ff 35 e8 5d 00 00    	pushl  0x5de8
     401:	e8 2a 36 00 00       	call   3a30 <printf>
  fd = open("echo", 0);
     406:	58                   	pop    %eax
     407:	5a                   	pop    %edx
     408:	6a 00                	push   $0x0
     40a:	68 35 3e 00 00       	push   $0x3e35
     40f:	e8 ee 34 00 00       	call   3902 <open>
  if(fd < 0){
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	78 36                	js     451 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	50                   	push   %eax
     41f:	e8 c6 34 00 00       	call   38ea <close>
  fd = open("doesnotexist", 0);
     424:	5a                   	pop    %edx
     425:	59                   	pop    %ecx
     426:	6a 00                	push   $0x0
     428:	68 4d 3e 00 00       	push   $0x3e4d
     42d:	e8 d0 34 00 00       	call   3902 <open>
  if(fd >= 0){
     432:	83 c4 10             	add    $0x10,%esp
     435:	85 c0                	test   %eax,%eax
     437:	79 2f                	jns    468 <opentest+0x78>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     439:	83 ec 08             	sub    $0x8,%esp
     43c:	68 78 3e 00 00       	push   $0x3e78
     441:	ff 35 e8 5d 00 00    	pushl  0x5de8
     447:	e8 e4 35 00 00       	call   3a30 <printf>
}
     44c:	83 c4 10             	add    $0x10,%esp
     44f:	c9                   	leave  
     450:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     451:	50                   	push   %eax
     452:	50                   	push   %eax
     453:	68 3a 3e 00 00       	push   $0x3e3a
     458:	ff 35 e8 5d 00 00    	pushl  0x5de8
     45e:	e8 cd 35 00 00       	call   3a30 <printf>
    exit();
     463:	e8 5a 34 00 00       	call   38c2 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     468:	50                   	push   %eax
     469:	50                   	push   %eax
     46a:	68 5a 3e 00 00       	push   $0x3e5a
     46f:	ff 35 e8 5d 00 00    	pushl  0x5de8
     475:	e8 b6 35 00 00       	call   3a30 <printf>
    exit();
     47a:	e8 43 34 00 00       	call   38c2 <exit>
     47f:	90                   	nop

00000480 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     485:	83 ec 08             	sub    $0x8,%esp
     488:	68 86 3e 00 00       	push   $0x3e86
     48d:	ff 35 e8 5d 00 00    	pushl  0x5de8
     493:	e8 98 35 00 00       	call   3a30 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     498:	59                   	pop    %ecx
     499:	5b                   	pop    %ebx
     49a:	68 02 02 00 00       	push   $0x202
     49f:	68 97 3e 00 00       	push   $0x3e97
     4a4:	e8 59 34 00 00       	call   3902 <open>
  if(fd >= 0){
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	0f 88 8b 01 00 00    	js     63f <writetest+0x1bf>
    printf(stdout, "creat small succeeded; ok\n");
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	89 c6                	mov    %eax,%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4b9:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
     4bb:	68 9d 3e 00 00       	push   $0x3e9d
     4c0:	ff 35 e8 5d 00 00    	pushl  0x5de8
     4c6:	e8 65 35 00 00       	call   3a30 <printf>
     4cb:	83 c4 10             	add    $0x10,%esp
     4ce:	66 90                	xchg   %ax,%ax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d0:	83 ec 04             	sub    $0x4,%esp
     4d3:	6a 0a                	push   $0xa
     4d5:	68 d4 3e 00 00       	push   $0x3ed4
     4da:	56                   	push   %esi
     4db:	e8 02 34 00 00       	call   38e2 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d9 00 00 00    	jne    5c5 <writetest+0x145>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4ec:	83 ec 04             	sub    $0x4,%esp
     4ef:	6a 0a                	push   $0xa
     4f1:	68 df 3e 00 00       	push   $0x3edf
     4f6:	56                   	push   %esi
     4f7:	e8 e6 33 00 00       	call   38e2 <write>
     4fc:	83 c4 10             	add    $0x10,%esp
     4ff:	83 f8 0a             	cmp    $0xa,%eax
     502:	0f 85 d6 00 00 00    	jne    5de <writetest+0x15e>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     508:	83 c3 01             	add    $0x1,%ebx
     50b:	83 fb 64             	cmp    $0x64,%ebx
     50e:	75 c0                	jne    4d0 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     510:	83 ec 08             	sub    $0x8,%esp
     513:	68 ea 3e 00 00       	push   $0x3eea
     518:	ff 35 e8 5d 00 00    	pushl  0x5de8
     51e:	e8 0d 35 00 00       	call   3a30 <printf>
  close(fd);
     523:	89 34 24             	mov    %esi,(%esp)
     526:	e8 bf 33 00 00       	call   38ea <close>
  fd = open("small", O_RDONLY);
     52b:	58                   	pop    %eax
     52c:	5a                   	pop    %edx
     52d:	6a 00                	push   $0x0
     52f:	68 97 3e 00 00       	push   $0x3e97
     534:	e8 c9 33 00 00       	call   3902 <open>
  if(fd >= 0){
     539:	83 c4 10             	add    $0x10,%esp
     53c:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     53e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     540:	0f 88 b1 00 00 00    	js     5f7 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     546:	83 ec 08             	sub    $0x8,%esp
     549:	68 f5 3e 00 00       	push   $0x3ef5
     54e:	ff 35 e8 5d 00 00    	pushl  0x5de8
     554:	e8 d7 34 00 00       	call   3a30 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     559:	83 c4 0c             	add    $0xc,%esp
     55c:	68 d0 07 00 00       	push   $0x7d0
     561:	68 c0 85 00 00       	push   $0x85c0
     566:	53                   	push   %ebx
     567:	e8 6e 33 00 00       	call   38da <read>
  if(i == 2000){
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     574:	0f 85 95 00 00 00    	jne    60f <writetest+0x18f>
    printf(stdout, "read succeeded ok\n");
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	68 29 3f 00 00       	push   $0x3f29
     582:	ff 35 e8 5d 00 00    	pushl  0x5de8
     588:	e8 a3 34 00 00       	call   3a30 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     58d:	89 1c 24             	mov    %ebx,(%esp)
     590:	e8 55 33 00 00       	call   38ea <close>

  if(unlink("small") < 0){
     595:	c7 04 24 97 3e 00 00 	movl   $0x3e97,(%esp)
     59c:	e8 71 33 00 00       	call   3912 <unlink>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	85 c0                	test   %eax,%eax
     5a6:	78 7f                	js     627 <writetest+0x1a7>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     5a8:	83 ec 08             	sub    $0x8,%esp
     5ab:	68 51 3f 00 00       	push   $0x3f51
     5b0:	ff 35 e8 5d 00 00    	pushl  0x5de8
     5b6:	e8 75 34 00 00       	call   3a30 <printf>
}
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5c1:	5b                   	pop    %ebx
     5c2:	5e                   	pop    %esi
     5c3:	5d                   	pop    %ebp
     5c4:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     5c5:	83 ec 04             	sub    $0x4,%esp
     5c8:	53                   	push   %ebx
     5c9:	68 98 4d 00 00       	push   $0x4d98
     5ce:	ff 35 e8 5d 00 00    	pushl  0x5de8
     5d4:	e8 57 34 00 00       	call   3a30 <printf>
      exit();
     5d9:	e8 e4 32 00 00       	call   38c2 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     5de:	83 ec 04             	sub    $0x4,%esp
     5e1:	53                   	push   %ebx
     5e2:	68 bc 4d 00 00       	push   $0x4dbc
     5e7:	ff 35 e8 5d 00 00    	pushl  0x5de8
     5ed:	e8 3e 34 00 00       	call   3a30 <printf>
      exit();
     5f2:	e8 cb 32 00 00       	call   38c2 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     5f7:	83 ec 08             	sub    $0x8,%esp
     5fa:	68 0e 3f 00 00       	push   $0x3f0e
     5ff:	ff 35 e8 5d 00 00    	pushl  0x5de8
     605:	e8 26 34 00 00       	call   3a30 <printf>
    exit();
     60a:	e8 b3 32 00 00       	call   38c2 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 55 42 00 00       	push   $0x4255
     617:	ff 35 e8 5d 00 00    	pushl  0x5de8
     61d:	e8 0e 34 00 00       	call   3a30 <printf>
    exit();
     622:	e8 9b 32 00 00       	call   38c2 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     627:	83 ec 08             	sub    $0x8,%esp
     62a:	68 3c 3f 00 00       	push   $0x3f3c
     62f:	ff 35 e8 5d 00 00    	pushl  0x5de8
     635:	e8 f6 33 00 00       	call   3a30 <printf>
    exit();
     63a:	e8 83 32 00 00       	call   38c2 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     63f:	83 ec 08             	sub    $0x8,%esp
     642:	68 b8 3e 00 00       	push   $0x3eb8
     647:	ff 35 e8 5d 00 00    	pushl  0x5de8
     64d:	e8 de 33 00 00       	call   3a30 <printf>
    exit();
     652:	e8 6b 32 00 00       	call   38c2 <exit>
     657:	89 f6                	mov    %esi,%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	56                   	push   %esi
     664:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     665:	83 ec 08             	sub    $0x8,%esp
     668:	68 65 3f 00 00       	push   $0x3f65
     66d:	ff 35 e8 5d 00 00    	pushl  0x5de8
     673:	e8 b8 33 00 00       	call   3a30 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     678:	59                   	pop    %ecx
     679:	5b                   	pop    %ebx
     67a:	68 02 02 00 00       	push   $0x202
     67f:	68 df 3f 00 00       	push   $0x3fdf
     684:	e8 79 32 00 00       	call   3902 <open>
  if(fd < 0){
     689:	83 c4 10             	add    $0x10,%esp
     68c:	85 c0                	test   %eax,%eax
     68e:	0f 88 64 01 00 00    	js     7f8 <writetest1+0x198>
     694:	89 c6                	mov    %eax,%esi
     696:	31 db                	xor    %ebx,%ebx
     698:	90                   	nop
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
     6a0:	83 ec 04             	sub    $0x4,%esp
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     6a3:	89 1d c0 85 00 00    	mov    %ebx,0x85c0
    if(write(fd, buf, 512) != 512){
     6a9:	68 00 02 00 00       	push   $0x200
     6ae:	68 c0 85 00 00       	push   $0x85c0
     6b3:	56                   	push   %esi
     6b4:	e8 29 32 00 00       	call   38e2 <write>
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c1:	0f 85 b3 00 00 00    	jne    77a <writetest1+0x11a>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     6c7:	83 c3 01             	add    $0x1,%ebx
     6ca:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6d0:	75 ce                	jne    6a0 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     6d2:	83 ec 0c             	sub    $0xc,%esp
     6d5:	56                   	push   %esi
     6d6:	e8 0f 32 00 00       	call   38ea <close>

  fd = open("big", O_RDONLY);
     6db:	58                   	pop    %eax
     6dc:	5a                   	pop    %edx
     6dd:	6a 00                	push   $0x0
     6df:	68 df 3f 00 00       	push   $0x3fdf
     6e4:	e8 19 32 00 00       	call   3902 <open>
  if(fd < 0){
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     6ee:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6f0:	0f 88 ea 00 00 00    	js     7e0 <writetest1+0x180>
     6f6:	31 db                	xor    %ebx,%ebx
     6f8:	eb 1d                	jmp    717 <writetest1+0xb7>
     6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     700:	3d 00 02 00 00       	cmp    $0x200,%eax
     705:	0f 85 9f 00 00 00    	jne    7aa <writetest1+0x14a>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     70b:	a1 c0 85 00 00       	mov    0x85c0,%eax
     710:	39 c3                	cmp    %eax,%ebx
     712:	75 7f                	jne    793 <writetest1+0x133>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     714:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     717:	83 ec 04             	sub    $0x4,%esp
     71a:	68 00 02 00 00       	push   $0x200
     71f:	68 c0 85 00 00       	push   $0x85c0
     724:	56                   	push   %esi
     725:	e8 b0 31 00 00       	call   38da <read>
    if(i == 0){
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	85 c0                	test   %eax,%eax
     72f:	75 cf                	jne    700 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     731:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     737:	0f 84 86 00 00 00    	je     7c3 <writetest1+0x163>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     73d:	83 ec 0c             	sub    $0xc,%esp
     740:	56                   	push   %esi
     741:	e8 a4 31 00 00       	call   38ea <close>
  if(unlink("big") < 0){
     746:	c7 04 24 df 3f 00 00 	movl   $0x3fdf,(%esp)
     74d:	e8 c0 31 00 00       	call   3912 <unlink>
     752:	83 c4 10             	add    $0x10,%esp
     755:	85 c0                	test   %eax,%eax
     757:	0f 88 b3 00 00 00    	js     810 <writetest1+0x1b0>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 06 40 00 00       	push   $0x4006
     765:	ff 35 e8 5d 00 00    	pushl  0x5de8
     76b:	e8 c0 32 00 00       	call   3a30 <printf>
}
     770:	83 c4 10             	add    $0x10,%esp
     773:	8d 65 f8             	lea    -0x8(%ebp),%esp
     776:	5b                   	pop    %ebx
     777:	5e                   	pop    %esi
     778:	5d                   	pop    %ebp
     779:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     77a:	83 ec 04             	sub    $0x4,%esp
     77d:	53                   	push   %ebx
     77e:	68 8f 3f 00 00       	push   $0x3f8f
     783:	ff 35 e8 5d 00 00    	pushl  0x5de8
     789:	e8 a2 32 00 00       	call   3a30 <printf>
      exit();
     78e:	e8 2f 31 00 00       	call   38c2 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     793:	50                   	push   %eax
     794:	53                   	push   %ebx
     795:	68 e0 4d 00 00       	push   $0x4de0
     79a:	ff 35 e8 5d 00 00    	pushl  0x5de8
     7a0:	e8 8b 32 00 00       	call   3a30 <printf>
             n, ((int*)buf)[0]);
      exit();
     7a5:	e8 18 31 00 00       	call   38c2 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	50                   	push   %eax
     7ae:	68 e3 3f 00 00       	push   $0x3fe3
     7b3:	ff 35 e8 5d 00 00    	pushl  0x5de8
     7b9:	e8 72 32 00 00       	call   3a30 <printf>
      exit();
     7be:	e8 ff 30 00 00       	call   38c2 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     7c3:	83 ec 04             	sub    $0x4,%esp
     7c6:	68 8b 00 00 00       	push   $0x8b
     7cb:	68 c6 3f 00 00       	push   $0x3fc6
     7d0:	ff 35 e8 5d 00 00    	pushl  0x5de8
     7d6:	e8 55 32 00 00       	call   3a30 <printf>
        exit();
     7db:	e8 e2 30 00 00       	call   38c2 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     7e0:	83 ec 08             	sub    $0x8,%esp
     7e3:	68 ad 3f 00 00       	push   $0x3fad
     7e8:	ff 35 e8 5d 00 00    	pushl  0x5de8
     7ee:	e8 3d 32 00 00       	call   3a30 <printf>
    exit();
     7f3:	e8 ca 30 00 00       	call   38c2 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     7f8:	83 ec 08             	sub    $0x8,%esp
     7fb:	68 75 3f 00 00       	push   $0x3f75
     800:	ff 35 e8 5d 00 00    	pushl  0x5de8
     806:	e8 25 32 00 00       	call   3a30 <printf>
    exit();
     80b:	e8 b2 30 00 00       	call   38c2 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     810:	83 ec 08             	sub    $0x8,%esp
     813:	68 f3 3f 00 00       	push   $0x3ff3
     818:	ff 35 e8 5d 00 00    	pushl  0x5de8
     81e:	e8 0d 32 00 00       	call   3a30 <printf>
    exit();
     823:	e8 9a 30 00 00       	call   38c2 <exit>
     828:	90                   	nop
     829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000830 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     834:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     839:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     83c:	68 00 4e 00 00       	push   $0x4e00
     841:	ff 35 e8 5d 00 00    	pushl  0x5de8
     847:	e8 e4 31 00 00       	call   3a30 <printf>

  name[0] = 'a';
     84c:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
  name[2] = '\0';
     853:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     85a:	83 c4 10             	add    $0x10,%esp
     85d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     860:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     863:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     869:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     86c:	68 02 02 00 00       	push   $0x202
     871:	68 c0 a5 00 00       	push   $0xa5c0
     876:	e8 87 30 00 00       	call   3902 <open>
    close(fd);
     87b:	89 04 24             	mov    %eax,(%esp)
     87e:	e8 67 30 00 00       	call   38ea <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     883:	83 c4 10             	add    $0x10,%esp
     886:	80 fb 64             	cmp    $0x64,%bl
     889:	75 d5                	jne    860 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     88b:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
  name[2] = '\0';
     892:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     899:	bb 30 00 00 00       	mov    $0x30,%ebx
     89e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    unlink(name);
     8a0:	83 ec 0c             	sub    $0xc,%esp
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     8a3:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     8a9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8ac:	68 c0 a5 00 00       	push   $0xa5c0
     8b1:	e8 5c 30 00 00       	call   3912 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	80 fb 64             	cmp    $0x64,%bl
     8bc:	75 e2                	jne    8a0 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     8be:	83 ec 08             	sub    $0x8,%esp
     8c1:	68 28 4e 00 00       	push   $0x4e28
     8c6:	ff 35 e8 5d 00 00    	pushl  0x5de8
     8cc:	e8 5f 31 00 00       	call   3a30 <printf>
}
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d7:	c9                   	leave  
     8d8:	c3                   	ret    
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <dirtest>:

void dirtest(void)
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8e6:	68 14 40 00 00       	push   $0x4014
     8eb:	ff 35 e8 5d 00 00    	pushl  0x5de8
     8f1:	e8 3a 31 00 00       	call   3a30 <printf>

  if(mkdir("dir0") < 0){
     8f6:	c7 04 24 20 40 00 00 	movl   $0x4020,(%esp)
     8fd:	e8 28 30 00 00       	call   392a <mkdir>
     902:	83 c4 10             	add    $0x10,%esp
     905:	85 c0                	test   %eax,%eax
     907:	78 58                	js     961 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	68 20 40 00 00       	push   $0x4020
     911:	e8 1c 30 00 00       	call   3932 <chdir>
     916:	83 c4 10             	add    $0x10,%esp
     919:	85 c0                	test   %eax,%eax
     91b:	0f 88 85 00 00 00    	js     9a6 <dirtest+0xc6>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	68 c5 45 00 00       	push   $0x45c5
     929:	e8 04 30 00 00       	call   3932 <chdir>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	78 5a                	js     98f <dirtest+0xaf>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     935:	83 ec 0c             	sub    $0xc,%esp
     938:	68 20 40 00 00       	push   $0x4020
     93d:	e8 d0 2f 00 00       	call   3912 <unlink>
     942:	83 c4 10             	add    $0x10,%esp
     945:	85 c0                	test   %eax,%eax
     947:	78 2f                	js     978 <dirtest+0x98>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     949:	83 ec 08             	sub    $0x8,%esp
     94c:	68 5d 40 00 00       	push   $0x405d
     951:	ff 35 e8 5d 00 00    	pushl  0x5de8
     957:	e8 d4 30 00 00       	call   3a30 <printf>
}
     95c:	83 c4 10             	add    $0x10,%esp
     95f:	c9                   	leave  
     960:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     961:	50                   	push   %eax
     962:	50                   	push   %eax
     963:	68 50 3d 00 00       	push   $0x3d50
     968:	ff 35 e8 5d 00 00    	pushl  0x5de8
     96e:	e8 bd 30 00 00       	call   3a30 <printf>
    exit();
     973:	e8 4a 2f 00 00       	call   38c2 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     978:	50                   	push   %eax
     979:	50                   	push   %eax
     97a:	68 49 40 00 00       	push   $0x4049
     97f:	ff 35 e8 5d 00 00    	pushl  0x5de8
     985:	e8 a6 30 00 00       	call   3a30 <printf>
    exit();
     98a:	e8 33 2f 00 00       	call   38c2 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     98f:	52                   	push   %edx
     990:	52                   	push   %edx
     991:	68 38 40 00 00       	push   $0x4038
     996:	ff 35 e8 5d 00 00    	pushl  0x5de8
     99c:	e8 8f 30 00 00       	call   3a30 <printf>
    exit();
     9a1:	e8 1c 2f 00 00       	call   38c2 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     9a6:	51                   	push   %ecx
     9a7:	51                   	push   %ecx
     9a8:	68 25 40 00 00       	push   $0x4025
     9ad:	ff 35 e8 5d 00 00    	pushl  0x5de8
     9b3:	e8 78 30 00 00       	call   3a30 <printf>
    exit();
     9b8:	e8 05 2f 00 00       	call   38c2 <exit>
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9c6:	68 6c 40 00 00       	push   $0x406c
     9cb:	ff 35 e8 5d 00 00    	pushl  0x5de8
     9d1:	e8 5a 30 00 00       	call   3a30 <printf>
  if(exec("echo", echoargv) < 0){
     9d6:	5a                   	pop    %edx
     9d7:	59                   	pop    %ecx
     9d8:	68 ec 5d 00 00       	push   $0x5dec
     9dd:	68 35 3e 00 00       	push   $0x3e35
     9e2:	e8 13 2f 00 00       	call   38fa <exec>
     9e7:	83 c4 10             	add    $0x10,%esp
     9ea:	85 c0                	test   %eax,%eax
     9ec:	78 02                	js     9f0 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     9ee:	c9                   	leave  
     9ef:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     9f0:	50                   	push   %eax
     9f1:	50                   	push   %eax
     9f2:	68 77 40 00 00       	push   $0x4077
     9f7:	ff 35 e8 5d 00 00    	pushl  0x5de8
     9fd:	e8 2e 30 00 00       	call   3a30 <printf>
    exit();
     a02:	e8 bb 2e 00 00       	call   38c2 <exit>
     a07:	89 f6                	mov    %esi,%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
     a15:	53                   	push   %ebx
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a16:	8d 45 e0             	lea    -0x20(%ebp),%eax

// simple fork and pipe read/write

void
pipe1(void)
{
     a19:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a1c:	50                   	push   %eax
     a1d:	e8 b0 2e 00 00       	call   38d2 <pipe>
     a22:	83 c4 10             	add    $0x10,%esp
     a25:	85 c0                	test   %eax,%eax
     a27:	0f 85 3d 01 00 00    	jne    b6a <pipe1+0x15a>
     a2d:	89 c3                	mov    %eax,%ebx
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     a2f:	e8 86 2e 00 00       	call   38ba <fork>
  seq = 0;
  if(pid == 0){
     a34:	83 f8 00             	cmp    $0x0,%eax

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     a37:	89 c6                	mov    %eax,%esi
  seq = 0;
  if(pid == 0){
     a39:	0f 84 8a 00 00 00    	je     ac9 <pipe1+0xb9>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     a3f:	0f 8e 39 01 00 00    	jle    b7e <pipe1+0x16e>
    close(fds[1]);
     a45:	83 ec 0c             	sub    $0xc,%esp
     a48:	ff 75 e4             	pushl  -0x1c(%ebp)
    total = 0;
    cc = 1;
     a4b:	bf 01 00 00 00       	mov    $0x1,%edi
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
     a50:	e8 95 2e 00 00       	call   38ea <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     a55:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
     a58:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     a5f:	83 ec 04             	sub    $0x4,%esp
     a62:	57                   	push   %edi
     a63:	68 c0 85 00 00       	push   $0x85c0
     a68:	ff 75 e0             	pushl  -0x20(%ebp)
     a6b:	e8 6a 2e 00 00       	call   38da <read>
     a70:	83 c4 10             	add    $0x10,%esp
     a73:	85 c0                	test   %eax,%eax
     a75:	0f 8e a9 00 00 00    	jle    b24 <pipe1+0x114>
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a7b:	89 d9                	mov    %ebx,%ecx
     a7d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a80:	f7 d9                	neg    %ecx
     a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a88:	38 9c 0b c0 85 00 00 	cmp    %bl,0x85c0(%ebx,%ecx,1)
     a8f:	8d 53 01             	lea    0x1(%ebx),%edx
     a92:	75 1b                	jne    aaf <pipe1+0x9f>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     a94:	39 f2                	cmp    %esi,%edx
     a96:	89 d3                	mov    %edx,%ebx
     a98:	75 ee                	jne    a88 <pipe1+0x78>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     a9a:	01 ff                	add    %edi,%edi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     a9c:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a9f:	b8 00 20 00 00       	mov    $0x2000,%eax
     aa4:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     aaa:	0f 4f f8             	cmovg  %eax,%edi
     aad:	eb b0                	jmp    a5f <pipe1+0x4f>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     aaf:	83 ec 08             	sub    $0x8,%esp
     ab2:	68 a6 40 00 00       	push   $0x40a6
     ab7:	6a 01                	push   $0x1
     ab9:	e8 72 2f 00 00       	call   3a30 <printf>
          return;
     abe:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     ac1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac4:	5b                   	pop    %ebx
     ac5:	5e                   	pop    %esi
     ac6:	5f                   	pop    %edi
     ac7:	5d                   	pop    %ebp
     ac8:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     ac9:	83 ec 0c             	sub    $0xc,%esp
     acc:	ff 75 e0             	pushl  -0x20(%ebp)
     acf:	e8 16 2e 00 00       	call   38ea <close>
     ad4:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     ad7:	89 f0                	mov    %esi,%eax
     ad9:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     adf:	89 f3                	mov    %esi,%ebx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     ae1:	f7 d8                	neg    %eax
     ae3:	90                   	nop
     ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ae8:	88 9c 18 c0 85 00 00 	mov    %bl,0x85c0(%eax,%ebx,1)
     aef:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     af2:	39 d3                	cmp    %edx,%ebx
     af4:	75 f2                	jne    ae8 <pipe1+0xd8>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     af6:	83 ec 04             	sub    $0x4,%esp
     af9:	89 de                	mov    %ebx,%esi
     afb:	68 09 04 00 00       	push   $0x409
     b00:	68 c0 85 00 00       	push   $0x85c0
     b05:	ff 75 e4             	pushl  -0x1c(%ebp)
     b08:	e8 d5 2d 00 00       	call   38e2 <write>
     b0d:	83 c4 10             	add    $0x10,%esp
     b10:	3d 09 04 00 00       	cmp    $0x409,%eax
     b15:	75 7b                	jne    b92 <pipe1+0x182>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     b17:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b1d:	75 b8                	jne    ad7 <pipe1+0xc7>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     b1f:	e8 9e 2d 00 00       	call   38c2 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     b24:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b2b:	75 26                	jne    b53 <pipe1+0x143>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     b2d:	83 ec 0c             	sub    $0xc,%esp
     b30:	ff 75 e0             	pushl  -0x20(%ebp)
     b33:	e8 b2 2d 00 00       	call   38ea <close>
    wait();
     b38:	e8 8d 2d 00 00       	call   38ca <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b3d:	58                   	pop    %eax
     b3e:	5a                   	pop    %edx
     b3f:	68 cb 40 00 00       	push   $0x40cb
     b44:	6a 01                	push   $0x1
     b46:	e8 e5 2e 00 00       	call   3a30 <printf>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	e9 6e ff ff ff       	jmp    ac1 <pipe1+0xb1>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     b53:	83 ec 04             	sub    $0x4,%esp
     b56:	ff 75 d4             	pushl  -0x2c(%ebp)
     b59:	68 b4 40 00 00       	push   $0x40b4
     b5e:	6a 01                	push   $0x1
     b60:	e8 cb 2e 00 00       	call   3a30 <printf>
      exit();
     b65:	e8 58 2d 00 00       	call   38c2 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     b6a:	83 ec 08             	sub    $0x8,%esp
     b6d:	68 89 40 00 00       	push   $0x4089
     b72:	6a 01                	push   $0x1
     b74:	e8 b7 2e 00 00       	call   3a30 <printf>
    exit();
     b79:	e8 44 2d 00 00       	call   38c2 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b7e:	83 ec 08             	sub    $0x8,%esp
     b81:	68 d5 40 00 00       	push   $0x40d5
     b86:	6a 01                	push   $0x1
     b88:	e8 a3 2e 00 00       	call   3a30 <printf>
    exit();
     b8d:	e8 30 2d 00 00       	call   38c2 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     b92:	83 ec 08             	sub    $0x8,%esp
     b95:	68 98 40 00 00       	push   $0x4098
     b9a:	6a 01                	push   $0x1
     b9c:	e8 8f 2e 00 00       	call   3a30 <printf>
        exit();
     ba1:	e8 1c 2d 00 00       	call   38c2 <exit>
     ba6:	8d 76 00             	lea    0x0(%esi),%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     bb9:	68 e4 40 00 00       	push   $0x40e4
     bbe:	6a 01                	push   $0x1
     bc0:	e8 6b 2e 00 00       	call   3a30 <printf>
  pid1 = fork();
     bc5:	e8 f0 2c 00 00       	call   38ba <fork>
  if(pid1 == 0)
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 02                	jne    bd3 <preempt+0x23>
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	89 c7                	mov    %eax,%edi
    for(;;)
      ;

  pid2 = fork();
     bd5:	e8 e0 2c 00 00       	call   38ba <fork>
  if(pid2 == 0)
     bda:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     bdc:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bde:	75 02                	jne    be2 <preempt+0x32>
     be0:	eb fe                	jmp    be0 <preempt+0x30>
    for(;;)
      ;

  pipe(pfds);
     be2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     be5:	83 ec 0c             	sub    $0xc,%esp
     be8:	50                   	push   %eax
     be9:	e8 e4 2c 00 00       	call   38d2 <pipe>
  pid3 = fork();
     bee:	e8 c7 2c 00 00       	call   38ba <fork>
  if(pid3 == 0){
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     bf8:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     bfa:	75 47                	jne    c43 <preempt+0x93>
    close(pfds[0]);
     bfc:	83 ec 0c             	sub    $0xc,%esp
     bff:	ff 75 e0             	pushl  -0x20(%ebp)
     c02:	e8 e3 2c 00 00       	call   38ea <close>
    if(write(pfds[1], "x", 1) != 1)
     c07:	83 c4 0c             	add    $0xc,%esp
     c0a:	6a 01                	push   $0x1
     c0c:	68 a9 46 00 00       	push   $0x46a9
     c11:	ff 75 e4             	pushl  -0x1c(%ebp)
     c14:	e8 c9 2c 00 00       	call   38e2 <write>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	83 f8 01             	cmp    $0x1,%eax
     c1f:	74 12                	je     c33 <preempt+0x83>
      printf(1, "preempt write error");
     c21:	83 ec 08             	sub    $0x8,%esp
     c24:	68 ee 40 00 00       	push   $0x40ee
     c29:	6a 01                	push   $0x1
     c2b:	e8 00 2e 00 00       	call   3a30 <printf>
     c30:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	pushl  -0x1c(%ebp)
     c39:	e8 ac 2c 00 00       	call   38ea <close>
     c3e:	83 c4 10             	add    $0x10,%esp
     c41:	eb fe                	jmp    c41 <preempt+0x91>
    for(;;)
      ;
  }

  close(pfds[1]);
     c43:	83 ec 0c             	sub    $0xc,%esp
     c46:	ff 75 e4             	pushl  -0x1c(%ebp)
     c49:	e8 9c 2c 00 00       	call   38ea <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c4e:	83 c4 0c             	add    $0xc,%esp
     c51:	68 00 20 00 00       	push   $0x2000
     c56:	68 c0 85 00 00       	push   $0x85c0
     c5b:	ff 75 e0             	pushl  -0x20(%ebp)
     c5e:	e8 77 2c 00 00       	call   38da <read>
     c63:	83 c4 10             	add    $0x10,%esp
     c66:	83 f8 01             	cmp    $0x1,%eax
     c69:	74 1a                	je     c85 <preempt+0xd5>
    printf(1, "preempt read error");
     c6b:	83 ec 08             	sub    $0x8,%esp
     c6e:	68 02 41 00 00       	push   $0x4102
     c73:	6a 01                	push   $0x1
     c75:	e8 b6 2d 00 00       	call   3a30 <printf>
    return;
     c7a:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c80:	5b                   	pop    %ebx
     c81:	5e                   	pop    %esi
     c82:	5f                   	pop    %edi
     c83:	5d                   	pop    %ebp
     c84:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     c85:	83 ec 0c             	sub    $0xc,%esp
     c88:	ff 75 e0             	pushl  -0x20(%ebp)
     c8b:	e8 5a 2c 00 00       	call   38ea <close>
  printf(1, "kill... ");
     c90:	58                   	pop    %eax
     c91:	5a                   	pop    %edx
     c92:	68 15 41 00 00       	push   $0x4115
     c97:	6a 01                	push   $0x1
     c99:	e8 92 2d 00 00       	call   3a30 <printf>
  kill(pid1);
     c9e:	89 3c 24             	mov    %edi,(%esp)
     ca1:	e8 4c 2c 00 00       	call   38f2 <kill>
  kill(pid2);
     ca6:	89 34 24             	mov    %esi,(%esp)
     ca9:	e8 44 2c 00 00       	call   38f2 <kill>
  kill(pid3);
     cae:	89 1c 24             	mov    %ebx,(%esp)
     cb1:	e8 3c 2c 00 00       	call   38f2 <kill>
  printf(1, "wait... ");
     cb6:	59                   	pop    %ecx
     cb7:	5b                   	pop    %ebx
     cb8:	68 1e 41 00 00       	push   $0x411e
     cbd:	6a 01                	push   $0x1
     cbf:	e8 6c 2d 00 00       	call   3a30 <printf>
  wait();
     cc4:	e8 01 2c 00 00       	call   38ca <wait>
  wait();
     cc9:	e8 fc 2b 00 00       	call   38ca <wait>
  wait();
     cce:	e8 f7 2b 00 00       	call   38ca <wait>
  printf(1, "preempt ok\n");
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	68 27 41 00 00       	push   $0x4127
     cda:	6a 01                	push   $0x1
     cdc:	e8 4f 2d 00 00       	call   3a30 <printf>
     ce1:	83 c4 10             	add    $0x10,%esp
     ce4:	eb 97                	jmp    c7d <preempt+0xcd>
     ce6:	8d 76 00             	lea    0x0(%esi),%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cf0 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	be 64 00 00 00       	mov    $0x64,%esi
     cf9:	53                   	push   %ebx
     cfa:	eb 14                	jmp    d10 <exitwait+0x20>
     cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     d00:	74 6f                	je     d71 <exitwait+0x81>
      if(wait() != pid){
     d02:	e8 c3 2b 00 00       	call   38ca <wait>
     d07:	39 c3                	cmp    %eax,%ebx
     d09:	75 2d                	jne    d38 <exitwait+0x48>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     d0b:	83 ee 01             	sub    $0x1,%esi
     d0e:	74 48                	je     d58 <exitwait+0x68>
    pid = fork();
     d10:	e8 a5 2b 00 00       	call   38ba <fork>
    if(pid < 0){
     d15:	85 c0                	test   %eax,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     d17:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d19:	79 e5                	jns    d00 <exitwait+0x10>
      printf(1, "fork failed\n");
     d1b:	83 ec 08             	sub    $0x8,%esp
     d1e:	68 91 4c 00 00       	push   $0x4c91
     d23:	6a 01                	push   $0x1
     d25:	e8 06 2d 00 00       	call   3a30 <printf>
      return;
     d2a:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d30:	5b                   	pop    %ebx
     d31:	5e                   	pop    %esi
     d32:	5d                   	pop    %ebp
     d33:	c3                   	ret    
     d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     d38:	83 ec 08             	sub    $0x8,%esp
     d3b:	68 33 41 00 00       	push   $0x4133
     d40:	6a 01                	push   $0x1
     d42:	e8 e9 2c 00 00       	call   3a30 <printf>
        return;
     d47:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d4d:	5b                   	pop    %ebx
     d4e:	5e                   	pop    %esi
     d4f:	5d                   	pop    %ebp
     d50:	c3                   	ret    
     d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 43 41 00 00       	push   $0x4143
     d60:	6a 01                	push   $0x1
     d62:	e8 c9 2c 00 00       	call   3a30 <printf>
     d67:	83 c4 10             	add    $0x10,%esp
}
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     d71:	e8 4c 2b 00 00       	call   38c2 <exit>
     d76:	8d 76 00             	lea    0x0(%esi),%esi
     d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d80 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	57                   	push   %edi
     d84:	56                   	push   %esi
     d85:	53                   	push   %ebx
     d86:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d89:	68 50 41 00 00       	push   $0x4150
     d8e:	6a 01                	push   $0x1
     d90:	e8 9b 2c 00 00       	call   3a30 <printf>
  ppid = getpid();
     d95:	e8 a8 2b 00 00       	call   3942 <getpid>
     d9a:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d9c:	e8 19 2b 00 00       	call   38ba <fork>
     da1:	83 c4 10             	add    $0x10,%esp
     da4:	85 c0                	test   %eax,%eax
     da6:	75 70                	jne    e18 <mem+0x98>
     da8:	31 db                	xor    %ebx,%ebx
     daa:	eb 08                	jmp    db4 <mem+0x34>
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     db0:	89 18                	mov    %ebx,(%eax)
     db2:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	68 11 27 00 00       	push   $0x2711
     dbc:	e8 af 2e 00 00       	call   3c70 <malloc>
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	85 c0                	test   %eax,%eax
     dc6:	75 e8                	jne    db0 <mem+0x30>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     dc8:	85 db                	test   %ebx,%ebx
     dca:	74 18                	je     de4 <mem+0x64>
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     dd0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     dd2:	83 ec 0c             	sub    $0xc,%esp
     dd5:	53                   	push   %ebx
     dd6:	89 fb                	mov    %edi,%ebx
     dd8:	e8 03 2e 00 00       	call   3be0 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	85 db                	test   %ebx,%ebx
     de2:	75 ec                	jne    dd0 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     de4:	83 ec 0c             	sub    $0xc,%esp
     de7:	68 00 50 00 00       	push   $0x5000
     dec:	e8 7f 2e 00 00       	call   3c70 <malloc>
    if(m1 == 0){
     df1:	83 c4 10             	add    $0x10,%esp
     df4:	85 c0                	test   %eax,%eax
     df6:	74 30                	je     e28 <mem+0xa8>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     df8:	83 ec 0c             	sub    $0xc,%esp
     dfb:	50                   	push   %eax
     dfc:	e8 df 2d 00 00       	call   3be0 <free>
    printf(1, "mem ok\n");
     e01:	58                   	pop    %eax
     e02:	5a                   	pop    %edx
     e03:	68 74 41 00 00       	push   $0x4174
     e08:	6a 01                	push   $0x1
     e0a:	e8 21 2c 00 00       	call   3a30 <printf>
    exit();
     e0f:	e8 ae 2a 00 00       	call   38c2 <exit>
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    wait();
  }
}
     e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e1b:	5b                   	pop    %ebx
     e1c:	5e                   	pop    %esi
     e1d:	5f                   	pop    %edi
     e1e:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     e1f:	e9 a6 2a 00 00       	jmp    38ca <wait>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 5a 41 00 00       	push   $0x415a
     e30:	6a 01                	push   $0x1
     e32:	e8 f9 2b 00 00       	call   3a30 <printf>
      kill(ppid);
     e37:	89 34 24             	mov    %esi,(%esp)
     e3a:	e8 b3 2a 00 00       	call   38f2 <kill>
      exit();
     e3f:	e8 7e 2a 00 00       	call   38c2 <exit>
     e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e50 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e59:	68 7c 41 00 00       	push   $0x417c
     e5e:	6a 01                	push   $0x1
     e60:	e8 cb 2b 00 00       	call   3a30 <printf>

  unlink("sharedfd");
     e65:	c7 04 24 8b 41 00 00 	movl   $0x418b,(%esp)
     e6c:	e8 a1 2a 00 00       	call   3912 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e71:	5b                   	pop    %ebx
     e72:	5e                   	pop    %esi
     e73:	68 02 02 00 00       	push   $0x202
     e78:	68 8b 41 00 00       	push   $0x418b
     e7d:	e8 80 2a 00 00       	call   3902 <open>
  if(fd < 0){
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	85 c0                	test   %eax,%eax
     e87:	0f 88 29 01 00 00    	js     fb6 <sharedfd+0x166>
     e8d:	89 c7                	mov    %eax,%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e8f:	8d 75 de             	lea    -0x22(%ebp),%esi
     e92:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     e97:	e8 1e 2a 00 00       	call   38ba <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e9c:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     e9f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ea2:	19 c0                	sbb    %eax,%eax
     ea4:	83 ec 04             	sub    $0x4,%esp
     ea7:	83 e0 f3             	and    $0xfffffff3,%eax
     eaa:	6a 0a                	push   $0xa
     eac:	83 c0 70             	add    $0x70,%eax
     eaf:	50                   	push   %eax
     eb0:	56                   	push   %esi
     eb1:	e8 7a 28 00 00       	call   3730 <memset>
     eb6:	83 c4 10             	add    $0x10,%esp
     eb9:	eb 0a                	jmp    ec5 <sharedfd+0x75>
     ebb:	90                   	nop
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     ec0:	83 eb 01             	sub    $0x1,%ebx
     ec3:	74 26                	je     eeb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	6a 0a                	push   $0xa
     eca:	56                   	push   %esi
     ecb:	57                   	push   %edi
     ecc:	e8 11 2a 00 00       	call   38e2 <write>
     ed1:	83 c4 10             	add    $0x10,%esp
     ed4:	83 f8 0a             	cmp    $0xa,%eax
     ed7:	74 e7                	je     ec0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ed9:	83 ec 08             	sub    $0x8,%esp
     edc:	68 7c 4e 00 00       	push   $0x4e7c
     ee1:	6a 01                	push   $0x1
     ee3:	e8 48 2b 00 00       	call   3a30 <printf>
      break;
     ee8:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     eeb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     eee:	85 c9                	test   %ecx,%ecx
     ef0:	0f 84 f4 00 00 00    	je     fea <sharedfd+0x19a>
    exit();
  else
    wait();
     ef6:	e8 cf 29 00 00       	call   38ca <wait>
  close(fd);
     efb:	83 ec 0c             	sub    $0xc,%esp
     efe:	31 db                	xor    %ebx,%ebx
     f00:	57                   	push   %edi
     f01:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f04:	e8 e1 29 00 00       	call   38ea <close>
  fd = open("sharedfd", 0);
     f09:	58                   	pop    %eax
     f0a:	5a                   	pop    %edx
     f0b:	6a 00                	push   $0x0
     f0d:	68 8b 41 00 00       	push   $0x418b
     f12:	e8 eb 29 00 00       	call   3902 <open>
  if(fd < 0){
     f17:	83 c4 10             	add    $0x10,%esp
     f1a:	31 d2                	xor    %edx,%edx
     f1c:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
     f1e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f21:	0f 88 a9 00 00 00    	js     fd0 <sharedfd+0x180>
     f27:	89 f6                	mov    %esi,%esi
     f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f30:	83 ec 04             	sub    $0x4,%esp
     f33:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f36:	6a 0a                	push   $0xa
     f38:	56                   	push   %esi
     f39:	ff 75 d0             	pushl  -0x30(%ebp)
     f3c:	e8 99 29 00 00       	call   38da <read>
     f41:	83 c4 10             	add    $0x10,%esp
     f44:	85 c0                	test   %eax,%eax
     f46:	7e 27                	jle    f6f <sharedfd+0x11f>
     f48:	89 f0                	mov    %esi,%eax
     f4a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f4d:	eb 13                	jmp    f62 <sharedfd+0x112>
     f4f:	90                   	nop
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
     f50:	80 f9 70             	cmp    $0x70,%cl
     f53:	0f 94 c1             	sete   %cl
     f56:	0f b6 c9             	movzbl %cl,%ecx
     f59:	01 cb                	add    %ecx,%ebx
     f5b:	83 c0 01             	add    $0x1,%eax
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     f5e:	39 c7                	cmp    %eax,%edi
     f60:	74 ce                	je     f30 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f62:	0f b6 08             	movzbl (%eax),%ecx
     f65:	80 f9 63             	cmp    $0x63,%cl
     f68:	75 e6                	jne    f50 <sharedfd+0x100>
        nc++;
     f6a:	83 c2 01             	add    $0x1,%edx
     f6d:	eb ec                	jmp    f5b <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     f6f:	83 ec 0c             	sub    $0xc,%esp
     f72:	ff 75 d0             	pushl  -0x30(%ebp)
     f75:	e8 70 29 00 00       	call   38ea <close>
  unlink("sharedfd");
     f7a:	c7 04 24 8b 41 00 00 	movl   $0x418b,(%esp)
     f81:	e8 8c 29 00 00       	call   3912 <unlink>
  if(nc == 10000 && np == 10000){
     f86:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f89:	83 c4 10             	add    $0x10,%esp
     f8c:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     f92:	75 5b                	jne    fef <sharedfd+0x19f>
     f94:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f9a:	75 53                	jne    fef <sharedfd+0x19f>
    printf(1, "sharedfd ok\n");
     f9c:	83 ec 08             	sub    $0x8,%esp
     f9f:	68 94 41 00 00       	push   $0x4194
     fa4:	6a 01                	push   $0x1
     fa6:	e8 85 2a 00 00       	call   3a30 <printf>
     fab:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fb1:	5b                   	pop    %ebx
     fb2:	5e                   	pop    %esi
     fb3:	5f                   	pop    %edi
     fb4:	5d                   	pop    %ebp
     fb5:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     fb6:	83 ec 08             	sub    $0x8,%esp
     fb9:	68 50 4e 00 00       	push   $0x4e50
     fbe:	6a 01                	push   $0x1
     fc0:	e8 6b 2a 00 00       	call   3a30 <printf>
    return;
     fc5:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fcb:	5b                   	pop    %ebx
     fcc:	5e                   	pop    %esi
     fcd:	5f                   	pop    %edi
     fce:	5d                   	pop    %ebp
     fcf:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fd0:	83 ec 08             	sub    $0x8,%esp
     fd3:	68 9c 4e 00 00       	push   $0x4e9c
     fd8:	6a 01                	push   $0x1
     fda:	e8 51 2a 00 00       	call   3a30 <printf>
    return;
     fdf:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fe2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe5:	5b                   	pop    %ebx
     fe6:	5e                   	pop    %esi
     fe7:	5f                   	pop    %edi
     fe8:	5d                   	pop    %ebp
     fe9:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
     fea:	e8 d3 28 00 00       	call   38c2 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     fef:	53                   	push   %ebx
     ff0:	52                   	push   %edx
     ff1:	68 a1 41 00 00       	push   $0x41a1
     ff6:	6a 01                	push   $0x1
     ff8:	e8 33 2a 00 00       	call   3a30 <printf>
    exit();
     ffd:	e8 c0 28 00 00       	call   38c2 <exit>
    1002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001010 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
    1015:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    1016:	be b6 41 00 00       	mov    $0x41b6,%esi

  for(pi = 0; pi < 4; pi++){
    101b:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    101d:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1020:	c7 45 d8 b6 41 00 00 	movl   $0x41b6,-0x28(%ebp)
    1027:	c7 45 dc ff 42 00 00 	movl   $0x42ff,-0x24(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    102e:	68 bc 41 00 00       	push   $0x41bc
    1033:	6a 01                	push   $0x1
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1035:	c7 45 e0 03 43 00 00 	movl   $0x4303,-0x20(%ebp)
    103c:	c7 45 e4 b9 41 00 00 	movl   $0x41b9,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    1043:	e8 e8 29 00 00       	call   3a30 <printf>
    1048:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    104b:	83 ec 0c             	sub    $0xc,%esp
    104e:	56                   	push   %esi
    104f:	e8 be 28 00 00       	call   3912 <unlink>

    pid = fork();
    1054:	e8 61 28 00 00       	call   38ba <fork>
    if(pid < 0){
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	0f 88 83 01 00 00    	js     11e7 <fourfiles+0x1d7>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1064:	0f 84 e3 00 00 00    	je     114d <fourfiles+0x13d>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    106a:	83 c3 01             	add    $0x1,%ebx
    106d:	83 fb 04             	cmp    $0x4,%ebx
    1070:	74 06                	je     1078 <fourfiles+0x68>
    1072:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1076:	eb d3                	jmp    104b <fourfiles+0x3b>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1078:	e8 4d 28 00 00       	call   38ca <wait>
    107d:	bf 30 00 00 00       	mov    $0x30,%edi
    1082:	e8 43 28 00 00       	call   38ca <wait>
    1087:	e8 3e 28 00 00       	call   38ca <wait>
    108c:	e8 39 28 00 00       	call   38ca <wait>
    1091:	c7 45 d4 b6 41 00 00 	movl   $0x41b6,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    1098:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    109b:	31 db                	xor    %ebx,%ebx
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    109d:	6a 00                	push   $0x0
    109f:	ff 75 d4             	pushl  -0x2c(%ebp)
    10a2:	e8 5b 28 00 00       	call   3902 <open>
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10a7:	83 c4 10             	add    $0x10,%esp
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    10aa:	89 c6                	mov    %eax,%esi
    10ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	68 00 20 00 00       	push   $0x2000
    10b8:	68 c0 85 00 00       	push   $0x85c0
    10bd:	56                   	push   %esi
    10be:	e8 17 28 00 00       	call   38da <read>
    10c3:	83 c4 10             	add    $0x10,%esp
    10c6:	85 c0                	test   %eax,%eax
    10c8:	7e 1c                	jle    10e6 <fourfiles+0xd6>
    10ca:	31 d2                	xor    %edx,%edx
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    10d0:	0f be 8a c0 85 00 00 	movsbl 0x85c0(%edx),%ecx
    10d7:	39 cf                	cmp    %ecx,%edi
    10d9:	75 5e                	jne    1139 <fourfiles+0x129>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    10db:	83 c2 01             	add    $0x1,%edx
    10de:	39 d0                	cmp    %edx,%eax
    10e0:	75 ee                	jne    10d0 <fourfiles+0xc0>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    10e2:	01 c3                	add    %eax,%ebx
    10e4:	eb ca                	jmp    10b0 <fourfiles+0xa0>
    }
    close(fd);
    10e6:	83 ec 0c             	sub    $0xc,%esp
    10e9:	56                   	push   %esi
    10ea:	e8 fb 27 00 00       	call   38ea <close>
    if(total != 12*500){
    10ef:	83 c4 10             	add    $0x10,%esp
    10f2:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    10f8:	0f 85 d4 00 00 00    	jne    11d2 <fourfiles+0x1c2>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	pushl  -0x2c(%ebp)
    1104:	83 c7 01             	add    $0x1,%edi
    1107:	e8 06 28 00 00       	call   3912 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    110c:	83 c4 10             	add    $0x10,%esp
    110f:	83 ff 32             	cmp    $0x32,%edi
    1112:	75 1a                	jne    112e <fourfiles+0x11e>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    1114:	83 ec 08             	sub    $0x8,%esp
    1117:	68 fa 41 00 00       	push   $0x41fa
    111c:	6a 01                	push   $0x1
    111e:	e8 0d 29 00 00       	call   3a30 <printf>
}
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1129:	5b                   	pop    %ebx
    112a:	5e                   	pop    %esi
    112b:	5f                   	pop    %edi
    112c:	5d                   	pop    %ebp
    112d:	c3                   	ret    
    112e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1131:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1134:	e9 5f ff ff ff       	jmp    1098 <fourfiles+0x88>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    1139:	83 ec 08             	sub    $0x8,%esp
    113c:	68 dd 41 00 00       	push   $0x41dd
    1141:	6a 01                	push   $0x1
    1143:	e8 e8 28 00 00       	call   3a30 <printf>
          exit();
    1148:	e8 75 27 00 00       	call   38c2 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    114d:	83 ec 08             	sub    $0x8,%esp
    1150:	68 02 02 00 00       	push   $0x202
    1155:	56                   	push   %esi
    1156:	e8 a7 27 00 00       	call   3902 <open>
      if(fd < 0){
    115b:	83 c4 10             	add    $0x10,%esp
    115e:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1160:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1162:	78 5a                	js     11be <fourfiles+0x1ae>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    1164:	83 ec 04             	sub    $0x4,%esp
    1167:	83 c3 30             	add    $0x30,%ebx
    116a:	68 00 02 00 00       	push   $0x200
    116f:	53                   	push   %ebx
    1170:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1175:	68 c0 85 00 00       	push   $0x85c0
    117a:	e8 b1 25 00 00       	call   3730 <memset>
    117f:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    1182:	83 ec 04             	sub    $0x4,%esp
    1185:	68 f4 01 00 00       	push   $0x1f4
    118a:	68 c0 85 00 00       	push   $0x85c0
    118f:	56                   	push   %esi
    1190:	e8 4d 27 00 00       	call   38e2 <write>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    119d:	75 0a                	jne    11a9 <fourfiles+0x199>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    119f:	83 eb 01             	sub    $0x1,%ebx
    11a2:	75 de                	jne    1182 <fourfiles+0x172>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    11a4:	e8 19 27 00 00       	call   38c2 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    11a9:	83 ec 04             	sub    $0x4,%esp
    11ac:	50                   	push   %eax
    11ad:	68 cc 41 00 00       	push   $0x41cc
    11b2:	6a 01                	push   $0x1
    11b4:	e8 77 28 00 00       	call   3a30 <printf>
          exit();
    11b9:	e8 04 27 00 00       	call   38c2 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    11be:	83 ec 08             	sub    $0x8,%esp
    11c1:	68 57 44 00 00       	push   $0x4457
    11c6:	6a 01                	push   $0x1
    11c8:	e8 63 28 00 00       	call   3a30 <printf>
        exit();
    11cd:	e8 f0 26 00 00       	call   38c2 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    11d2:	83 ec 04             	sub    $0x4,%esp
    11d5:	53                   	push   %ebx
    11d6:	68 e9 41 00 00       	push   $0x41e9
    11db:	6a 01                	push   $0x1
    11dd:	e8 4e 28 00 00       	call   3a30 <printf>
      exit();
    11e2:	e8 db 26 00 00       	call   38c2 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    11e7:	83 ec 08             	sub    $0x8,%esp
    11ea:	68 91 4c 00 00       	push   $0x4c91
    11ef:	6a 01                	push   $0x1
    11f1:	e8 3a 28 00 00       	call   3a30 <printf>
      exit();
    11f6:	e8 c7 26 00 00       	call   38c2 <exit>
    11fb:	90                   	nop
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001200 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1206:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1208:	83 ec 44             	sub    $0x44,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    120b:	68 08 42 00 00       	push   $0x4208
    1210:	6a 01                	push   $0x1
    1212:	e8 19 28 00 00       	call   3a30 <printf>
    1217:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    121a:	e8 9b 26 00 00       	call   38ba <fork>
    if(pid < 0){
    121f:	85 c0                	test   %eax,%eax
    1221:	0f 88 b7 01 00 00    	js     13de <createdelete+0x1de>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1227:	0f 84 f6 00 00 00    	je     1323 <createdelete+0x123>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    122d:	83 c3 01             	add    $0x1,%ebx
    1230:	83 fb 04             	cmp    $0x4,%ebx
    1233:	75 e5                	jne    121a <createdelete+0x1a>
    1235:	8d 7d c8             	lea    -0x38(%ebp),%edi
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1238:	31 f6                	xor    %esi,%esi
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    123a:	e8 8b 26 00 00       	call   38ca <wait>
    123f:	e8 86 26 00 00       	call   38ca <wait>
    1244:	e8 81 26 00 00       	call   38ca <wait>
    1249:	e8 7c 26 00 00       	call   38ca <wait>
  }

  name[0] = name[1] = name[2] = 0;
    124e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1258:	8d 46 30             	lea    0x30(%esi),%eax
    125b:	83 fe 09             	cmp    $0x9,%esi
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    125e:	bb 70 00 00 00       	mov    $0x70,%ebx
    1263:	0f 9f c2             	setg   %dl
    1266:	85 f6                	test   %esi,%esi
    1268:	88 45 c7             	mov    %al,-0x39(%ebp)
    126b:	0f 94 c0             	sete   %al
    126e:	09 c2                	or     %eax,%edx
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1270:	8d 46 ff             	lea    -0x1(%esi),%eax
    1273:	88 55 c6             	mov    %dl,-0x3a(%ebp)
    1276:	89 45 c0             	mov    %eax,-0x40(%ebp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    1279:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    127d:	83 ec 08             	sub    $0x8,%esp
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    1280:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
    1283:	6a 00                	push   $0x0
    1285:	57                   	push   %edi

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    1286:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1289:	e8 74 26 00 00       	call   3902 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    128e:	89 c1                	mov    %eax,%ecx
    1290:	83 c4 10             	add    $0x10,%esp
    1293:	c1 e9 1f             	shr    $0x1f,%ecx
    1296:	84 c9                	test   %cl,%cl
    1298:	74 0a                	je     12a4 <createdelete+0xa4>
    129a:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    129e:	0f 85 11 01 00 00    	jne    13b5 <createdelete+0x1b5>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12a4:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12a8:	0f 86 44 01 00 00    	jbe    13f2 <createdelete+0x1f2>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
    12ae:	85 c0                	test   %eax,%eax
    12b0:	78 0c                	js     12be <createdelete+0xbe>
        close(fd);
    12b2:	83 ec 0c             	sub    $0xc,%esp
    12b5:	50                   	push   %eax
    12b6:	e8 2f 26 00 00       	call   38ea <close>
    12bb:	83 c4 10             	add    $0x10,%esp
    12be:	83 c3 01             	add    $0x1,%ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    12c1:	80 fb 74             	cmp    $0x74,%bl
    12c4:	75 b3                	jne    1279 <createdelete+0x79>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    12c6:	83 c6 01             	add    $0x1,%esi
    12c9:	83 fe 14             	cmp    $0x14,%esi
    12cc:	75 8a                	jne    1258 <createdelete+0x58>
    12ce:	be 70 00 00 00       	mov    $0x70,%esi
    12d3:	90                   	nop
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d8:	8d 46 c0             	lea    -0x40(%esi),%eax
    12db:	bb 04 00 00 00       	mov    $0x4,%ebx
    12e0:	88 45 c7             	mov    %al,-0x39(%ebp)
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    12e3:	89 f0                	mov    %esi,%eax
      name[1] = '0' + i;
      unlink(name);
    12e5:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    12e8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    12eb:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    12ef:	57                   	push   %edi
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
      name[1] = '0' + i;
    12f0:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    12f3:	e8 1a 26 00 00       	call   3912 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    12f8:	83 c4 10             	add    $0x10,%esp
    12fb:	83 eb 01             	sub    $0x1,%ebx
    12fe:	75 e3                	jne    12e3 <createdelete+0xe3>
    1300:	83 c6 01             	add    $0x1,%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    1303:	89 f0                	mov    %esi,%eax
    1305:	3c 84                	cmp    $0x84,%al
    1307:	75 cf                	jne    12d8 <createdelete+0xd8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    1309:	83 ec 08             	sub    $0x8,%esp
    130c:	68 1b 42 00 00       	push   $0x421b
    1311:	6a 01                	push   $0x1
    1313:	e8 18 27 00 00       	call   3a30 <printf>
}
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    131e:	5b                   	pop    %ebx
    131f:	5e                   	pop    %esi
    1320:	5f                   	pop    %edi
    1321:	5d                   	pop    %ebp
    1322:	c3                   	ret    
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1323:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    1326:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    132a:	be 01 00 00 00       	mov    $0x1,%esi
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    132f:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1332:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[2] = '\0';
    1335:	31 db                	xor    %ebx,%ebx
    1337:	eb 12                	jmp    134b <createdelete+0x14b>
    1339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1340:	83 fe 14             	cmp    $0x14,%esi
    1343:	74 6b                	je     13b0 <createdelete+0x1b0>
    1345:	83 c3 01             	add    $0x1,%ebx
    1348:	83 c6 01             	add    $0x1,%esi
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    134b:	83 ec 08             	sub    $0x8,%esp

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    134e:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    1351:	68 02 02 00 00       	push   $0x202
    1356:	57                   	push   %edi

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    1357:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    135a:	e8 a3 25 00 00       	call   3902 <open>
        if(fd < 0){
    135f:	83 c4 10             	add    $0x10,%esp
    1362:	85 c0                	test   %eax,%eax
    1364:	78 64                	js     13ca <createdelete+0x1ca>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    1366:	83 ec 0c             	sub    $0xc,%esp
    1369:	50                   	push   %eax
    136a:	e8 7b 25 00 00       	call   38ea <close>
        if(i > 0 && (i % 2 ) == 0){
    136f:	83 c4 10             	add    $0x10,%esp
    1372:	85 db                	test   %ebx,%ebx
    1374:	74 cf                	je     1345 <createdelete+0x145>
    1376:	f6 c3 01             	test   $0x1,%bl
    1379:	75 c5                	jne    1340 <createdelete+0x140>
          name[1] = '0' + (i / 2);
          if(unlink(name) < 0){
    137b:	83 ec 0c             	sub    $0xc,%esp
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    137e:	89 d8                	mov    %ebx,%eax
    1380:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    1382:	57                   	push   %edi
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    1383:	83 c0 30             	add    $0x30,%eax
    1386:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1389:	e8 84 25 00 00       	call   3912 <unlink>
    138e:	83 c4 10             	add    $0x10,%esp
    1391:	85 c0                	test   %eax,%eax
    1393:	79 ab                	jns    1340 <createdelete+0x140>
            printf(1, "unlink failed\n");
    1395:	83 ec 08             	sub    $0x8,%esp
    1398:	68 09 3e 00 00       	push   $0x3e09
    139d:	6a 01                	push   $0x1
    139f:	e8 8c 26 00 00       	call   3a30 <printf>
            exit();
    13a4:	e8 19 25 00 00       	call   38c2 <exit>
    13a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          }
        }
      }
      exit();
    13b0:	e8 0d 25 00 00       	call   38c2 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    13b5:	83 ec 04             	sub    $0x4,%esp
    13b8:	57                   	push   %edi
    13b9:	68 c8 4e 00 00       	push   $0x4ec8
    13be:	6a 01                	push   $0x1
    13c0:	e8 6b 26 00 00       	call   3a30 <printf>
        exit();
    13c5:	e8 f8 24 00 00       	call   38c2 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    13ca:	83 ec 08             	sub    $0x8,%esp
    13cd:	68 57 44 00 00       	push   $0x4457
    13d2:	6a 01                	push   $0x1
    13d4:	e8 57 26 00 00       	call   3a30 <printf>
          exit();
    13d9:	e8 e4 24 00 00       	call   38c2 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    13de:	83 ec 08             	sub    $0x8,%esp
    13e1:	68 91 4c 00 00       	push   $0x4c91
    13e6:	6a 01                	push   $0x1
    13e8:	e8 43 26 00 00       	call   3a30 <printf>
      exit();
    13ed:	e8 d0 24 00 00       	call   38c2 <exit>
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    13f2:	85 c0                	test   %eax,%eax
    13f4:	0f 88 c4 fe ff ff    	js     12be <createdelete+0xbe>
        printf(1, "oops createdelete %s did exist\n", name);
    13fa:	83 ec 04             	sub    $0x4,%esp
    13fd:	57                   	push   %edi
    13fe:	68 ec 4e 00 00       	push   $0x4eec
    1403:	6a 01                	push   $0x1
    1405:	e8 26 26 00 00       	call   3a30 <printf>
        exit();
    140a:	e8 b3 24 00 00       	call   38c2 <exit>
    140f:	90                   	nop

00001410 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	56                   	push   %esi
    1414:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1415:	83 ec 08             	sub    $0x8,%esp
    1418:	68 2c 42 00 00       	push   $0x422c
    141d:	6a 01                	push   $0x1
    141f:	e8 0c 26 00 00       	call   3a30 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1424:	5b                   	pop    %ebx
    1425:	5e                   	pop    %esi
    1426:	68 02 02 00 00       	push   $0x202
    142b:	68 3d 42 00 00       	push   $0x423d
    1430:	e8 cd 24 00 00       	call   3902 <open>
  if(fd < 0){
    1435:	83 c4 10             	add    $0x10,%esp
    1438:	85 c0                	test   %eax,%eax
    143a:	0f 88 e6 00 00 00    	js     1526 <unlinkread+0x116>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1440:	83 ec 04             	sub    $0x4,%esp
    1443:	89 c3                	mov    %eax,%ebx
    1445:	6a 05                	push   $0x5
    1447:	68 62 42 00 00       	push   $0x4262
    144c:	50                   	push   %eax
    144d:	e8 90 24 00 00       	call   38e2 <write>
  close(fd);
    1452:	89 1c 24             	mov    %ebx,(%esp)
    1455:	e8 90 24 00 00       	call   38ea <close>

  fd = open("unlinkread", O_RDWR);
    145a:	58                   	pop    %eax
    145b:	5a                   	pop    %edx
    145c:	6a 02                	push   $0x2
    145e:	68 3d 42 00 00       	push   $0x423d
    1463:	e8 9a 24 00 00       	call   3902 <open>
  if(fd < 0){
    1468:	83 c4 10             	add    $0x10,%esp
    146b:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    146d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    146f:	0f 88 10 01 00 00    	js     1585 <unlinkread+0x175>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1475:	83 ec 0c             	sub    $0xc,%esp
    1478:	68 3d 42 00 00       	push   $0x423d
    147d:	e8 90 24 00 00       	call   3912 <unlink>
    1482:	83 c4 10             	add    $0x10,%esp
    1485:	85 c0                	test   %eax,%eax
    1487:	0f 85 e5 00 00 00    	jne    1572 <unlinkread+0x162>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    148d:	83 ec 08             	sub    $0x8,%esp
    1490:	68 02 02 00 00       	push   $0x202
    1495:	68 3d 42 00 00       	push   $0x423d
    149a:	e8 63 24 00 00       	call   3902 <open>
  write(fd1, "yyy", 3);
    149f:	83 c4 0c             	add    $0xc,%esp
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14a2:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14a4:	6a 03                	push   $0x3
    14a6:	68 9a 42 00 00       	push   $0x429a
    14ab:	50                   	push   %eax
    14ac:	e8 31 24 00 00       	call   38e2 <write>
  close(fd1);
    14b1:	89 34 24             	mov    %esi,(%esp)
    14b4:	e8 31 24 00 00       	call   38ea <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    14b9:	83 c4 0c             	add    $0xc,%esp
    14bc:	68 00 20 00 00       	push   $0x2000
    14c1:	68 c0 85 00 00       	push   $0x85c0
    14c6:	53                   	push   %ebx
    14c7:	e8 0e 24 00 00       	call   38da <read>
    14cc:	83 c4 10             	add    $0x10,%esp
    14cf:	83 f8 05             	cmp    $0x5,%eax
    14d2:	0f 85 87 00 00 00    	jne    155f <unlinkread+0x14f>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    14d8:	80 3d c0 85 00 00 68 	cmpb   $0x68,0x85c0
    14df:	75 6b                	jne    154c <unlinkread+0x13c>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    14e1:	83 ec 04             	sub    $0x4,%esp
    14e4:	6a 0a                	push   $0xa
    14e6:	68 c0 85 00 00       	push   $0x85c0
    14eb:	53                   	push   %ebx
    14ec:	e8 f1 23 00 00       	call   38e2 <write>
    14f1:	83 c4 10             	add    $0x10,%esp
    14f4:	83 f8 0a             	cmp    $0xa,%eax
    14f7:	75 40                	jne    1539 <unlinkread+0x129>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    14f9:	83 ec 0c             	sub    $0xc,%esp
    14fc:	53                   	push   %ebx
    14fd:	e8 e8 23 00 00       	call   38ea <close>
  unlink("unlinkread");
    1502:	c7 04 24 3d 42 00 00 	movl   $0x423d,(%esp)
    1509:	e8 04 24 00 00       	call   3912 <unlink>
  printf(1, "unlinkread ok\n");
    150e:	58                   	pop    %eax
    150f:	5a                   	pop    %edx
    1510:	68 e5 42 00 00       	push   $0x42e5
    1515:	6a 01                	push   $0x1
    1517:	e8 14 25 00 00       	call   3a30 <printf>
}
    151c:	83 c4 10             	add    $0x10,%esp
    151f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1522:	5b                   	pop    %ebx
    1523:	5e                   	pop    %esi
    1524:	5d                   	pop    %ebp
    1525:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1526:	51                   	push   %ecx
    1527:	51                   	push   %ecx
    1528:	68 48 42 00 00       	push   $0x4248
    152d:	6a 01                	push   $0x1
    152f:	e8 fc 24 00 00       	call   3a30 <printf>
    exit();
    1534:	e8 89 23 00 00       	call   38c2 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1539:	51                   	push   %ecx
    153a:	51                   	push   %ecx
    153b:	68 cc 42 00 00       	push   $0x42cc
    1540:	6a 01                	push   $0x1
    1542:	e8 e9 24 00 00       	call   3a30 <printf>
    exit();
    1547:	e8 76 23 00 00       	call   38c2 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    154c:	53                   	push   %ebx
    154d:	53                   	push   %ebx
    154e:	68 b5 42 00 00       	push   $0x42b5
    1553:	6a 01                	push   $0x1
    1555:	e8 d6 24 00 00       	call   3a30 <printf>
    exit();
    155a:	e8 63 23 00 00       	call   38c2 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    155f:	56                   	push   %esi
    1560:	56                   	push   %esi
    1561:	68 9e 42 00 00       	push   $0x429e
    1566:	6a 01                	push   $0x1
    1568:	e8 c3 24 00 00       	call   3a30 <printf>
    exit();
    156d:	e8 50 23 00 00       	call   38c2 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1572:	50                   	push   %eax
    1573:	50                   	push   %eax
    1574:	68 80 42 00 00       	push   $0x4280
    1579:	6a 01                	push   $0x1
    157b:	e8 b0 24 00 00       	call   3a30 <printf>
    exit();
    1580:	e8 3d 23 00 00       	call   38c2 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1585:	50                   	push   %eax
    1586:	50                   	push   %eax
    1587:	68 68 42 00 00       	push   $0x4268
    158c:	6a 01                	push   $0x1
    158e:	e8 9d 24 00 00       	call   3a30 <printf>
    exit();
    1593:	e8 2a 23 00 00       	call   38c2 <exit>
    1598:	90                   	nop
    1599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015a0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    15a0:	55                   	push   %ebp
    15a1:	89 e5                	mov    %esp,%ebp
    15a3:	53                   	push   %ebx
    15a4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    15a7:	68 f4 42 00 00       	push   $0x42f4
    15ac:	6a 01                	push   $0x1
    15ae:	e8 7d 24 00 00       	call   3a30 <printf>

  unlink("lf1");
    15b3:	c7 04 24 fe 42 00 00 	movl   $0x42fe,(%esp)
    15ba:	e8 53 23 00 00       	call   3912 <unlink>
  unlink("lf2");
    15bf:	c7 04 24 02 43 00 00 	movl   $0x4302,(%esp)
    15c6:	e8 47 23 00 00       	call   3912 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    15cb:	58                   	pop    %eax
    15cc:	5a                   	pop    %edx
    15cd:	68 02 02 00 00       	push   $0x202
    15d2:	68 fe 42 00 00       	push   $0x42fe
    15d7:	e8 26 23 00 00       	call   3902 <open>
  if(fd < 0){
    15dc:	83 c4 10             	add    $0x10,%esp
    15df:	85 c0                	test   %eax,%eax
    15e1:	0f 88 1e 01 00 00    	js     1705 <linktest+0x165>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    15e7:	83 ec 04             	sub    $0x4,%esp
    15ea:	89 c3                	mov    %eax,%ebx
    15ec:	6a 05                	push   $0x5
    15ee:	68 62 42 00 00       	push   $0x4262
    15f3:	50                   	push   %eax
    15f4:	e8 e9 22 00 00       	call   38e2 <write>
    15f9:	83 c4 10             	add    $0x10,%esp
    15fc:	83 f8 05             	cmp    $0x5,%eax
    15ff:	0f 85 98 01 00 00    	jne    179d <linktest+0x1fd>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1605:	83 ec 0c             	sub    $0xc,%esp
    1608:	53                   	push   %ebx
    1609:	e8 dc 22 00 00       	call   38ea <close>

  if(link("lf1", "lf2") < 0){
    160e:	5b                   	pop    %ebx
    160f:	58                   	pop    %eax
    1610:	68 02 43 00 00       	push   $0x4302
    1615:	68 fe 42 00 00       	push   $0x42fe
    161a:	e8 03 23 00 00       	call   3922 <link>
    161f:	83 c4 10             	add    $0x10,%esp
    1622:	85 c0                	test   %eax,%eax
    1624:	0f 88 60 01 00 00    	js     178a <linktest+0x1ea>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    162a:	83 ec 0c             	sub    $0xc,%esp
    162d:	68 fe 42 00 00       	push   $0x42fe
    1632:	e8 db 22 00 00       	call   3912 <unlink>

  if(open("lf1", 0) >= 0){
    1637:	58                   	pop    %eax
    1638:	5a                   	pop    %edx
    1639:	6a 00                	push   $0x0
    163b:	68 fe 42 00 00       	push   $0x42fe
    1640:	e8 bd 22 00 00       	call   3902 <open>
    1645:	83 c4 10             	add    $0x10,%esp
    1648:	85 c0                	test   %eax,%eax
    164a:	0f 89 27 01 00 00    	jns    1777 <linktest+0x1d7>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1650:	83 ec 08             	sub    $0x8,%esp
    1653:	6a 00                	push   $0x0
    1655:	68 02 43 00 00       	push   $0x4302
    165a:	e8 a3 22 00 00       	call   3902 <open>
  if(fd < 0){
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1664:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1666:	0f 88 f8 00 00 00    	js     1764 <linktest+0x1c4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    166c:	83 ec 04             	sub    $0x4,%esp
    166f:	68 00 20 00 00       	push   $0x2000
    1674:	68 c0 85 00 00       	push   $0x85c0
    1679:	50                   	push   %eax
    167a:	e8 5b 22 00 00       	call   38da <read>
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	83 f8 05             	cmp    $0x5,%eax
    1685:	0f 85 c6 00 00 00    	jne    1751 <linktest+0x1b1>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    168b:	83 ec 0c             	sub    $0xc,%esp
    168e:	53                   	push   %ebx
    168f:	e8 56 22 00 00       	call   38ea <close>

  if(link("lf2", "lf2") >= 0){
    1694:	58                   	pop    %eax
    1695:	5a                   	pop    %edx
    1696:	68 02 43 00 00       	push   $0x4302
    169b:	68 02 43 00 00       	push   $0x4302
    16a0:	e8 7d 22 00 00       	call   3922 <link>
    16a5:	83 c4 10             	add    $0x10,%esp
    16a8:	85 c0                	test   %eax,%eax
    16aa:	0f 89 8e 00 00 00    	jns    173e <linktest+0x19e>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    16b0:	83 ec 0c             	sub    $0xc,%esp
    16b3:	68 02 43 00 00       	push   $0x4302
    16b8:	e8 55 22 00 00       	call   3912 <unlink>
  if(link("lf2", "lf1") >= 0){
    16bd:	59                   	pop    %ecx
    16be:	5b                   	pop    %ebx
    16bf:	68 fe 42 00 00       	push   $0x42fe
    16c4:	68 02 43 00 00       	push   $0x4302
    16c9:	e8 54 22 00 00       	call   3922 <link>
    16ce:	83 c4 10             	add    $0x10,%esp
    16d1:	85 c0                	test   %eax,%eax
    16d3:	79 56                	jns    172b <linktest+0x18b>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    16d5:	83 ec 08             	sub    $0x8,%esp
    16d8:	68 fe 42 00 00       	push   $0x42fe
    16dd:	68 c6 45 00 00       	push   $0x45c6
    16e2:	e8 3b 22 00 00       	call   3922 <link>
    16e7:	83 c4 10             	add    $0x10,%esp
    16ea:	85 c0                	test   %eax,%eax
    16ec:	79 2a                	jns    1718 <linktest+0x178>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    16ee:	83 ec 08             	sub    $0x8,%esp
    16f1:	68 9c 43 00 00       	push   $0x439c
    16f6:	6a 01                	push   $0x1
    16f8:	e8 33 23 00 00       	call   3a30 <printf>
}
    16fd:	83 c4 10             	add    $0x10,%esp
    1700:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1703:	c9                   	leave  
    1704:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1705:	50                   	push   %eax
    1706:	50                   	push   %eax
    1707:	68 06 43 00 00       	push   $0x4306
    170c:	6a 01                	push   $0x1
    170e:	e8 1d 23 00 00       	call   3a30 <printf>
    exit();
    1713:	e8 aa 21 00 00       	call   38c2 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1718:	50                   	push   %eax
    1719:	50                   	push   %eax
    171a:	68 80 43 00 00       	push   $0x4380
    171f:	6a 01                	push   $0x1
    1721:	e8 0a 23 00 00       	call   3a30 <printf>
    exit();
    1726:	e8 97 21 00 00       	call   38c2 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    172b:	52                   	push   %edx
    172c:	52                   	push   %edx
    172d:	68 34 4f 00 00       	push   $0x4f34
    1732:	6a 01                	push   $0x1
    1734:	e8 f7 22 00 00       	call   3a30 <printf>
    exit();
    1739:	e8 84 21 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    173e:	50                   	push   %eax
    173f:	50                   	push   %eax
    1740:	68 62 43 00 00       	push   $0x4362
    1745:	6a 01                	push   $0x1
    1747:	e8 e4 22 00 00       	call   3a30 <printf>
    exit();
    174c:	e8 71 21 00 00       	call   38c2 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1751:	51                   	push   %ecx
    1752:	51                   	push   %ecx
    1753:	68 51 43 00 00       	push   $0x4351
    1758:	6a 01                	push   $0x1
    175a:	e8 d1 22 00 00       	call   3a30 <printf>
    exit();
    175f:	e8 5e 21 00 00       	call   38c2 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1764:	53                   	push   %ebx
    1765:	53                   	push   %ebx
    1766:	68 40 43 00 00       	push   $0x4340
    176b:	6a 01                	push   $0x1
    176d:	e8 be 22 00 00       	call   3a30 <printf>
    exit();
    1772:	e8 4b 21 00 00       	call   38c2 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1777:	50                   	push   %eax
    1778:	50                   	push   %eax
    1779:	68 0c 4f 00 00       	push   $0x4f0c
    177e:	6a 01                	push   $0x1
    1780:	e8 ab 22 00 00       	call   3a30 <printf>
    exit();
    1785:	e8 38 21 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    178a:	51                   	push   %ecx
    178b:	51                   	push   %ecx
    178c:	68 2b 43 00 00       	push   $0x432b
    1791:	6a 01                	push   $0x1
    1793:	e8 98 22 00 00       	call   3a30 <printf>
    exit();
    1798:	e8 25 21 00 00       	call   38c2 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    179d:	50                   	push   %eax
    179e:	50                   	push   %eax
    179f:	68 19 43 00 00       	push   $0x4319
    17a4:	6a 01                	push   $0x1
    17a6:	e8 85 22 00 00       	call   3a30 <printf>
    exit();
    17ab:	e8 12 21 00 00       	call   38c2 <exit>

000017b0 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    17b0:	55                   	push   %ebp
    17b1:	89 e5                	mov    %esp,%ebp
    17b3:	57                   	push   %edi
    17b4:	56                   	push   %esi
    17b5:	53                   	push   %ebx
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    17b6:	31 f6                	xor    %esi,%esi
    17b8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    17bb:	bf 56 55 55 55       	mov    $0x55555556,%edi
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    17c0:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    17c3:	68 a9 43 00 00       	push   $0x43a9
    17c8:	6a 01                	push   $0x1
    17ca:	e8 61 22 00 00       	call   3a30 <printf>
  file[0] = 'C';
    17cf:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17d3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17d7:	83 c4 10             	add    $0x10,%esp
    17da:	eb 51                	jmp    182d <concreate+0x7d>
    17dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    17e0:	89 f0                	mov    %esi,%eax
    17e2:	89 f1                	mov    %esi,%ecx
    17e4:	f7 ef                	imul   %edi
    17e6:	89 f0                	mov    %esi,%eax
    17e8:	c1 f8 1f             	sar    $0x1f,%eax
    17eb:	29 c2                	sub    %eax,%edx
    17ed:	8d 04 52             	lea    (%edx,%edx,2),%eax
    17f0:	29 c1                	sub    %eax,%ecx
    17f2:	83 f9 01             	cmp    $0x1,%ecx
    17f5:	0f 84 b5 00 00 00    	je     18b0 <concreate+0x100>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    17fb:	83 ec 08             	sub    $0x8,%esp
    17fe:	68 02 02 00 00       	push   $0x202
    1803:	53                   	push   %ebx
    1804:	e8 f9 20 00 00       	call   3902 <open>
      if(fd < 0){
    1809:	83 c4 10             	add    $0x10,%esp
    180c:	85 c0                	test   %eax,%eax
    180e:	78 6d                	js     187d <concreate+0xcd>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1810:	83 ec 0c             	sub    $0xc,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1813:	83 c6 01             	add    $0x1,%esi
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1816:	50                   	push   %eax
    1817:	e8 ce 20 00 00       	call   38ea <close>
    181c:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit();
    else
      wait();
    181f:	e8 a6 20 00 00       	call   38ca <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1824:	83 fe 28             	cmp    $0x28,%esi
    1827:	0f 84 ab 00 00 00    	je     18d8 <concreate+0x128>
    file[1] = '0' + i;
    unlink(file);
    182d:	83 ec 0c             	sub    $0xc,%esp

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1830:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    1833:	53                   	push   %ebx

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1834:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1837:	e8 d6 20 00 00       	call   3912 <unlink>
    pid = fork();
    183c:	e8 79 20 00 00       	call   38ba <fork>
    if(pid && (i % 3) == 1){
    1841:	83 c4 10             	add    $0x10,%esp
    1844:	85 c0                	test   %eax,%eax
    1846:	75 98                	jne    17e0 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    1848:	89 f0                	mov    %esi,%eax
    184a:	ba 67 66 66 66       	mov    $0x66666667,%edx
    184f:	f7 ea                	imul   %edx
    1851:	89 f0                	mov    %esi,%eax
    1853:	c1 f8 1f             	sar    $0x1f,%eax
    1856:	d1 fa                	sar    %edx
    1858:	29 c2                	sub    %eax,%edx
    185a:	8d 04 92             	lea    (%edx,%edx,4),%eax
    185d:	29 c6                	sub    %eax,%esi
    185f:	83 fe 01             	cmp    $0x1,%esi
    1862:	74 34                	je     1898 <concreate+0xe8>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1864:	83 ec 08             	sub    $0x8,%esp
    1867:	68 02 02 00 00       	push   $0x202
    186c:	53                   	push   %ebx
    186d:	e8 90 20 00 00       	call   3902 <open>
      if(fd < 0){
    1872:	83 c4 10             	add    $0x10,%esp
    1875:	85 c0                	test   %eax,%eax
    1877:	0f 89 32 02 00 00    	jns    1aaf <concreate+0x2ff>
        printf(1, "concreate create %s failed\n", file);
    187d:	83 ec 04             	sub    $0x4,%esp
    1880:	53                   	push   %ebx
    1881:	68 bc 43 00 00       	push   $0x43bc
    1886:	6a 01                	push   $0x1
    1888:	e8 a3 21 00 00       	call   3a30 <printf>
        exit();
    188d:	e8 30 20 00 00       	call   38c2 <exit>
    1892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    1898:	83 ec 08             	sub    $0x8,%esp
    189b:	53                   	push   %ebx
    189c:	68 b9 43 00 00       	push   $0x43b9
    18a1:	e8 7c 20 00 00       	call   3922 <link>
    18a6:	83 c4 10             	add    $0x10,%esp
        exit();
      }
      close(fd);
    }
    if(pid == 0)
      exit();
    18a9:	e8 14 20 00 00       	call   38c2 <exit>
    18ae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    18b0:	83 ec 08             	sub    $0x8,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    18b3:	83 c6 01             	add    $0x1,%esi
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    18b6:	53                   	push   %ebx
    18b7:	68 b9 43 00 00       	push   $0x43b9
    18bc:	e8 61 20 00 00       	call   3922 <link>
    18c1:	83 c4 10             	add    $0x10,%esp
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    18c4:	e8 01 20 00 00       	call   38ca <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    18c9:	83 fe 28             	cmp    $0x28,%esi
    18cc:	0f 85 5b ff ff ff    	jne    182d <concreate+0x7d>
    18d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    18d8:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18db:	83 ec 04             	sub    $0x4,%esp
    18de:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18e1:	6a 28                	push   $0x28
    18e3:	6a 00                	push   $0x0
    18e5:	50                   	push   %eax
    18e6:	e8 45 1e 00 00       	call   3730 <memset>
  fd = open(".", 0);
    18eb:	59                   	pop    %ecx
    18ec:	5e                   	pop    %esi
    18ed:	6a 00                	push   $0x0
    18ef:	68 c6 45 00 00       	push   $0x45c6
    18f4:	e8 09 20 00 00       	call   3902 <open>
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    18f9:	83 c4 10             	add    $0x10,%esp
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    18fc:	89 c6                	mov    %eax,%esi
  n = 0;
    18fe:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1905:	8d 76 00             	lea    0x0(%esi),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1908:	83 ec 04             	sub    $0x4,%esp
    190b:	6a 10                	push   $0x10
    190d:	57                   	push   %edi
    190e:	56                   	push   %esi
    190f:	e8 c6 1f 00 00       	call   38da <read>
    1914:	83 c4 10             	add    $0x10,%esp
    1917:	85 c0                	test   %eax,%eax
    1919:	7e 3d                	jle    1958 <concreate+0x1a8>
    if(de.inum == 0)
    191b:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1920:	74 e6                	je     1908 <concreate+0x158>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1922:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1926:	75 e0                	jne    1908 <concreate+0x158>
    1928:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    192c:	75 da                	jne    1908 <concreate+0x158>
      i = de.name[1] - '0';
    192e:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1932:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1935:	83 f8 27             	cmp    $0x27,%eax
    1938:	0f 87 59 01 00 00    	ja     1a97 <concreate+0x2e7>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    193e:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1943:	0f 85 36 01 00 00    	jne    1a7f <concreate+0x2cf>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1949:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    194e:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1952:	eb b4                	jmp    1908 <concreate+0x158>
    1954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    1958:	83 ec 0c             	sub    $0xc,%esp
    195b:	56                   	push   %esi
    195c:	e8 89 1f 00 00       	call   38ea <close>

  if(n != 40){
    1961:	83 c4 10             	add    $0x10,%esp
    1964:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1968:	0f 85 fd 00 00 00    	jne    1a6b <concreate+0x2bb>
    196e:	31 f6                	xor    %esi,%esi
    1970:	eb 70                	jmp    19e2 <concreate+0x232>
    1972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
    1978:	83 fa 01             	cmp    $0x1,%edx
    197b:	0f 85 99 00 00 00    	jne    1a1a <concreate+0x26a>
      close(open(file, 0));
    1981:	83 ec 08             	sub    $0x8,%esp
    1984:	6a 00                	push   $0x0
    1986:	53                   	push   %ebx
    1987:	e8 76 1f 00 00       	call   3902 <open>
    198c:	89 04 24             	mov    %eax,(%esp)
    198f:	e8 56 1f 00 00       	call   38ea <close>
      close(open(file, 0));
    1994:	58                   	pop    %eax
    1995:	5a                   	pop    %edx
    1996:	6a 00                	push   $0x0
    1998:	53                   	push   %ebx
    1999:	e8 64 1f 00 00       	call   3902 <open>
    199e:	89 04 24             	mov    %eax,(%esp)
    19a1:	e8 44 1f 00 00       	call   38ea <close>
      close(open(file, 0));
    19a6:	59                   	pop    %ecx
    19a7:	58                   	pop    %eax
    19a8:	6a 00                	push   $0x0
    19aa:	53                   	push   %ebx
    19ab:	e8 52 1f 00 00       	call   3902 <open>
    19b0:	89 04 24             	mov    %eax,(%esp)
    19b3:	e8 32 1f 00 00       	call   38ea <close>
      close(open(file, 0));
    19b8:	58                   	pop    %eax
    19b9:	5a                   	pop    %edx
    19ba:	6a 00                	push   $0x0
    19bc:	53                   	push   %ebx
    19bd:	e8 40 1f 00 00       	call   3902 <open>
    19c2:	89 04 24             	mov    %eax,(%esp)
    19c5:	e8 20 1f 00 00       	call   38ea <close>
    19ca:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    19cd:	85 ff                	test   %edi,%edi
    19cf:	0f 84 d4 fe ff ff    	je     18a9 <concreate+0xf9>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    19d5:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    19d8:	e8 ed 1e 00 00       	call   38ca <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    19dd:	83 fe 28             	cmp    $0x28,%esi
    19e0:	74 5e                	je     1a40 <concreate+0x290>
    file[1] = '0' + i;
    19e2:	8d 46 30             	lea    0x30(%esi),%eax
    19e5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19e8:	e8 cd 1e 00 00       	call   38ba <fork>
    if(pid < 0){
    19ed:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    19ef:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19f1:	78 64                	js     1a57 <concreate+0x2a7>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    19f3:	b8 56 55 55 55       	mov    $0x55555556,%eax
    19f8:	f7 ee                	imul   %esi
    19fa:	89 f0                	mov    %esi,%eax
    19fc:	c1 f8 1f             	sar    $0x1f,%eax
    19ff:	29 c2                	sub    %eax,%edx
    1a01:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a04:	89 f2                	mov    %esi,%edx
    1a06:	29 c2                	sub    %eax,%edx
    1a08:	89 f8                	mov    %edi,%eax
    1a0a:	09 d0                	or     %edx,%eax
    1a0c:	0f 84 6f ff ff ff    	je     1981 <concreate+0x1d1>
       ((i % 3) == 1 && pid != 0)){
    1a12:	85 ff                	test   %edi,%edi
    1a14:	0f 85 5e ff ff ff    	jne    1978 <concreate+0x1c8>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1a1a:	83 ec 0c             	sub    $0xc,%esp
    1a1d:	53                   	push   %ebx
    1a1e:	e8 ef 1e 00 00       	call   3912 <unlink>
      unlink(file);
    1a23:	89 1c 24             	mov    %ebx,(%esp)
    1a26:	e8 e7 1e 00 00       	call   3912 <unlink>
      unlink(file);
    1a2b:	89 1c 24             	mov    %ebx,(%esp)
    1a2e:	e8 df 1e 00 00       	call   3912 <unlink>
      unlink(file);
    1a33:	89 1c 24             	mov    %ebx,(%esp)
    1a36:	e8 d7 1e 00 00       	call   3912 <unlink>
    1a3b:	83 c4 10             	add    $0x10,%esp
    1a3e:	eb 8d                	jmp    19cd <concreate+0x21d>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1a40:	83 ec 08             	sub    $0x8,%esp
    1a43:	68 0e 44 00 00       	push   $0x440e
    1a48:	6a 01                	push   $0x1
    1a4a:	e8 e1 1f 00 00       	call   3a30 <printf>
}
    1a4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a52:	5b                   	pop    %ebx
    1a53:	5e                   	pop    %esi
    1a54:	5f                   	pop    %edi
    1a55:	5d                   	pop    %ebp
    1a56:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1a57:	83 ec 08             	sub    $0x8,%esp
    1a5a:	68 91 4c 00 00       	push   $0x4c91
    1a5f:	6a 01                	push   $0x1
    1a61:	e8 ca 1f 00 00       	call   3a30 <printf>
      exit();
    1a66:	e8 57 1e 00 00       	call   38c2 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    1a6b:	83 ec 08             	sub    $0x8,%esp
    1a6e:	68 58 4f 00 00       	push   $0x4f58
    1a73:	6a 01                	push   $0x1
    1a75:	e8 b6 1f 00 00       	call   3a30 <printf>
    exit();
    1a7a:	e8 43 1e 00 00       	call   38c2 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    1a7f:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a82:	83 ec 04             	sub    $0x4,%esp
    1a85:	50                   	push   %eax
    1a86:	68 f1 43 00 00       	push   $0x43f1
    1a8b:	6a 01                	push   $0x1
    1a8d:	e8 9e 1f 00 00       	call   3a30 <printf>
        exit();
    1a92:	e8 2b 1e 00 00       	call   38c2 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1a97:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a9a:	83 ec 04             	sub    $0x4,%esp
    1a9d:	50                   	push   %eax
    1a9e:	68 d8 43 00 00       	push   $0x43d8
    1aa3:	6a 01                	push   $0x1
    1aa5:	e8 86 1f 00 00       	call   3a30 <printf>
        exit();
    1aaa:	e8 13 1e 00 00       	call   38c2 <exit>
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1aaf:	83 ec 0c             	sub    $0xc,%esp
    1ab2:	50                   	push   %eax
    1ab3:	e8 32 1e 00 00       	call   38ea <close>
    1ab8:	83 c4 10             	add    $0x10,%esp
    1abb:	e9 e9 fd ff ff       	jmp    18a9 <concreate+0xf9>

00001ac0 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	57                   	push   %edi
    1ac4:	56                   	push   %esi
    1ac5:	53                   	push   %ebx
    1ac6:	83 ec 24             	sub    $0x24,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1ac9:	68 1c 44 00 00       	push   $0x441c
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 5b 1f 00 00       	call   3a30 <printf>

  unlink("x");
    1ad5:	c7 04 24 a9 46 00 00 	movl   $0x46a9,(%esp)
    1adc:	e8 31 1e 00 00       	call   3912 <unlink>
  pid = fork();
    1ae1:	e8 d4 1d 00 00       	call   38ba <fork>
  if(pid < 0){
    1ae6:	83 c4 10             	add    $0x10,%esp
    1ae9:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    1aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1aee:	0f 88 b6 00 00 00    	js     1baa <linkunlink+0xea>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1af4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1af8:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1afd:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1b02:	19 ff                	sbb    %edi,%edi
    1b04:	83 e7 60             	and    $0x60,%edi
    1b07:	83 c7 01             	add    $0x1,%edi
    1b0a:	eb 1e                	jmp    1b2a <linkunlink+0x6a>
    1b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1b10:	83 fa 01             	cmp    $0x1,%edx
    1b13:	74 7b                	je     1b90 <linkunlink+0xd0>
      link("cat", "x");
    } else {
      unlink("x");
    1b15:	83 ec 0c             	sub    $0xc,%esp
    1b18:	68 a9 46 00 00       	push   $0x46a9
    1b1d:	e8 f0 1d 00 00       	call   3912 <unlink>
    1b22:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b25:	83 eb 01             	sub    $0x1,%ebx
    1b28:	74 3d                	je     1b67 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1b2a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b30:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b36:	89 f8                	mov    %edi,%eax
    1b38:	f7 e6                	mul    %esi
    1b3a:	d1 ea                	shr    %edx
    1b3c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b3f:	89 fa                	mov    %edi,%edx
    1b41:	29 c2                	sub    %eax,%edx
    1b43:	75 cb                	jne    1b10 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b45:	83 ec 08             	sub    $0x8,%esp
    1b48:	68 02 02 00 00       	push   $0x202
    1b4d:	68 a9 46 00 00       	push   $0x46a9
    1b52:	e8 ab 1d 00 00       	call   3902 <open>
    1b57:	89 04 24             	mov    %eax,(%esp)
    1b5a:	e8 8b 1d 00 00       	call   38ea <close>
    1b5f:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b62:	83 eb 01             	sub    $0x1,%ebx
    1b65:	75 c3                	jne    1b2a <linkunlink+0x6a>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1b67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	74 50                	je     1bbe <linkunlink+0xfe>
    wait();
    1b6e:	e8 57 1d 00 00       	call   38ca <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    1b73:	83 ec 08             	sub    $0x8,%esp
    1b76:	68 31 44 00 00       	push   $0x4431
    1b7b:	6a 01                	push   $0x1
    1b7d:	e8 ae 1e 00 00       	call   3a30 <printf>
}
    1b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b85:	5b                   	pop    %ebx
    1b86:	5e                   	pop    %esi
    1b87:	5f                   	pop    %edi
    1b88:	5d                   	pop    %ebp
    1b89:	c3                   	ret    
    1b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	68 a9 46 00 00       	push   $0x46a9
    1b98:	68 2d 44 00 00       	push   $0x442d
    1b9d:	e8 80 1d 00 00       	call   3922 <link>
    1ba2:	83 c4 10             	add    $0x10,%esp
    1ba5:	e9 7b ff ff ff       	jmp    1b25 <linkunlink+0x65>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1baa:	83 ec 08             	sub    $0x8,%esp
    1bad:	68 91 4c 00 00       	push   $0x4c91
    1bb2:	6a 01                	push   $0x1
    1bb4:	e8 77 1e 00 00       	call   3a30 <printf>
    exit();
    1bb9:	e8 04 1d 00 00       	call   38c2 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1bbe:	e8 ff 1c 00 00       	call   38c2 <exit>
    1bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bd0 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	56                   	push   %esi
    1bd5:	53                   	push   %ebx
    1bd6:	83 ec 24             	sub    $0x24,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1bd9:	68 40 44 00 00       	push   $0x4440
    1bde:	6a 01                	push   $0x1
    1be0:	e8 4b 1e 00 00       	call   3a30 <printf>
  unlink("bd");
    1be5:	c7 04 24 4d 44 00 00 	movl   $0x444d,(%esp)
    1bec:	e8 21 1d 00 00       	call   3912 <unlink>

  fd = open("bd", O_CREATE);
    1bf1:	58                   	pop    %eax
    1bf2:	5a                   	pop    %edx
    1bf3:	68 00 02 00 00       	push   $0x200
    1bf8:	68 4d 44 00 00       	push   $0x444d
    1bfd:	e8 00 1d 00 00       	call   3902 <open>
  if(fd < 0){
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	85 c0                	test   %eax,%eax
    1c07:	0f 88 de 00 00 00    	js     1ceb <bigdir+0x11b>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	8d 7d de             	lea    -0x22(%ebp),%edi

  for(i = 0; i < 500; i++){
    1c13:	31 f6                	xor    %esi,%esi
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1c15:	50                   	push   %eax
    1c16:	e8 cf 1c 00 00       	call   38ea <close>
    1c1b:	83 c4 10             	add    $0x10,%esp
    1c1e:	66 90                	xchg   %ax,%ax

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c20:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1c22:	83 ec 08             	sub    $0x8,%esp
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1c25:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c29:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1c2c:	57                   	push   %edi
    1c2d:	68 4d 44 00 00       	push   $0x444d
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c32:	83 c0 30             	add    $0x30,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1c35:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c39:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c3c:	89 f0                	mov    %esi,%eax
    1c3e:	83 e0 3f             	and    $0x3f,%eax
    1c41:	83 c0 30             	add    $0x30,%eax
    1c44:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    if(link("bd", name) != 0){
    1c47:	e8 d6 1c 00 00       	call   3922 <link>
    1c4c:	83 c4 10             	add    $0x10,%esp
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	89 c3                	mov    %eax,%ebx
    1c53:	75 6e                	jne    1cc3 <bigdir+0xf3>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1c55:	83 c6 01             	add    $0x1,%esi
    1c58:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c5e:	75 c0                	jne    1c20 <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	68 4d 44 00 00       	push   $0x444d
    1c68:	e8 a5 1c 00 00       	call   3912 <unlink>
    1c6d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c70:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1c72:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1c75:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c79:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1c7c:	57                   	push   %edi
  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1c7d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c81:	83 c0 30             	add    $0x30,%eax
    1c84:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c87:	89 d8                	mov    %ebx,%eax
    1c89:	83 e0 3f             	and    $0x3f,%eax
    1c8c:	83 c0 30             	add    $0x30,%eax
    1c8f:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    if(unlink(name) != 0){
    1c92:	e8 7b 1c 00 00       	call   3912 <unlink>
    1c97:	83 c4 10             	add    $0x10,%esp
    1c9a:	85 c0                	test   %eax,%eax
    1c9c:	75 39                	jne    1cd7 <bigdir+0x107>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1c9e:	83 c3 01             	add    $0x1,%ebx
    1ca1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ca7:	75 c7                	jne    1c70 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1ca9:	83 ec 08             	sub    $0x8,%esp
    1cac:	68 8f 44 00 00       	push   $0x448f
    1cb1:	6a 01                	push   $0x1
    1cb3:	e8 78 1d 00 00       	call   3a30 <printf>
}
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cbe:	5b                   	pop    %ebx
    1cbf:	5e                   	pop    %esi
    1cc0:	5f                   	pop    %edi
    1cc1:	5d                   	pop    %ebp
    1cc2:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1cc3:	83 ec 08             	sub    $0x8,%esp
    1cc6:	68 66 44 00 00       	push   $0x4466
    1ccb:	6a 01                	push   $0x1
    1ccd:	e8 5e 1d 00 00       	call   3a30 <printf>
      exit();
    1cd2:	e8 eb 1b 00 00       	call   38c2 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1cd7:	83 ec 08             	sub    $0x8,%esp
    1cda:	68 7a 44 00 00       	push   $0x447a
    1cdf:	6a 01                	push   $0x1
    1ce1:	e8 4a 1d 00 00       	call   3a30 <printf>
      exit();
    1ce6:	e8 d7 1b 00 00       	call   38c2 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1ceb:	83 ec 08             	sub    $0x8,%esp
    1cee:	68 50 44 00 00       	push   $0x4450
    1cf3:	6a 01                	push   $0x1
    1cf5:	e8 36 1d 00 00       	call   3a30 <printf>
    exit();
    1cfa:	e8 c3 1b 00 00       	call   38c2 <exit>
    1cff:	90                   	nop

00001d00 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    1d03:	53                   	push   %ebx
    1d04:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1d07:	68 9a 44 00 00       	push   $0x449a
    1d0c:	6a 01                	push   $0x1
    1d0e:	e8 1d 1d 00 00       	call   3a30 <printf>

  unlink("ff");
    1d13:	c7 04 24 23 45 00 00 	movl   $0x4523,(%esp)
    1d1a:	e8 f3 1b 00 00       	call   3912 <unlink>
  if(mkdir("dd") != 0){
    1d1f:	c7 04 24 c0 45 00 00 	movl   $0x45c0,(%esp)
    1d26:	e8 ff 1b 00 00       	call   392a <mkdir>
    1d2b:	83 c4 10             	add    $0x10,%esp
    1d2e:	85 c0                	test   %eax,%eax
    1d30:	0f 85 b3 05 00 00    	jne    22e9 <subdir+0x5e9>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d36:	83 ec 08             	sub    $0x8,%esp
    1d39:	68 02 02 00 00       	push   $0x202
    1d3e:	68 f9 44 00 00       	push   $0x44f9
    1d43:	e8 ba 1b 00 00       	call   3902 <open>
  if(fd < 0){
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d4d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d4f:	0f 88 81 05 00 00    	js     22d6 <subdir+0x5d6>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1d55:	83 ec 04             	sub    $0x4,%esp
    1d58:	6a 02                	push   $0x2
    1d5a:	68 23 45 00 00       	push   $0x4523
    1d5f:	50                   	push   %eax
    1d60:	e8 7d 1b 00 00       	call   38e2 <write>
  close(fd);
    1d65:	89 1c 24             	mov    %ebx,(%esp)
    1d68:	e8 7d 1b 00 00       	call   38ea <close>

  if(unlink("dd") >= 0){
    1d6d:	c7 04 24 c0 45 00 00 	movl   $0x45c0,(%esp)
    1d74:	e8 99 1b 00 00       	call   3912 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	0f 89 3f 05 00 00    	jns    22c3 <subdir+0x5c3>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	68 d4 44 00 00       	push   $0x44d4
    1d8c:	e8 99 1b 00 00       	call   392a <mkdir>
    1d91:	83 c4 10             	add    $0x10,%esp
    1d94:	85 c0                	test   %eax,%eax
    1d96:	0f 85 14 05 00 00    	jne    22b0 <subdir+0x5b0>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	68 02 02 00 00       	push   $0x202
    1da4:	68 f6 44 00 00       	push   $0x44f6
    1da9:	e8 54 1b 00 00       	call   3902 <open>
  if(fd < 0){
    1dae:	83 c4 10             	add    $0x10,%esp
    1db1:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1db3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1db5:	0f 88 24 04 00 00    	js     21df <subdir+0x4df>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1dbb:	83 ec 04             	sub    $0x4,%esp
    1dbe:	6a 02                	push   $0x2
    1dc0:	68 17 45 00 00       	push   $0x4517
    1dc5:	50                   	push   %eax
    1dc6:	e8 17 1b 00 00       	call   38e2 <write>
  close(fd);
    1dcb:	89 1c 24             	mov    %ebx,(%esp)
    1dce:	e8 17 1b 00 00       	call   38ea <close>

  fd = open("dd/dd/../ff", 0);
    1dd3:	58                   	pop    %eax
    1dd4:	5a                   	pop    %edx
    1dd5:	6a 00                	push   $0x0
    1dd7:	68 1a 45 00 00       	push   $0x451a
    1ddc:	e8 21 1b 00 00       	call   3902 <open>
  if(fd < 0){
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1de6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1de8:	0f 88 de 03 00 00    	js     21cc <subdir+0x4cc>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1dee:	83 ec 04             	sub    $0x4,%esp
    1df1:	68 00 20 00 00       	push   $0x2000
    1df6:	68 c0 85 00 00       	push   $0x85c0
    1dfb:	50                   	push   %eax
    1dfc:	e8 d9 1a 00 00       	call   38da <read>
  if(cc != 2 || buf[0] != 'f'){
    1e01:	83 c4 10             	add    $0x10,%esp
    1e04:	83 f8 02             	cmp    $0x2,%eax
    1e07:	0f 85 3a 03 00 00    	jne    2147 <subdir+0x447>
    1e0d:	80 3d c0 85 00 00 66 	cmpb   $0x66,0x85c0
    1e14:	0f 85 2d 03 00 00    	jne    2147 <subdir+0x447>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1e1a:	83 ec 0c             	sub    $0xc,%esp
    1e1d:	53                   	push   %ebx
    1e1e:	e8 c7 1a 00 00       	call   38ea <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e23:	5b                   	pop    %ebx
    1e24:	58                   	pop    %eax
    1e25:	68 5a 45 00 00       	push   $0x455a
    1e2a:	68 f6 44 00 00       	push   $0x44f6
    1e2f:	e8 ee 1a 00 00       	call   3922 <link>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	85 c0                	test   %eax,%eax
    1e39:	0f 85 c6 03 00 00    	jne    2205 <subdir+0x505>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	68 f6 44 00 00       	push   $0x44f6
    1e47:	e8 c6 1a 00 00       	call   3912 <unlink>
    1e4c:	83 c4 10             	add    $0x10,%esp
    1e4f:	85 c0                	test   %eax,%eax
    1e51:	0f 85 16 03 00 00    	jne    216d <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e57:	83 ec 08             	sub    $0x8,%esp
    1e5a:	6a 00                	push   $0x0
    1e5c:	68 f6 44 00 00       	push   $0x44f6
    1e61:	e8 9c 1a 00 00       	call   3902 <open>
    1e66:	83 c4 10             	add    $0x10,%esp
    1e69:	85 c0                	test   %eax,%eax
    1e6b:	0f 89 2c 04 00 00    	jns    229d <subdir+0x59d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1e71:	83 ec 0c             	sub    $0xc,%esp
    1e74:	68 c0 45 00 00       	push   $0x45c0
    1e79:	e8 b4 1a 00 00       	call   3932 <chdir>
    1e7e:	83 c4 10             	add    $0x10,%esp
    1e81:	85 c0                	test   %eax,%eax
    1e83:	0f 85 01 04 00 00    	jne    228a <subdir+0x58a>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1e89:	83 ec 0c             	sub    $0xc,%esp
    1e8c:	68 8e 45 00 00       	push   $0x458e
    1e91:	e8 9c 1a 00 00       	call   3932 <chdir>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 85 b9 02 00 00    	jne    215a <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 b4 45 00 00       	push   $0x45b4
    1ea9:	e8 84 1a 00 00       	call   3932 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 a1 02 00 00    	jne    215a <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 c3 45 00 00       	push   $0x45c3
    1ec1:	e8 6c 1a 00 00       	call   3932 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 21 03 00 00    	jne    21f2 <subdir+0x4f2>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	6a 00                	push   $0x0
    1ed6:	68 5a 45 00 00       	push   $0x455a
    1edb:	e8 22 1a 00 00       	call   3902 <open>
  if(fd < 0){
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1ee5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ee7:	0f 88 e0 04 00 00    	js     23cd <subdir+0x6cd>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1eed:	83 ec 04             	sub    $0x4,%esp
    1ef0:	68 00 20 00 00       	push   $0x2000
    1ef5:	68 c0 85 00 00       	push   $0x85c0
    1efa:	50                   	push   %eax
    1efb:	e8 da 19 00 00       	call   38da <read>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	83 f8 02             	cmp    $0x2,%eax
    1f06:	0f 85 ae 04 00 00    	jne    23ba <subdir+0x6ba>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	53                   	push   %ebx
    1f10:	e8 d5 19 00 00       	call   38ea <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f15:	59                   	pop    %ecx
    1f16:	5b                   	pop    %ebx
    1f17:	6a 00                	push   $0x0
    1f19:	68 f6 44 00 00       	push   $0x44f6
    1f1e:	e8 df 19 00 00       	call   3902 <open>
    1f23:	83 c4 10             	add    $0x10,%esp
    1f26:	85 c0                	test   %eax,%eax
    1f28:	0f 89 65 02 00 00    	jns    2193 <subdir+0x493>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f2e:	83 ec 08             	sub    $0x8,%esp
    1f31:	68 02 02 00 00       	push   $0x202
    1f36:	68 0e 46 00 00       	push   $0x460e
    1f3b:	e8 c2 19 00 00       	call   3902 <open>
    1f40:	83 c4 10             	add    $0x10,%esp
    1f43:	85 c0                	test   %eax,%eax
    1f45:	0f 89 35 02 00 00    	jns    2180 <subdir+0x480>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f4b:	83 ec 08             	sub    $0x8,%esp
    1f4e:	68 02 02 00 00       	push   $0x202
    1f53:	68 33 46 00 00       	push   $0x4633
    1f58:	e8 a5 19 00 00       	call   3902 <open>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 89 0f 03 00 00    	jns    2277 <subdir+0x577>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 00 02 00 00       	push   $0x200
    1f70:	68 c0 45 00 00       	push   $0x45c0
    1f75:	e8 88 19 00 00       	call   3902 <open>
    1f7a:	83 c4 10             	add    $0x10,%esp
    1f7d:	85 c0                	test   %eax,%eax
    1f7f:	0f 89 df 02 00 00    	jns    2264 <subdir+0x564>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	6a 02                	push   $0x2
    1f8a:	68 c0 45 00 00       	push   $0x45c0
    1f8f:	e8 6e 19 00 00       	call   3902 <open>
    1f94:	83 c4 10             	add    $0x10,%esp
    1f97:	85 c0                	test   %eax,%eax
    1f99:	0f 89 b2 02 00 00    	jns    2251 <subdir+0x551>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1f9f:	83 ec 08             	sub    $0x8,%esp
    1fa2:	6a 01                	push   $0x1
    1fa4:	68 c0 45 00 00       	push   $0x45c0
    1fa9:	e8 54 19 00 00       	call   3902 <open>
    1fae:	83 c4 10             	add    $0x10,%esp
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	0f 89 85 02 00 00    	jns    223e <subdir+0x53e>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fb9:	83 ec 08             	sub    $0x8,%esp
    1fbc:	68 a2 46 00 00       	push   $0x46a2
    1fc1:	68 0e 46 00 00       	push   $0x460e
    1fc6:	e8 57 19 00 00       	call   3922 <link>
    1fcb:	83 c4 10             	add    $0x10,%esp
    1fce:	85 c0                	test   %eax,%eax
    1fd0:	0f 84 55 02 00 00    	je     222b <subdir+0x52b>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1fd6:	83 ec 08             	sub    $0x8,%esp
    1fd9:	68 a2 46 00 00       	push   $0x46a2
    1fde:	68 33 46 00 00       	push   $0x4633
    1fe3:	e8 3a 19 00 00       	call   3922 <link>
    1fe8:	83 c4 10             	add    $0x10,%esp
    1feb:	85 c0                	test   %eax,%eax
    1fed:	0f 84 25 02 00 00    	je     2218 <subdir+0x518>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1ff3:	83 ec 08             	sub    $0x8,%esp
    1ff6:	68 5a 45 00 00       	push   $0x455a
    1ffb:	68 f9 44 00 00       	push   $0x44f9
    2000:	e8 1d 19 00 00       	call   3922 <link>
    2005:	83 c4 10             	add    $0x10,%esp
    2008:	85 c0                	test   %eax,%eax
    200a:	0f 84 a9 01 00 00    	je     21b9 <subdir+0x4b9>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    2010:	83 ec 0c             	sub    $0xc,%esp
    2013:	68 0e 46 00 00       	push   $0x460e
    2018:	e8 0d 19 00 00       	call   392a <mkdir>
    201d:	83 c4 10             	add    $0x10,%esp
    2020:	85 c0                	test   %eax,%eax
    2022:	0f 84 7e 01 00 00    	je     21a6 <subdir+0x4a6>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    2028:	83 ec 0c             	sub    $0xc,%esp
    202b:	68 33 46 00 00       	push   $0x4633
    2030:	e8 f5 18 00 00       	call   392a <mkdir>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 67 03 00 00    	je     23a7 <subdir+0x6a7>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 5a 45 00 00       	push   $0x455a
    2048:	e8 dd 18 00 00       	call   392a <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 3c 03 00 00    	je     2394 <subdir+0x694>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 33 46 00 00       	push   $0x4633
    2060:	e8 ad 18 00 00       	call   3912 <unlink>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 11 03 00 00    	je     2381 <subdir+0x681>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 0e 46 00 00       	push   $0x460e
    2078:	e8 95 18 00 00       	call   3912 <unlink>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 e6 02 00 00    	je     236e <subdir+0x66e>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 f9 44 00 00       	push   $0x44f9
    2090:	e8 9d 18 00 00       	call   3932 <chdir>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 bb 02 00 00    	je     235b <subdir+0x65b>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 a5 46 00 00       	push   $0x46a5
    20a8:	e8 85 18 00 00       	call   3932 <chdir>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 90 02 00 00    	je     2348 <subdir+0x648>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 5a 45 00 00       	push   $0x455a
    20c0:	e8 4d 18 00 00       	call   3912 <unlink>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 85 9d 00 00 00    	jne    216d <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 f9 44 00 00       	push   $0x44f9
    20d8:	e8 35 18 00 00       	call   3912 <unlink>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 85 4d 02 00 00    	jne    2335 <subdir+0x635>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 c0 45 00 00       	push   $0x45c0
    20f0:	e8 1d 18 00 00       	call   3912 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 84 22 02 00 00    	je     2322 <subdir+0x622>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 d5 44 00 00       	push   $0x44d5
    2108:	e8 05 18 00 00       	call   3912 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 88 f7 01 00 00    	js     230f <subdir+0x60f>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 c0 45 00 00       	push   $0x45c0
    2120:	e8 ed 17 00 00       	call   3912 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 88 cc 01 00 00    	js     22fc <subdir+0x5fc>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	68 a2 47 00 00       	push   $0x47a2
    2138:	6a 01                	push   $0x1
    213a:	e8 f1 18 00 00       	call   3a30 <printf>
}
    213f:	83 c4 10             	add    $0x10,%esp
    2142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2145:	c9                   	leave  
    2146:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    2147:	50                   	push   %eax
    2148:	50                   	push   %eax
    2149:	68 3f 45 00 00       	push   $0x453f
    214e:	6a 01                	push   $0x1
    2150:	e8 db 18 00 00       	call   3a30 <printf>
    exit();
    2155:	e8 68 17 00 00       	call   38c2 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    215a:	50                   	push   %eax
    215b:	50                   	push   %eax
    215c:	68 9a 45 00 00       	push   $0x459a
    2161:	6a 01                	push   $0x1
    2163:	e8 c8 18 00 00       	call   3a30 <printf>
    exit();
    2168:	e8 55 17 00 00       	call   38c2 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    216d:	52                   	push   %edx
    216e:	52                   	push   %edx
    216f:	68 65 45 00 00       	push   $0x4565
    2174:	6a 01                	push   $0x1
    2176:	e8 b5 18 00 00       	call   3a30 <printf>
    exit();
    217b:	e8 42 17 00 00       	call   38c2 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    2180:	50                   	push   %eax
    2181:	50                   	push   %eax
    2182:	68 17 46 00 00       	push   $0x4617
    2187:	6a 01                	push   $0x1
    2189:	e8 a2 18 00 00       	call   3a30 <printf>
    exit();
    218e:	e8 2f 17 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2193:	52                   	push   %edx
    2194:	52                   	push   %edx
    2195:	68 fc 4f 00 00       	push   $0x4ffc
    219a:	6a 01                	push   $0x1
    219c:	e8 8f 18 00 00       	call   3a30 <printf>
    exit();
    21a1:	e8 1c 17 00 00       	call   38c2 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21a6:	52                   	push   %edx
    21a7:	52                   	push   %edx
    21a8:	68 ab 46 00 00       	push   $0x46ab
    21ad:	6a 01                	push   $0x1
    21af:	e8 7c 18 00 00       	call   3a30 <printf>
    exit();
    21b4:	e8 09 17 00 00       	call   38c2 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21b9:	51                   	push   %ecx
    21ba:	51                   	push   %ecx
    21bb:	68 6c 50 00 00       	push   $0x506c
    21c0:	6a 01                	push   $0x1
    21c2:	e8 69 18 00 00       	call   3a30 <printf>
    exit();
    21c7:	e8 f6 16 00 00       	call   38c2 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    21cc:	50                   	push   %eax
    21cd:	50                   	push   %eax
    21ce:	68 26 45 00 00       	push   $0x4526
    21d3:	6a 01                	push   $0x1
    21d5:	e8 56 18 00 00       	call   3a30 <printf>
    exit();
    21da:	e8 e3 16 00 00       	call   38c2 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    21df:	51                   	push   %ecx
    21e0:	51                   	push   %ecx
    21e1:	68 ff 44 00 00       	push   $0x44ff
    21e6:	6a 01                	push   $0x1
    21e8:	e8 43 18 00 00       	call   3a30 <printf>
    exit();
    21ed:	e8 d0 16 00 00       	call   38c2 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    21f2:	50                   	push   %eax
    21f3:	50                   	push   %eax
    21f4:	68 c8 45 00 00       	push   $0x45c8
    21f9:	6a 01                	push   $0x1
    21fb:	e8 30 18 00 00       	call   3a30 <printf>
    exit();
    2200:	e8 bd 16 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2205:	51                   	push   %ecx
    2206:	51                   	push   %ecx
    2207:	68 b4 4f 00 00       	push   $0x4fb4
    220c:	6a 01                	push   $0x1
    220e:	e8 1d 18 00 00       	call   3a30 <printf>
    exit();
    2213:	e8 aa 16 00 00       	call   38c2 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2218:	53                   	push   %ebx
    2219:	53                   	push   %ebx
    221a:	68 48 50 00 00       	push   $0x5048
    221f:	6a 01                	push   $0x1
    2221:	e8 0a 18 00 00       	call   3a30 <printf>
    exit();
    2226:	e8 97 16 00 00       	call   38c2 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    222b:	50                   	push   %eax
    222c:	50                   	push   %eax
    222d:	68 24 50 00 00       	push   $0x5024
    2232:	6a 01                	push   $0x1
    2234:	e8 f7 17 00 00       	call   3a30 <printf>
    exit();
    2239:	e8 84 16 00 00       	call   38c2 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    223e:	50                   	push   %eax
    223f:	50                   	push   %eax
    2240:	68 87 46 00 00       	push   $0x4687
    2245:	6a 01                	push   $0x1
    2247:	e8 e4 17 00 00       	call   3a30 <printf>
    exit();
    224c:	e8 71 16 00 00       	call   38c2 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    2251:	50                   	push   %eax
    2252:	50                   	push   %eax
    2253:	68 6e 46 00 00       	push   $0x466e
    2258:	6a 01                	push   $0x1
    225a:	e8 d1 17 00 00       	call   3a30 <printf>
    exit();
    225f:	e8 5e 16 00 00       	call   38c2 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    2264:	50                   	push   %eax
    2265:	50                   	push   %eax
    2266:	68 58 46 00 00       	push   $0x4658
    226b:	6a 01                	push   $0x1
    226d:	e8 be 17 00 00       	call   3a30 <printf>
    exit();
    2272:	e8 4b 16 00 00       	call   38c2 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    2277:	50                   	push   %eax
    2278:	50                   	push   %eax
    2279:	68 3c 46 00 00       	push   $0x463c
    227e:	6a 01                	push   $0x1
    2280:	e8 ab 17 00 00       	call   3a30 <printf>
    exit();
    2285:	e8 38 16 00 00       	call   38c2 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    228a:	50                   	push   %eax
    228b:	50                   	push   %eax
    228c:	68 7d 45 00 00       	push   $0x457d
    2291:	6a 01                	push   $0x1
    2293:	e8 98 17 00 00       	call   3a30 <printf>
    exit();
    2298:	e8 25 16 00 00       	call   38c2 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    229d:	50                   	push   %eax
    229e:	50                   	push   %eax
    229f:	68 d8 4f 00 00       	push   $0x4fd8
    22a4:	6a 01                	push   $0x1
    22a6:	e8 85 17 00 00       	call   3a30 <printf>
    exit();
    22ab:	e8 12 16 00 00       	call   38c2 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    22b0:	53                   	push   %ebx
    22b1:	53                   	push   %ebx
    22b2:	68 db 44 00 00       	push   $0x44db
    22b7:	6a 01                	push   $0x1
    22b9:	e8 72 17 00 00       	call   3a30 <printf>
    exit();
    22be:	e8 ff 15 00 00       	call   38c2 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22c3:	50                   	push   %eax
    22c4:	50                   	push   %eax
    22c5:	68 8c 4f 00 00       	push   $0x4f8c
    22ca:	6a 01                	push   $0x1
    22cc:	e8 5f 17 00 00       	call   3a30 <printf>
    exit();
    22d1:	e8 ec 15 00 00       	call   38c2 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    22d6:	50                   	push   %eax
    22d7:	50                   	push   %eax
    22d8:	68 bf 44 00 00       	push   $0x44bf
    22dd:	6a 01                	push   $0x1
    22df:	e8 4c 17 00 00       	call   3a30 <printf>
    exit();
    22e4:	e8 d9 15 00 00       	call   38c2 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    22e9:	50                   	push   %eax
    22ea:	50                   	push   %eax
    22eb:	68 a7 44 00 00       	push   $0x44a7
    22f0:	6a 01                	push   $0x1
    22f2:	e8 39 17 00 00       	call   3a30 <printf>
    exit();
    22f7:	e8 c6 15 00 00       	call   38c2 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    22fc:	50                   	push   %eax
    22fd:	50                   	push   %eax
    22fe:	68 90 47 00 00       	push   $0x4790
    2303:	6a 01                	push   $0x1
    2305:	e8 26 17 00 00       	call   3a30 <printf>
    exit();
    230a:	e8 b3 15 00 00       	call   38c2 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    230f:	52                   	push   %edx
    2310:	52                   	push   %edx
    2311:	68 7b 47 00 00       	push   $0x477b
    2316:	6a 01                	push   $0x1
    2318:	e8 13 17 00 00       	call   3a30 <printf>
    exit();
    231d:	e8 a0 15 00 00       	call   38c2 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    2322:	51                   	push   %ecx
    2323:	51                   	push   %ecx
    2324:	68 90 50 00 00       	push   $0x5090
    2329:	6a 01                	push   $0x1
    232b:	e8 00 17 00 00       	call   3a30 <printf>
    exit();
    2330:	e8 8d 15 00 00       	call   38c2 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2335:	53                   	push   %ebx
    2336:	53                   	push   %ebx
    2337:	68 66 47 00 00       	push   $0x4766
    233c:	6a 01                	push   $0x1
    233e:	e8 ed 16 00 00       	call   3a30 <printf>
    exit();
    2343:	e8 7a 15 00 00       	call   38c2 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    2348:	50                   	push   %eax
    2349:	50                   	push   %eax
    234a:	68 4e 47 00 00       	push   $0x474e
    234f:	6a 01                	push   $0x1
    2351:	e8 da 16 00 00       	call   3a30 <printf>
    exit();
    2356:	e8 67 15 00 00       	call   38c2 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    235b:	50                   	push   %eax
    235c:	50                   	push   %eax
    235d:	68 36 47 00 00       	push   $0x4736
    2362:	6a 01                	push   $0x1
    2364:	e8 c7 16 00 00       	call   3a30 <printf>
    exit();
    2369:	e8 54 15 00 00       	call   38c2 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    236e:	50                   	push   %eax
    236f:	50                   	push   %eax
    2370:	68 1a 47 00 00       	push   $0x471a
    2375:	6a 01                	push   $0x1
    2377:	e8 b4 16 00 00       	call   3a30 <printf>
    exit();
    237c:	e8 41 15 00 00       	call   38c2 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2381:	50                   	push   %eax
    2382:	50                   	push   %eax
    2383:	68 fe 46 00 00       	push   $0x46fe
    2388:	6a 01                	push   $0x1
    238a:	e8 a1 16 00 00       	call   3a30 <printf>
    exit();
    238f:	e8 2e 15 00 00       	call   38c2 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2394:	50                   	push   %eax
    2395:	50                   	push   %eax
    2396:	68 e1 46 00 00       	push   $0x46e1
    239b:	6a 01                	push   $0x1
    239d:	e8 8e 16 00 00       	call   3a30 <printf>
    exit();
    23a2:	e8 1b 15 00 00       	call   38c2 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23a7:	50                   	push   %eax
    23a8:	50                   	push   %eax
    23a9:	68 c6 46 00 00       	push   $0x46c6
    23ae:	6a 01                	push   $0x1
    23b0:	e8 7b 16 00 00       	call   3a30 <printf>
    exit();
    23b5:	e8 08 15 00 00       	call   38c2 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    23ba:	50                   	push   %eax
    23bb:	50                   	push   %eax
    23bc:	68 f3 45 00 00       	push   $0x45f3
    23c1:	6a 01                	push   $0x1
    23c3:	e8 68 16 00 00       	call   3a30 <printf>
    exit();
    23c8:	e8 f5 14 00 00       	call   38c2 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    23cd:	50                   	push   %eax
    23ce:	50                   	push   %eax
    23cf:	68 db 45 00 00       	push   $0x45db
    23d4:	6a 01                	push   $0x1
    23d6:	e8 55 16 00 00       	call   3a30 <printf>
    exit();
    23db:	e8 e2 14 00 00       	call   38c2 <exit>

000023e0 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    23e0:	55                   	push   %ebp
    23e1:	89 e5                	mov    %esp,%ebp
    23e3:	56                   	push   %esi
    23e4:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    23e5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
void
bigwrite(void)
{
  int fd, sz;

  printf(1, "bigwrite test\n");
    23ea:	83 ec 08             	sub    $0x8,%esp
    23ed:	68 ad 47 00 00       	push   $0x47ad
    23f2:	6a 01                	push   $0x1
    23f4:	e8 37 16 00 00       	call   3a30 <printf>

  unlink("bigwrite");
    23f9:	c7 04 24 bc 47 00 00 	movl   $0x47bc,(%esp)
    2400:	e8 0d 15 00 00       	call   3912 <unlink>
    2405:	83 c4 10             	add    $0x10,%esp
    2408:	90                   	nop
    2409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2410:	83 ec 08             	sub    $0x8,%esp
    2413:	68 02 02 00 00       	push   $0x202
    2418:	68 bc 47 00 00       	push   $0x47bc
    241d:	e8 e0 14 00 00       	call   3902 <open>
    if(fd < 0){
    2422:	83 c4 10             	add    $0x10,%esp
    2425:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2427:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2429:	78 7e                	js     24a9 <bigwrite+0xc9>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    242b:	83 ec 04             	sub    $0x4,%esp
    242e:	53                   	push   %ebx
    242f:	68 c0 85 00 00       	push   $0x85c0
    2434:	50                   	push   %eax
    2435:	e8 a8 14 00 00       	call   38e2 <write>
      if(cc != sz){
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	39 d8                	cmp    %ebx,%eax
    243f:	75 55                	jne    2496 <bigwrite+0xb6>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    2441:	83 ec 04             	sub    $0x4,%esp
    2444:	53                   	push   %ebx
    2445:	68 c0 85 00 00       	push   $0x85c0
    244a:	56                   	push   %esi
    244b:	e8 92 14 00 00       	call   38e2 <write>
      if(cc != sz){
    2450:	83 c4 10             	add    $0x10,%esp
    2453:	39 d8                	cmp    %ebx,%eax
    2455:	75 3f                	jne    2496 <bigwrite+0xb6>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2457:	83 ec 0c             	sub    $0xc,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    245a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2460:	56                   	push   %esi
    2461:	e8 84 14 00 00       	call   38ea <close>
    unlink("bigwrite");
    2466:	c7 04 24 bc 47 00 00 	movl   $0x47bc,(%esp)
    246d:	e8 a0 14 00 00       	call   3912 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2472:	83 c4 10             	add    $0x10,%esp
    2475:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    247b:	75 93                	jne    2410 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    247d:	83 ec 08             	sub    $0x8,%esp
    2480:	68 ef 47 00 00       	push   $0x47ef
    2485:	6a 01                	push   $0x1
    2487:	e8 a4 15 00 00       	call   3a30 <printf>
}
    248c:	83 c4 10             	add    $0x10,%esp
    248f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2492:	5b                   	pop    %ebx
    2493:	5e                   	pop    %esi
    2494:	5d                   	pop    %ebp
    2495:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    2496:	50                   	push   %eax
    2497:	53                   	push   %ebx
    2498:	68 dd 47 00 00       	push   $0x47dd
    249d:	6a 01                	push   $0x1
    249f:	e8 8c 15 00 00       	call   3a30 <printf>
        exit();
    24a4:	e8 19 14 00 00       	call   38c2 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    24a9:	83 ec 08             	sub    $0x8,%esp
    24ac:	68 c5 47 00 00       	push   $0x47c5
    24b1:	6a 01                	push   $0x1
    24b3:	e8 78 15 00 00       	call   3a30 <printf>
      exit();
    24b8:	e8 05 14 00 00       	call   38c2 <exit>
    24bd:	8d 76 00             	lea    0x0(%esi),%esi

000024c0 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    24c0:	55                   	push   %ebp
    24c1:	89 e5                	mov    %esp,%ebp
    24c3:	57                   	push   %edi
    24c4:	56                   	push   %esi
    24c5:	53                   	push   %ebx
    24c6:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    24c9:	68 fc 47 00 00       	push   $0x47fc
    24ce:	6a 01                	push   $0x1
    24d0:	e8 5b 15 00 00       	call   3a30 <printf>

  unlink("bigfile");
    24d5:	c7 04 24 18 48 00 00 	movl   $0x4818,(%esp)
    24dc:	e8 31 14 00 00       	call   3912 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    24e1:	5e                   	pop    %esi
    24e2:	5f                   	pop    %edi
    24e3:	68 02 02 00 00       	push   $0x202
    24e8:	68 18 48 00 00       	push   $0x4818
    24ed:	e8 10 14 00 00       	call   3902 <open>
  if(fd < 0){
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	85 c0                	test   %eax,%eax
    24f7:	0f 88 5f 01 00 00    	js     265c <bigfile+0x19c>
    24fd:	89 c6                	mov    %eax,%esi
    24ff:	31 db                	xor    %ebx,%ebx
    2501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2508:	83 ec 04             	sub    $0x4,%esp
    250b:	68 58 02 00 00       	push   $0x258
    2510:	53                   	push   %ebx
    2511:	68 c0 85 00 00       	push   $0x85c0
    2516:	e8 15 12 00 00       	call   3730 <memset>
    if(write(fd, buf, 600) != 600){
    251b:	83 c4 0c             	add    $0xc,%esp
    251e:	68 58 02 00 00       	push   $0x258
    2523:	68 c0 85 00 00       	push   $0x85c0
    2528:	56                   	push   %esi
    2529:	e8 b4 13 00 00       	call   38e2 <write>
    252e:	83 c4 10             	add    $0x10,%esp
    2531:	3d 58 02 00 00       	cmp    $0x258,%eax
    2536:	0f 85 f8 00 00 00    	jne    2634 <bigfile+0x174>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    253c:	83 c3 01             	add    $0x1,%ebx
    253f:	83 fb 14             	cmp    $0x14,%ebx
    2542:	75 c4                	jne    2508 <bigfile+0x48>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2544:	83 ec 0c             	sub    $0xc,%esp
    2547:	56                   	push   %esi
    2548:	e8 9d 13 00 00       	call   38ea <close>

  fd = open("bigfile", 0);
    254d:	59                   	pop    %ecx
    254e:	5b                   	pop    %ebx
    254f:	6a 00                	push   $0x0
    2551:	68 18 48 00 00       	push   $0x4818
    2556:	e8 a7 13 00 00       	call   3902 <open>
  if(fd < 0){
    255b:	83 c4 10             	add    $0x10,%esp
    255e:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2560:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2562:	0f 88 e0 00 00 00    	js     2648 <bigfile+0x188>
    2568:	31 db                	xor    %ebx,%ebx
    256a:	31 ff                	xor    %edi,%edi
    256c:	eb 30                	jmp    259e <bigfile+0xde>
    256e:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2570:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2575:	0f 85 91 00 00 00    	jne    260c <bigfile+0x14c>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    257b:	0f be 05 c0 85 00 00 	movsbl 0x85c0,%eax
    2582:	89 fa                	mov    %edi,%edx
    2584:	d1 fa                	sar    %edx
    2586:	39 d0                	cmp    %edx,%eax
    2588:	75 6e                	jne    25f8 <bigfile+0x138>
    258a:	0f be 15 eb 86 00 00 	movsbl 0x86eb,%edx
    2591:	39 d0                	cmp    %edx,%eax
    2593:	75 63                	jne    25f8 <bigfile+0x138>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    2595:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    259b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    259e:	83 ec 04             	sub    $0x4,%esp
    25a1:	68 2c 01 00 00       	push   $0x12c
    25a6:	68 c0 85 00 00       	push   $0x85c0
    25ab:	56                   	push   %esi
    25ac:	e8 29 13 00 00       	call   38da <read>
    if(cc < 0){
    25b1:	83 c4 10             	add    $0x10,%esp
    25b4:	85 c0                	test   %eax,%eax
    25b6:	78 68                	js     2620 <bigfile+0x160>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    25b8:	75 b6                	jne    2570 <bigfile+0xb0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    25ba:	83 ec 0c             	sub    $0xc,%esp
    25bd:	56                   	push   %esi
    25be:	e8 27 13 00 00       	call   38ea <close>
  if(total != 20*600){
    25c3:	83 c4 10             	add    $0x10,%esp
    25c6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25cc:	0f 85 9e 00 00 00    	jne    2670 <bigfile+0x1b0>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    25d2:	83 ec 0c             	sub    $0xc,%esp
    25d5:	68 18 48 00 00       	push   $0x4818
    25da:	e8 33 13 00 00       	call   3912 <unlink>

  printf(1, "bigfile test ok\n");
    25df:	58                   	pop    %eax
    25e0:	5a                   	pop    %edx
    25e1:	68 a7 48 00 00       	push   $0x48a7
    25e6:	6a 01                	push   $0x1
    25e8:	e8 43 14 00 00       	call   3a30 <printf>
}
    25ed:	83 c4 10             	add    $0x10,%esp
    25f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    25f3:	5b                   	pop    %ebx
    25f4:	5e                   	pop    %esi
    25f5:	5f                   	pop    %edi
    25f6:	5d                   	pop    %ebp
    25f7:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    25f8:	83 ec 08             	sub    $0x8,%esp
    25fb:	68 74 48 00 00       	push   $0x4874
    2600:	6a 01                	push   $0x1
    2602:	e8 29 14 00 00       	call   3a30 <printf>
      exit();
    2607:	e8 b6 12 00 00       	call   38c2 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    260c:	83 ec 08             	sub    $0x8,%esp
    260f:	68 60 48 00 00       	push   $0x4860
    2614:	6a 01                	push   $0x1
    2616:	e8 15 14 00 00       	call   3a30 <printf>
      exit();
    261b:	e8 a2 12 00 00       	call   38c2 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2620:	83 ec 08             	sub    $0x8,%esp
    2623:	68 4b 48 00 00       	push   $0x484b
    2628:	6a 01                	push   $0x1
    262a:	e8 01 14 00 00       	call   3a30 <printf>
      exit();
    262f:	e8 8e 12 00 00       	call   38c2 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2634:	83 ec 08             	sub    $0x8,%esp
    2637:	68 20 48 00 00       	push   $0x4820
    263c:	6a 01                	push   $0x1
    263e:	e8 ed 13 00 00       	call   3a30 <printf>
      exit();
    2643:	e8 7a 12 00 00       	call   38c2 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2648:	83 ec 08             	sub    $0x8,%esp
    264b:	68 36 48 00 00       	push   $0x4836
    2650:	6a 01                	push   $0x1
    2652:	e8 d9 13 00 00       	call   3a30 <printf>
    exit();
    2657:	e8 66 12 00 00       	call   38c2 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    265c:	83 ec 08             	sub    $0x8,%esp
    265f:	68 0a 48 00 00       	push   $0x480a
    2664:	6a 01                	push   $0x1
    2666:	e8 c5 13 00 00       	call   3a30 <printf>
    exit();
    266b:	e8 52 12 00 00       	call   38c2 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2670:	83 ec 08             	sub    $0x8,%esp
    2673:	68 8d 48 00 00       	push   $0x488d
    2678:	6a 01                	push   $0x1
    267a:	e8 b1 13 00 00       	call   3a30 <printf>
    exit();
    267f:	e8 3e 12 00 00       	call   38c2 <exit>
    2684:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    268a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002690 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2696:	68 b8 48 00 00       	push   $0x48b8
    269b:	6a 01                	push   $0x1
    269d:	e8 8e 13 00 00       	call   3a30 <printf>

  if(mkdir("12345678901234") != 0){
    26a2:	c7 04 24 f3 48 00 00 	movl   $0x48f3,(%esp)
    26a9:	e8 7c 12 00 00       	call   392a <mkdir>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	0f 85 97 00 00 00    	jne    2750 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    26b9:	83 ec 0c             	sub    $0xc,%esp
    26bc:	68 b0 50 00 00       	push   $0x50b0
    26c1:	e8 64 12 00 00       	call   392a <mkdir>
    26c6:	83 c4 10             	add    $0x10,%esp
    26c9:	85 c0                	test   %eax,%eax
    26cb:	0f 85 de 00 00 00    	jne    27af <fourteen+0x11f>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26d1:	83 ec 08             	sub    $0x8,%esp
    26d4:	68 00 02 00 00       	push   $0x200
    26d9:	68 00 51 00 00       	push   $0x5100
    26de:	e8 1f 12 00 00       	call   3902 <open>
  if(fd < 0){
    26e3:	83 c4 10             	add    $0x10,%esp
    26e6:	85 c0                	test   %eax,%eax
    26e8:	0f 88 ae 00 00 00    	js     279c <fourteen+0x10c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    26ee:	83 ec 0c             	sub    $0xc,%esp
    26f1:	50                   	push   %eax
    26f2:	e8 f3 11 00 00       	call   38ea <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    26f7:	58                   	pop    %eax
    26f8:	5a                   	pop    %edx
    26f9:	6a 00                	push   $0x0
    26fb:	68 70 51 00 00       	push   $0x5170
    2700:	e8 fd 11 00 00       	call   3902 <open>
  if(fd < 0){
    2705:	83 c4 10             	add    $0x10,%esp
    2708:	85 c0                	test   %eax,%eax
    270a:	78 7d                	js     2789 <fourteen+0xf9>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    270c:	83 ec 0c             	sub    $0xc,%esp
    270f:	50                   	push   %eax
    2710:	e8 d5 11 00 00       	call   38ea <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2715:	c7 04 24 e4 48 00 00 	movl   $0x48e4,(%esp)
    271c:	e8 09 12 00 00       	call   392a <mkdir>
    2721:	83 c4 10             	add    $0x10,%esp
    2724:	85 c0                	test   %eax,%eax
    2726:	74 4e                	je     2776 <fourteen+0xe6>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2728:	83 ec 0c             	sub    $0xc,%esp
    272b:	68 0c 52 00 00       	push   $0x520c
    2730:	e8 f5 11 00 00       	call   392a <mkdir>
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	74 27                	je     2763 <fourteen+0xd3>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    273c:	83 ec 08             	sub    $0x8,%esp
    273f:	68 02 49 00 00       	push   $0x4902
    2744:	6a 01                	push   $0x1
    2746:	e8 e5 12 00 00       	call   3a30 <printf>
}
    274b:	83 c4 10             	add    $0x10,%esp
    274e:	c9                   	leave  
    274f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2750:	50                   	push   %eax
    2751:	50                   	push   %eax
    2752:	68 c7 48 00 00       	push   $0x48c7
    2757:	6a 01                	push   $0x1
    2759:	e8 d2 12 00 00       	call   3a30 <printf>
    exit();
    275e:	e8 5f 11 00 00       	call   38c2 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2763:	50                   	push   %eax
    2764:	50                   	push   %eax
    2765:	68 2c 52 00 00       	push   $0x522c
    276a:	6a 01                	push   $0x1
    276c:	e8 bf 12 00 00       	call   3a30 <printf>
    exit();
    2771:	e8 4c 11 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2776:	52                   	push   %edx
    2777:	52                   	push   %edx
    2778:	68 dc 51 00 00       	push   $0x51dc
    277d:	6a 01                	push   $0x1
    277f:	e8 ac 12 00 00       	call   3a30 <printf>
    exit();
    2784:	e8 39 11 00 00       	call   38c2 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2789:	51                   	push   %ecx
    278a:	51                   	push   %ecx
    278b:	68 a0 51 00 00       	push   $0x51a0
    2790:	6a 01                	push   $0x1
    2792:	e8 99 12 00 00       	call   3a30 <printf>
    exit();
    2797:	e8 26 11 00 00       	call   38c2 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    279c:	51                   	push   %ecx
    279d:	51                   	push   %ecx
    279e:	68 30 51 00 00       	push   $0x5130
    27a3:	6a 01                	push   $0x1
    27a5:	e8 86 12 00 00       	call   3a30 <printf>
    exit();
    27aa:	e8 13 11 00 00       	call   38c2 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27af:	50                   	push   %eax
    27b0:	50                   	push   %eax
    27b1:	68 d0 50 00 00       	push   $0x50d0
    27b6:	6a 01                	push   $0x1
    27b8:	e8 73 12 00 00       	call   3a30 <printf>
    exit();
    27bd:	e8 00 11 00 00       	call   38c2 <exit>
    27c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027d0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    27d0:	55                   	push   %ebp
    27d1:	89 e5                	mov    %esp,%ebp
    27d3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27d6:	68 0f 49 00 00       	push   $0x490f
    27db:	6a 01                	push   $0x1
    27dd:	e8 4e 12 00 00       	call   3a30 <printf>
  if(mkdir("dots") != 0){
    27e2:	c7 04 24 1b 49 00 00 	movl   $0x491b,(%esp)
    27e9:	e8 3c 11 00 00       	call   392a <mkdir>
    27ee:	83 c4 10             	add    $0x10,%esp
    27f1:	85 c0                	test   %eax,%eax
    27f3:	0f 85 b0 00 00 00    	jne    28a9 <rmdot+0xd9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    27f9:	83 ec 0c             	sub    $0xc,%esp
    27fc:	68 1b 49 00 00       	push   $0x491b
    2801:	e8 2c 11 00 00       	call   3932 <chdir>
    2806:	83 c4 10             	add    $0x10,%esp
    2809:	85 c0                	test   %eax,%eax
    280b:	0f 85 1d 01 00 00    	jne    292e <rmdot+0x15e>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2811:	83 ec 0c             	sub    $0xc,%esp
    2814:	68 c6 45 00 00       	push   $0x45c6
    2819:	e8 f4 10 00 00       	call   3912 <unlink>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 84 f2 00 00 00    	je     291b <rmdot+0x14b>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 c5 45 00 00       	push   $0x45c5
    2831:	e8 dc 10 00 00       	call   3912 <unlink>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 84 c7 00 00 00    	je     2908 <rmdot+0x138>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 99 3d 00 00       	push   $0x3d99
    2849:	e8 e4 10 00 00       	call   3932 <chdir>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 85 9c 00 00 00    	jne    28f5 <rmdot+0x125>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 63 49 00 00       	push   $0x4963
    2861:	e8 ac 10 00 00       	call   3912 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	74 75                	je     28e2 <rmdot+0x112>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    286d:	83 ec 0c             	sub    $0xc,%esp
    2870:	68 81 49 00 00       	push   $0x4981
    2875:	e8 98 10 00 00       	call   3912 <unlink>
    287a:	83 c4 10             	add    $0x10,%esp
    287d:	85 c0                	test   %eax,%eax
    287f:	74 4e                	je     28cf <rmdot+0xff>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 1b 49 00 00       	push   $0x491b
    2889:	e8 84 10 00 00       	call   3912 <unlink>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	75 27                	jne    28bc <rmdot+0xec>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 b6 49 00 00       	push   $0x49b6
    289d:	6a 01                	push   $0x1
    289f:	e8 8c 11 00 00       	call   3a30 <printf>
}
    28a4:	83 c4 10             	add    $0x10,%esp
    28a7:	c9                   	leave  
    28a8:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    28a9:	50                   	push   %eax
    28aa:	50                   	push   %eax
    28ab:	68 20 49 00 00       	push   $0x4920
    28b0:	6a 01                	push   $0x1
    28b2:	e8 79 11 00 00       	call   3a30 <printf>
    exit();
    28b7:	e8 06 10 00 00       	call   38c2 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    28bc:	50                   	push   %eax
    28bd:	50                   	push   %eax
    28be:	68 a1 49 00 00       	push   $0x49a1
    28c3:	6a 01                	push   $0x1
    28c5:	e8 66 11 00 00       	call   3a30 <printf>
    exit();
    28ca:	e8 f3 0f 00 00       	call   38c2 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    28cf:	52                   	push   %edx
    28d0:	52                   	push   %edx
    28d1:	68 89 49 00 00       	push   $0x4989
    28d6:	6a 01                	push   $0x1
    28d8:	e8 53 11 00 00       	call   3a30 <printf>
    exit();
    28dd:	e8 e0 0f 00 00       	call   38c2 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    28e2:	51                   	push   %ecx
    28e3:	51                   	push   %ecx
    28e4:	68 6a 49 00 00       	push   $0x496a
    28e9:	6a 01                	push   $0x1
    28eb:	e8 40 11 00 00       	call   3a30 <printf>
    exit();
    28f0:	e8 cd 0f 00 00       	call   38c2 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    28f5:	50                   	push   %eax
    28f6:	50                   	push   %eax
    28f7:	68 9b 3d 00 00       	push   $0x3d9b
    28fc:	6a 01                	push   $0x1
    28fe:	e8 2d 11 00 00       	call   3a30 <printf>
    exit();
    2903:	e8 ba 0f 00 00       	call   38c2 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2908:	50                   	push   %eax
    2909:	50                   	push   %eax
    290a:	68 54 49 00 00       	push   $0x4954
    290f:	6a 01                	push   $0x1
    2911:	e8 1a 11 00 00       	call   3a30 <printf>
    exit();
    2916:	e8 a7 0f 00 00       	call   38c2 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    291b:	50                   	push   %eax
    291c:	50                   	push   %eax
    291d:	68 46 49 00 00       	push   $0x4946
    2922:	6a 01                	push   $0x1
    2924:	e8 07 11 00 00       	call   3a30 <printf>
    exit();
    2929:	e8 94 0f 00 00       	call   38c2 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    292e:	50                   	push   %eax
    292f:	50                   	push   %eax
    2930:	68 33 49 00 00       	push   $0x4933
    2935:	6a 01                	push   $0x1
    2937:	e8 f4 10 00 00       	call   3a30 <printf>
    exit();
    293c:	e8 81 0f 00 00       	call   38c2 <exit>
    2941:	eb 0d                	jmp    2950 <dirfile>
    2943:	90                   	nop
    2944:	90                   	nop
    2945:	90                   	nop
    2946:	90                   	nop
    2947:	90                   	nop
    2948:	90                   	nop
    2949:	90                   	nop
    294a:	90                   	nop
    294b:	90                   	nop
    294c:	90                   	nop
    294d:	90                   	nop
    294e:	90                   	nop
    294f:	90                   	nop

00002950 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	53                   	push   %ebx
    2954:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    2957:	68 c0 49 00 00       	push   $0x49c0
    295c:	6a 01                	push   $0x1
    295e:	e8 cd 10 00 00       	call   3a30 <printf>

  fd = open("dirfile", O_CREATE);
    2963:	59                   	pop    %ecx
    2964:	5b                   	pop    %ebx
    2965:	68 00 02 00 00       	push   $0x200
    296a:	68 cd 49 00 00       	push   $0x49cd
    296f:	e8 8e 0f 00 00       	call   3902 <open>
  if(fd < 0){
    2974:	83 c4 10             	add    $0x10,%esp
    2977:	85 c0                	test   %eax,%eax
    2979:	0f 88 43 01 00 00    	js     2ac2 <dirfile+0x172>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    297f:	83 ec 0c             	sub    $0xc,%esp
    2982:	50                   	push   %eax
    2983:	e8 62 0f 00 00       	call   38ea <close>
  if(chdir("dirfile") == 0){
    2988:	c7 04 24 cd 49 00 00 	movl   $0x49cd,(%esp)
    298f:	e8 9e 0f 00 00       	call   3932 <chdir>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 84 10 01 00 00    	je     2aaf <dirfile+0x15f>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    299f:	83 ec 08             	sub    $0x8,%esp
    29a2:	6a 00                	push   $0x0
    29a4:	68 06 4a 00 00       	push   $0x4a06
    29a9:	e8 54 0f 00 00       	call   3902 <open>
  if(fd >= 0){
    29ae:	83 c4 10             	add    $0x10,%esp
    29b1:	85 c0                	test   %eax,%eax
    29b3:	0f 89 e3 00 00 00    	jns    2a9c <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    29b9:	83 ec 08             	sub    $0x8,%esp
    29bc:	68 00 02 00 00       	push   $0x200
    29c1:	68 06 4a 00 00       	push   $0x4a06
    29c6:	e8 37 0f 00 00       	call   3902 <open>
  if(fd >= 0){
    29cb:	83 c4 10             	add    $0x10,%esp
    29ce:	85 c0                	test   %eax,%eax
    29d0:	0f 89 c6 00 00 00    	jns    2a9c <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	68 06 4a 00 00       	push   $0x4a06
    29de:	e8 47 0f 00 00       	call   392a <mkdir>
    29e3:	83 c4 10             	add    $0x10,%esp
    29e6:	85 c0                	test   %eax,%eax
    29e8:	0f 84 46 01 00 00    	je     2b34 <dirfile+0x1e4>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    29ee:	83 ec 0c             	sub    $0xc,%esp
    29f1:	68 06 4a 00 00       	push   $0x4a06
    29f6:	e8 17 0f 00 00       	call   3912 <unlink>
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 84 1b 01 00 00    	je     2b21 <dirfile+0x1d1>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2a06:	83 ec 08             	sub    $0x8,%esp
    2a09:	68 06 4a 00 00       	push   $0x4a06
    2a0e:	68 6a 4a 00 00       	push   $0x4a6a
    2a13:	e8 0a 0f 00 00       	call   3922 <link>
    2a18:	83 c4 10             	add    $0x10,%esp
    2a1b:	85 c0                	test   %eax,%eax
    2a1d:	0f 84 eb 00 00 00    	je     2b0e <dirfile+0x1be>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	68 cd 49 00 00       	push   $0x49cd
    2a2b:	e8 e2 0e 00 00       	call   3912 <unlink>
    2a30:	83 c4 10             	add    $0x10,%esp
    2a33:	85 c0                	test   %eax,%eax
    2a35:	0f 85 c0 00 00 00    	jne    2afb <dirfile+0x1ab>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	6a 02                	push   $0x2
    2a40:	68 c6 45 00 00       	push   $0x45c6
    2a45:	e8 b8 0e 00 00       	call   3902 <open>
  if(fd >= 0){
    2a4a:	83 c4 10             	add    $0x10,%esp
    2a4d:	85 c0                	test   %eax,%eax
    2a4f:	0f 89 93 00 00 00    	jns    2ae8 <dirfile+0x198>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2a55:	83 ec 08             	sub    $0x8,%esp
    2a58:	6a 00                	push   $0x0
    2a5a:	68 c6 45 00 00       	push   $0x45c6
    2a5f:	e8 9e 0e 00 00       	call   3902 <open>
  if(write(fd, "x", 1) > 0){
    2a64:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2a67:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a69:	6a 01                	push   $0x1
    2a6b:	68 a9 46 00 00       	push   $0x46a9
    2a70:	50                   	push   %eax
    2a71:	e8 6c 0e 00 00       	call   38e2 <write>
    2a76:	83 c4 10             	add    $0x10,%esp
    2a79:	85 c0                	test   %eax,%eax
    2a7b:	7f 58                	jg     2ad5 <dirfile+0x185>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2a7d:	83 ec 0c             	sub    $0xc,%esp
    2a80:	53                   	push   %ebx
    2a81:	e8 64 0e 00 00       	call   38ea <close>

  printf(1, "dir vs file OK\n");
    2a86:	58                   	pop    %eax
    2a87:	5a                   	pop    %edx
    2a88:	68 9d 4a 00 00       	push   $0x4a9d
    2a8d:	6a 01                	push   $0x1
    2a8f:	e8 9c 0f 00 00       	call   3a30 <printf>
}
    2a94:	83 c4 10             	add    $0x10,%esp
    2a97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a9a:	c9                   	leave  
    2a9b:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2a9c:	50                   	push   %eax
    2a9d:	50                   	push   %eax
    2a9e:	68 11 4a 00 00       	push   $0x4a11
    2aa3:	6a 01                	push   $0x1
    2aa5:	e8 86 0f 00 00       	call   3a30 <printf>
    exit();
    2aaa:	e8 13 0e 00 00       	call   38c2 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    2aaf:	50                   	push   %eax
    2ab0:	50                   	push   %eax
    2ab1:	68 ec 49 00 00       	push   $0x49ec
    2ab6:	6a 01                	push   $0x1
    2ab8:	e8 73 0f 00 00       	call   3a30 <printf>
    exit();
    2abd:	e8 00 0e 00 00       	call   38c2 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2ac2:	52                   	push   %edx
    2ac3:	52                   	push   %edx
    2ac4:	68 d5 49 00 00       	push   $0x49d5
    2ac9:	6a 01                	push   $0x1
    2acb:	e8 60 0f 00 00       	call   3a30 <printf>
    exit();
    2ad0:	e8 ed 0d 00 00       	call   38c2 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2ad5:	51                   	push   %ecx
    2ad6:	51                   	push   %ecx
    2ad7:	68 89 4a 00 00       	push   $0x4a89
    2adc:	6a 01                	push   $0x1
    2ade:	e8 4d 0f 00 00       	call   3a30 <printf>
    exit();
    2ae3:	e8 da 0d 00 00       	call   38c2 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2ae8:	53                   	push   %ebx
    2ae9:	53                   	push   %ebx
    2aea:	68 80 52 00 00       	push   $0x5280
    2aef:	6a 01                	push   $0x1
    2af1:	e8 3a 0f 00 00       	call   3a30 <printf>
    exit();
    2af6:	e8 c7 0d 00 00       	call   38c2 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2afb:	50                   	push   %eax
    2afc:	50                   	push   %eax
    2afd:	68 71 4a 00 00       	push   $0x4a71
    2b02:	6a 01                	push   $0x1
    2b04:	e8 27 0f 00 00       	call   3a30 <printf>
    exit();
    2b09:	e8 b4 0d 00 00       	call   38c2 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2b0e:	50                   	push   %eax
    2b0f:	50                   	push   %eax
    2b10:	68 60 52 00 00       	push   $0x5260
    2b15:	6a 01                	push   $0x1
    2b17:	e8 14 0f 00 00       	call   3a30 <printf>
    exit();
    2b1c:	e8 a1 0d 00 00       	call   38c2 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b21:	50                   	push   %eax
    2b22:	50                   	push   %eax
    2b23:	68 4c 4a 00 00       	push   $0x4a4c
    2b28:	6a 01                	push   $0x1
    2b2a:	e8 01 0f 00 00       	call   3a30 <printf>
    exit();
    2b2f:	e8 8e 0d 00 00       	call   38c2 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b34:	50                   	push   %eax
    2b35:	50                   	push   %eax
    2b36:	68 2f 4a 00 00       	push   $0x4a2f
    2b3b:	6a 01                	push   $0x1
    2b3d:	e8 ee 0e 00 00       	call   3a30 <printf>
    exit();
    2b42:	e8 7b 0d 00 00       	call   38c2 <exit>
    2b47:	89 f6                	mov    %esi,%esi
    2b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b50 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2b50:	55                   	push   %ebp
    2b51:	89 e5                	mov    %esp,%ebp
    2b53:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2b54:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2b59:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2b5c:	68 ad 4a 00 00       	push   $0x4aad
    2b61:	6a 01                	push   $0x1
    2b63:	e8 c8 0e 00 00       	call   3a30 <printf>
    2b68:	83 c4 10             	add    $0x10,%esp
    2b6b:	90                   	nop
    2b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2b70:	83 ec 0c             	sub    $0xc,%esp
    2b73:	68 be 4a 00 00       	push   $0x4abe
    2b78:	e8 ad 0d 00 00       	call   392a <mkdir>
    2b7d:	83 c4 10             	add    $0x10,%esp
    2b80:	85 c0                	test   %eax,%eax
    2b82:	0f 85 bb 00 00 00    	jne    2c43 <iref+0xf3>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2b88:	83 ec 0c             	sub    $0xc,%esp
    2b8b:	68 be 4a 00 00       	push   $0x4abe
    2b90:	e8 9d 0d 00 00       	call   3932 <chdir>
    2b95:	83 c4 10             	add    $0x10,%esp
    2b98:	85 c0                	test   %eax,%eax
    2b9a:	0f 85 b7 00 00 00    	jne    2c57 <iref+0x107>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 73 41 00 00       	push   $0x4173
    2ba8:	e8 7d 0d 00 00       	call   392a <mkdir>
    link("README", "");
    2bad:	59                   	pop    %ecx
    2bae:	58                   	pop    %eax
    2baf:	68 73 41 00 00       	push   $0x4173
    2bb4:	68 6a 4a 00 00       	push   $0x4a6a
    2bb9:	e8 64 0d 00 00       	call   3922 <link>
    fd = open("", O_CREATE);
    2bbe:	58                   	pop    %eax
    2bbf:	5a                   	pop    %edx
    2bc0:	68 00 02 00 00       	push   $0x200
    2bc5:	68 73 41 00 00       	push   $0x4173
    2bca:	e8 33 0d 00 00       	call   3902 <open>
    if(fd >= 0)
    2bcf:	83 c4 10             	add    $0x10,%esp
    2bd2:	85 c0                	test   %eax,%eax
    2bd4:	78 0c                	js     2be2 <iref+0x92>
      close(fd);
    2bd6:	83 ec 0c             	sub    $0xc,%esp
    2bd9:	50                   	push   %eax
    2bda:	e8 0b 0d 00 00       	call   38ea <close>
    2bdf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2be2:	83 ec 08             	sub    $0x8,%esp
    2be5:	68 00 02 00 00       	push   $0x200
    2bea:	68 a8 46 00 00       	push   $0x46a8
    2bef:	e8 0e 0d 00 00       	call   3902 <open>
    if(fd >= 0)
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	85 c0                	test   %eax,%eax
    2bf9:	78 0c                	js     2c07 <iref+0xb7>
      close(fd);
    2bfb:	83 ec 0c             	sub    $0xc,%esp
    2bfe:	50                   	push   %eax
    2bff:	e8 e6 0c 00 00       	call   38ea <close>
    2c04:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c07:	83 ec 0c             	sub    $0xc,%esp
    2c0a:	68 a8 46 00 00       	push   $0x46a8
    2c0f:	e8 fe 0c 00 00       	call   3912 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	83 eb 01             	sub    $0x1,%ebx
    2c1a:	0f 85 50 ff ff ff    	jne    2b70 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2c20:	83 ec 0c             	sub    $0xc,%esp
    2c23:	68 99 3d 00 00       	push   $0x3d99
    2c28:	e8 05 0d 00 00       	call   3932 <chdir>
  printf(1, "empty file name OK\n");
    2c2d:	58                   	pop    %eax
    2c2e:	5a                   	pop    %edx
    2c2f:	68 ec 4a 00 00       	push   $0x4aec
    2c34:	6a 01                	push   $0x1
    2c36:	e8 f5 0d 00 00       	call   3a30 <printf>
}
    2c3b:	83 c4 10             	add    $0x10,%esp
    2c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c41:	c9                   	leave  
    2c42:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2c43:	83 ec 08             	sub    $0x8,%esp
    2c46:	68 c4 4a 00 00       	push   $0x4ac4
    2c4b:	6a 01                	push   $0x1
    2c4d:	e8 de 0d 00 00       	call   3a30 <printf>
      exit();
    2c52:	e8 6b 0c 00 00       	call   38c2 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2c57:	83 ec 08             	sub    $0x8,%esp
    2c5a:	68 d8 4a 00 00       	push   $0x4ad8
    2c5f:	6a 01                	push   $0x1
    2c61:	e8 ca 0d 00 00       	call   3a30 <printf>
      exit();
    2c66:	e8 57 0c 00 00       	call   38c2 <exit>
    2c6b:	90                   	nop
    2c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c70 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2c70:	55                   	push   %ebp
    2c71:	89 e5                	mov    %esp,%ebp
    2c73:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2c74:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2c76:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2c79:	68 00 4b 00 00       	push   $0x4b00
    2c7e:	6a 01                	push   $0x1
    2c80:	e8 ab 0d 00 00       	call   3a30 <printf>
    2c85:	83 c4 10             	add    $0x10,%esp
    2c88:	eb 13                	jmp    2c9d <forktest+0x2d>
    2c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2c90:	74 62                	je     2cf4 <forktest+0x84>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2c92:	83 c3 01             	add    $0x1,%ebx
    2c95:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2c9b:	74 43                	je     2ce0 <forktest+0x70>
    pid = fork();
    2c9d:	e8 18 0c 00 00       	call   38ba <fork>
    if(pid < 0)
    2ca2:	85 c0                	test   %eax,%eax
    2ca4:	79 ea                	jns    2c90 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2ca6:	85 db                	test   %ebx,%ebx
    2ca8:	74 14                	je     2cbe <forktest+0x4e>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2cb0:	e8 15 0c 00 00       	call   38ca <wait>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	78 40                	js     2cf9 <forktest+0x89>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2cb9:	83 eb 01             	sub    $0x1,%ebx
    2cbc:	75 f2                	jne    2cb0 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2cbe:	e8 07 0c 00 00       	call   38ca <wait>
    2cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cc6:	75 45                	jne    2d0d <forktest+0x9d>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2cc8:	83 ec 08             	sub    $0x8,%esp
    2ccb:	68 32 4b 00 00       	push   $0x4b32
    2cd0:	6a 01                	push   $0x1
    2cd2:	e8 59 0d 00 00       	call   3a30 <printf>
}
    2cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cda:	c9                   	leave  
    2cdb:	c3                   	ret    
    2cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2ce0:	83 ec 08             	sub    $0x8,%esp
    2ce3:	68 a0 52 00 00       	push   $0x52a0
    2ce8:	6a 01                	push   $0x1
    2cea:	e8 41 0d 00 00       	call   3a30 <printf>
    exit();
    2cef:	e8 ce 0b 00 00       	call   38c2 <exit>
  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    2cf4:	e8 c9 0b 00 00       	call   38c2 <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    2cf9:	83 ec 08             	sub    $0x8,%esp
    2cfc:	68 0b 4b 00 00       	push   $0x4b0b
    2d01:	6a 01                	push   $0x1
    2d03:	e8 28 0d 00 00       	call   3a30 <printf>
      exit();
    2d08:	e8 b5 0b 00 00       	call   38c2 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    2d0d:	83 ec 08             	sub    $0x8,%esp
    2d10:	68 1f 4b 00 00       	push   $0x4b1f
    2d15:	6a 01                	push   $0x1
    2d17:	e8 14 0d 00 00       	call   3a30 <printf>
    exit();
    2d1c:	e8 a1 0b 00 00       	call   38c2 <exit>
    2d21:	eb 0d                	jmp    2d30 <sbrktest>
    2d23:	90                   	nop
    2d24:	90                   	nop
    2d25:	90                   	nop
    2d26:	90                   	nop
    2d27:	90                   	nop
    2d28:	90                   	nop
    2d29:	90                   	nop
    2d2a:	90                   	nop
    2d2b:	90                   	nop
    2d2c:	90                   	nop
    2d2d:	90                   	nop
    2d2e:	90                   	nop
    2d2f:	90                   	nop

00002d30 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2d36:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2d38:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2d3b:	68 40 4b 00 00       	push   $0x4b40
    2d40:	ff 35 e8 5d 00 00    	pushl  0x5de8
    2d46:	e8 e5 0c 00 00       	call   3a30 <printf>
  oldbrk = sbrk(0);
    2d4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d52:	e8 0b 0c 00 00       	call   3962 <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    2d57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    2d5e:	89 c7                	mov    %eax,%edi

  // can one sbrk() less than a page?
  a = sbrk(0);
    2d60:	e8 fd 0b 00 00       	call   3962 <sbrk>
    2d65:	83 c4 10             	add    $0x10,%esp
    2d68:	89 c3                	mov    %eax,%ebx
    2d6a:	eb 06                	jmp    2d72 <sbrktest+0x42>
    2d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    a = b + 1;
    2d70:	89 c3                	mov    %eax,%ebx

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	6a 01                	push   $0x1
    2d77:	e8 e6 0b 00 00       	call   3962 <sbrk>
    if(b != a){
    2d7c:	83 c4 10             	add    $0x10,%esp
    2d7f:	39 d8                	cmp    %ebx,%eax
    2d81:	0f 85 83 02 00 00    	jne    300a <sbrktest+0x2da>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2d87:	83 c6 01             	add    $0x1,%esi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2d8a:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2d8d:	8d 43 01             	lea    0x1(%ebx),%eax
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2d90:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2d96:	75 d8                	jne    2d70 <sbrktest+0x40>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2d98:	e8 1d 0b 00 00       	call   38ba <fork>
  if(pid < 0){
    2d9d:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2d9f:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2da1:	0f 88 91 03 00 00    	js     3138 <sbrktest+0x408>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2da7:	83 ec 0c             	sub    $0xc,%esp
  c = sbrk(1);
  if(c != a + 1){
    2daa:	83 c3 02             	add    $0x2,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2dad:	6a 01                	push   $0x1
    2daf:	e8 ae 0b 00 00       	call   3962 <sbrk>
  c = sbrk(1);
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 a2 0b 00 00       	call   3962 <sbrk>
  if(c != a + 1){
    2dc0:	83 c4 10             	add    $0x10,%esp
    2dc3:	39 d8                	cmp    %ebx,%eax
    2dc5:	0f 85 55 03 00 00    	jne    3120 <sbrktest+0x3f0>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2dcb:	85 f6                	test   %esi,%esi
    2dcd:	0f 84 48 03 00 00    	je     311b <sbrktest+0x3eb>
    exit();
  wait();
    2dd3:	e8 f2 0a 00 00       	call   38ca <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	6a 00                	push   $0x0
    2ddd:	e8 80 0b 00 00       	call   3962 <sbrk>
    2de2:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2de4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2de9:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2deb:	89 04 24             	mov    %eax,(%esp)
    2dee:	e8 6f 0b 00 00       	call   3962 <sbrk>
  if (p != a) {
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	39 c3                	cmp    %eax,%ebx
    2df8:	0f 85 05 03 00 00    	jne    3103 <sbrktest+0x3d3>
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    2dfe:	83 ec 0c             	sub    $0xc,%esp
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2e01:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2e08:	6a 00                	push   $0x0
    2e0a:	e8 53 0b 00 00       	call   3962 <sbrk>
  c = sbrk(-4096);
    2e0f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    2e16:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2e18:	e8 45 0b 00 00       	call   3962 <sbrk>
  if(c == (char*)0xffffffff){
    2e1d:	83 c4 10             	add    $0x10,%esp
    2e20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e23:	0f 84 c2 02 00 00    	je     30eb <sbrktest+0x3bb>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2e29:	83 ec 0c             	sub    $0xc,%esp
    2e2c:	6a 00                	push   $0x0
    2e2e:	e8 2f 0b 00 00       	call   3962 <sbrk>
  if(c != a - 4096){
    2e33:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	39 d0                	cmp    %edx,%eax
    2e3e:	0f 85 90 02 00 00    	jne    30d4 <sbrktest+0x3a4>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 14 0b 00 00       	call   3962 <sbrk>
    2e4e:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2e50:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e57:	e8 06 0b 00 00       	call   3962 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e5c:	83 c4 10             	add    $0x10,%esp
    2e5f:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    2e61:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2e63:	0f 85 54 02 00 00    	jne    30bd <sbrktest+0x38d>
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	6a 00                	push   $0x0
    2e6e:	e8 ef 0a 00 00       	call   3962 <sbrk>
    2e73:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	39 d0                	cmp    %edx,%eax
    2e7e:	0f 85 39 02 00 00    	jne    30bd <sbrktest+0x38d>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    2e84:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e8b:	0f 84 14 02 00 00    	je     30a5 <sbrktest+0x375>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2e91:	83 ec 0c             	sub    $0xc,%esp
    2e94:	6a 00                	push   $0x0
    2e96:	e8 c7 0a 00 00       	call   3962 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2ea2:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2ea4:	e8 b9 0a 00 00       	call   3962 <sbrk>
    2ea9:	89 f9                	mov    %edi,%ecx
    2eab:	29 c1                	sub    %eax,%ecx
    2ead:	89 0c 24             	mov    %ecx,(%esp)
    2eb0:	e8 ad 0a 00 00       	call   3962 <sbrk>
  if(c != a){
    2eb5:	83 c4 10             	add    $0x10,%esp
    2eb8:	39 c3                	cmp    %eax,%ebx
    2eba:	0f 85 ce 01 00 00    	jne    308e <sbrktest+0x35e>
    2ec0:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ec5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    2ec8:	e8 75 0a 00 00       	call   3942 <getpid>
    2ecd:	89 c6                	mov    %eax,%esi
    pid = fork();
    2ecf:	e8 e6 09 00 00       	call   38ba <fork>
    if(pid < 0){
    2ed4:	85 c0                	test   %eax,%eax
    2ed6:	0f 88 9a 01 00 00    	js     3076 <sbrktest+0x346>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    2edc:	0f 84 72 01 00 00    	je     3054 <sbrktest+0x324>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ee2:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    2ee8:	e8 dd 09 00 00       	call   38ca <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eed:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2ef3:	75 d3                	jne    2ec8 <sbrktest+0x198>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2ef5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ef8:	83 ec 0c             	sub    $0xc,%esp
    2efb:	50                   	push   %eax
    2efc:	e8 d1 09 00 00       	call   38d2 <pipe>
    2f01:	83 c4 10             	add    $0x10,%esp
    2f04:	85 c0                	test   %eax,%eax
    2f06:	0f 85 34 01 00 00    	jne    3040 <sbrktest+0x310>
    2f0c:	8d 75 c0             	lea    -0x40(%ebp),%esi
    2f0f:	89 f3                	mov    %esi,%ebx
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    2f11:	e8 a4 09 00 00       	call   38ba <fork>
    2f16:	85 c0                	test   %eax,%eax
    2f18:	89 03                	mov    %eax,(%ebx)
    2f1a:	0f 84 a5 00 00 00    	je     2fc5 <sbrktest+0x295>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    2f20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f23:	74 14                	je     2f39 <sbrktest+0x209>
      read(fds[0], &scratch, 1);
    2f25:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f28:	83 ec 04             	sub    $0x4,%esp
    2f2b:	6a 01                	push   $0x1
    2f2d:	50                   	push   %eax
    2f2e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f31:	e8 a4 09 00 00       	call   38da <read>
    2f36:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f39:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f3c:	83 c3 04             	add    $0x4,%ebx
    2f3f:	39 c3                	cmp    %eax,%ebx
    2f41:	75 ce                	jne    2f11 <sbrktest+0x1e1>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2f43:	83 ec 0c             	sub    $0xc,%esp
    2f46:	68 00 10 00 00       	push   $0x1000
    2f4b:	e8 12 0a 00 00       	call   3962 <sbrk>
    2f50:	83 c4 10             	add    $0x10,%esp
    2f53:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    2f56:	8b 06                	mov    (%esi),%eax
    2f58:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f5b:	74 11                	je     2f6e <sbrktest+0x23e>
      continue;
    kill(pids[i]);
    2f5d:	83 ec 0c             	sub    $0xc,%esp
    2f60:	50                   	push   %eax
    2f61:	e8 8c 09 00 00       	call   38f2 <kill>
    wait();
    2f66:	e8 5f 09 00 00       	call   38ca <wait>
    2f6b:	83 c4 10             	add    $0x10,%esp
    2f6e:	83 c6 04             	add    $0x4,%esi
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f71:	39 f3                	cmp    %esi,%ebx
    2f73:	75 e1                	jne    2f56 <sbrktest+0x226>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    2f75:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2f79:	0f 84 a9 00 00 00    	je     3028 <sbrktest+0x2f8>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    2f7f:	83 ec 0c             	sub    $0xc,%esp
    2f82:	6a 00                	push   $0x0
    2f84:	e8 d9 09 00 00       	call   3962 <sbrk>
    2f89:	83 c4 10             	add    $0x10,%esp
    2f8c:	39 c7                	cmp    %eax,%edi
    2f8e:	73 17                	jae    2fa7 <sbrktest+0x277>
    sbrk(-(sbrk(0) - oldbrk));
    2f90:	83 ec 0c             	sub    $0xc,%esp
    2f93:	6a 00                	push   $0x0
    2f95:	e8 c8 09 00 00       	call   3962 <sbrk>
    2f9a:	29 c7                	sub    %eax,%edi
    2f9c:	89 3c 24             	mov    %edi,(%esp)
    2f9f:	e8 be 09 00 00       	call   3962 <sbrk>
    2fa4:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    2fa7:	83 ec 08             	sub    $0x8,%esp
    2faa:	68 e8 4b 00 00       	push   $0x4be8
    2faf:	ff 35 e8 5d 00 00    	pushl  0x5de8
    2fb5:	e8 76 0a 00 00       	call   3a30 <printf>
}
    2fba:	83 c4 10             	add    $0x10,%esp
    2fbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fc0:	5b                   	pop    %ebx
    2fc1:	5e                   	pop    %esi
    2fc2:	5f                   	pop    %edi
    2fc3:	5d                   	pop    %ebp
    2fc4:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    2fc5:	83 ec 0c             	sub    $0xc,%esp
    2fc8:	6a 00                	push   $0x0
    2fca:	e8 93 09 00 00       	call   3962 <sbrk>
    2fcf:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2fd4:	29 c2                	sub    %eax,%edx
    2fd6:	89 14 24             	mov    %edx,(%esp)
    2fd9:	e8 84 09 00 00       	call   3962 <sbrk>
      write(fds[1], "x", 1);
    2fde:	83 c4 0c             	add    $0xc,%esp
    2fe1:	6a 01                	push   $0x1
    2fe3:	68 a9 46 00 00       	push   $0x46a9
    2fe8:	ff 75 bc             	pushl  -0x44(%ebp)
    2feb:	e8 f2 08 00 00       	call   38e2 <write>
    2ff0:	83 c4 10             	add    $0x10,%esp
    2ff3:	90                   	nop
    2ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      // sit around until killed
      for(;;) sleep(1000);
    2ff8:	83 ec 0c             	sub    $0xc,%esp
    2ffb:	68 e8 03 00 00       	push   $0x3e8
    3000:	e8 65 09 00 00       	call   396a <sleep>
    3005:	83 c4 10             	add    $0x10,%esp
    3008:	eb ee                	jmp    2ff8 <sbrktest+0x2c8>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    300a:	83 ec 0c             	sub    $0xc,%esp
    300d:	50                   	push   %eax
    300e:	53                   	push   %ebx
    300f:	56                   	push   %esi
    3010:	68 4b 4b 00 00       	push   $0x4b4b
    3015:	ff 35 e8 5d 00 00    	pushl  0x5de8
    301b:	e8 10 0a 00 00       	call   3a30 <printf>
      exit();
    3020:	83 c4 20             	add    $0x20,%esp
    3023:	e8 9a 08 00 00       	call   38c2 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    3028:	83 ec 08             	sub    $0x8,%esp
    302b:	68 cd 4b 00 00       	push   $0x4bcd
    3030:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3036:	e8 f5 09 00 00       	call   3a30 <printf>
    exit();
    303b:	e8 82 08 00 00       	call   38c2 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    3040:	83 ec 08             	sub    $0x8,%esp
    3043:	68 89 40 00 00       	push   $0x4089
    3048:	6a 01                	push   $0x1
    304a:	e8 e1 09 00 00       	call   3a30 <printf>
    exit();
    304f:	e8 6e 08 00 00       	call   38c2 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3054:	0f be 03             	movsbl (%ebx),%eax
    3057:	50                   	push   %eax
    3058:	53                   	push   %ebx
    3059:	68 b4 4b 00 00       	push   $0x4bb4
    305e:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3064:	e8 c7 09 00 00       	call   3a30 <printf>
      kill(ppid);
    3069:	89 34 24             	mov    %esi,(%esp)
    306c:	e8 81 08 00 00       	call   38f2 <kill>
      exit();
    3071:	e8 4c 08 00 00       	call   38c2 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    3076:	83 ec 08             	sub    $0x8,%esp
    3079:	68 91 4c 00 00       	push   $0x4c91
    307e:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3084:	e8 a7 09 00 00       	call   3a30 <printf>
      exit();
    3089:	e8 34 08 00 00       	call   38c2 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    308e:	50                   	push   %eax
    308f:	53                   	push   %ebx
    3090:	68 94 53 00 00       	push   $0x5394
    3095:	ff 35 e8 5d 00 00    	pushl  0x5de8
    309b:	e8 90 09 00 00       	call   3a30 <printf>
    exit();
    30a0:	e8 1d 08 00 00       	call   38c2 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30a5:	83 ec 08             	sub    $0x8,%esp
    30a8:	68 64 53 00 00       	push   $0x5364
    30ad:	ff 35 e8 5d 00 00    	pushl  0x5de8
    30b3:	e8 78 09 00 00       	call   3a30 <printf>
    exit();
    30b8:	e8 05 08 00 00       	call   38c2 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    30bd:	56                   	push   %esi
    30be:	53                   	push   %ebx
    30bf:	68 3c 53 00 00       	push   $0x533c
    30c4:	ff 35 e8 5d 00 00    	pushl  0x5de8
    30ca:	e8 61 09 00 00       	call   3a30 <printf>
    exit();
    30cf:	e8 ee 07 00 00       	call   38c2 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    30d4:	50                   	push   %eax
    30d5:	53                   	push   %ebx
    30d6:	68 04 53 00 00       	push   $0x5304
    30db:	ff 35 e8 5d 00 00    	pushl  0x5de8
    30e1:	e8 4a 09 00 00       	call   3a30 <printf>
    exit();
    30e6:	e8 d7 07 00 00       	call   38c2 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    30eb:	83 ec 08             	sub    $0x8,%esp
    30ee:	68 99 4b 00 00       	push   $0x4b99
    30f3:	ff 35 e8 5d 00 00    	pushl  0x5de8
    30f9:	e8 32 09 00 00       	call   3a30 <printf>
    exit();
    30fe:	e8 bf 07 00 00       	call   38c2 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3103:	83 ec 08             	sub    $0x8,%esp
    3106:	68 c4 52 00 00       	push   $0x52c4
    310b:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3111:	e8 1a 09 00 00       	call   3a30 <printf>
    exit();
    3116:	e8 a7 07 00 00       	call   38c2 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    exit();
    311b:	e8 a2 07 00 00       	call   38c2 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    3120:	83 ec 08             	sub    $0x8,%esp
    3123:	68 7d 4b 00 00       	push   $0x4b7d
    3128:	ff 35 e8 5d 00 00    	pushl  0x5de8
    312e:	e8 fd 08 00 00       	call   3a30 <printf>
    exit();
    3133:	e8 8a 07 00 00       	call   38c2 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    3138:	83 ec 08             	sub    $0x8,%esp
    313b:	68 66 4b 00 00       	push   $0x4b66
    3140:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3146:	e8 e5 08 00 00       	call   3a30 <printf>
    exit();
    314b:	e8 72 07 00 00       	call   38c2 <exit>

00003150 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3153:	5d                   	pop    %ebp
    3154:	c3                   	ret    
    3155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003160 <validatetest>:

void
validatetest(void)
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	56                   	push   %esi
    3164:	53                   	push   %ebx
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    3165:	31 db                	xor    %ebx,%ebx
validatetest(void)
{
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3167:	83 ec 08             	sub    $0x8,%esp
    316a:	68 f6 4b 00 00       	push   $0x4bf6
    316f:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3175:	e8 b6 08 00 00       	call   3a30 <printf>
    317a:	83 c4 10             	add    $0x10,%esp
    317d:	8d 76 00             	lea    0x0(%esi),%esi
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    3180:	e8 35 07 00 00       	call   38ba <fork>
    3185:	85 c0                	test   %eax,%eax
    3187:	89 c6                	mov    %eax,%esi
    3189:	74 63                	je     31ee <validatetest+0x8e>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    318b:	83 ec 0c             	sub    $0xc,%esp
    318e:	6a 00                	push   $0x0
    3190:	e8 d5 07 00 00       	call   396a <sleep>
    sleep(0);
    3195:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    319c:	e8 c9 07 00 00       	call   396a <sleep>
    kill(pid);
    31a1:	89 34 24             	mov    %esi,(%esp)
    31a4:	e8 49 07 00 00       	call   38f2 <kill>
    wait();
    31a9:	e8 1c 07 00 00       	call   38ca <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    31ae:	58                   	pop    %eax
    31af:	5a                   	pop    %edx
    31b0:	53                   	push   %ebx
    31b1:	68 05 4c 00 00       	push   $0x4c05
    31b6:	e8 67 07 00 00       	call   3922 <link>
    31bb:	83 c4 10             	add    $0x10,%esp
    31be:	83 f8 ff             	cmp    $0xffffffff,%eax
    31c1:	75 30                	jne    31f3 <validatetest+0x93>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    31c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31c9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31cf:	75 af                	jne    3180 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    31d1:	83 ec 08             	sub    $0x8,%esp
    31d4:	68 29 4c 00 00       	push   $0x4c29
    31d9:	ff 35 e8 5d 00 00    	pushl  0x5de8
    31df:	e8 4c 08 00 00       	call   3a30 <printf>
}
    31e4:	83 c4 10             	add    $0x10,%esp
    31e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31ea:	5b                   	pop    %ebx
    31eb:	5e                   	pop    %esi
    31ec:	5d                   	pop    %ebp
    31ed:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    31ee:	e8 cf 06 00 00       	call   38c2 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    31f3:	83 ec 08             	sub    $0x8,%esp
    31f6:	68 10 4c 00 00       	push   $0x4c10
    31fb:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3201:	e8 2a 08 00 00       	call   3a30 <printf>
      exit();
    3206:	e8 b7 06 00 00       	call   38c2 <exit>
    320b:	90                   	nop
    320c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003210 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    3216:	68 36 4c 00 00       	push   $0x4c36
    321b:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3221:	e8 0a 08 00 00       	call   3a30 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    3226:	83 c4 10             	add    $0x10,%esp
    3229:	80 3d a0 5e 00 00 00 	cmpb   $0x0,0x5ea0
    3230:	75 39                	jne    326b <bsstest+0x5b>
    3232:	b8 01 00 00 00       	mov    $0x1,%eax
    3237:	89 f6                	mov    %esi,%esi
    3239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3240:	80 b8 a0 5e 00 00 00 	cmpb   $0x0,0x5ea0(%eax)
    3247:	75 22                	jne    326b <bsstest+0x5b>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    3249:	83 c0 01             	add    $0x1,%eax
    324c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3251:	75 ed                	jne    3240 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    3253:	83 ec 08             	sub    $0x8,%esp
    3256:	68 51 4c 00 00       	push   $0x4c51
    325b:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3261:	e8 ca 07 00 00       	call   3a30 <printf>
}
    3266:	83 c4 10             	add    $0x10,%esp
    3269:	c9                   	leave  
    326a:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    326b:	83 ec 08             	sub    $0x8,%esp
    326e:	68 40 4c 00 00       	push   $0x4c40
    3273:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3279:	e8 b2 07 00 00       	call   3a30 <printf>
      exit();
    327e:	e8 3f 06 00 00       	call   38c2 <exit>
    3283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003290 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3290:	55                   	push   %ebp
    3291:	89 e5                	mov    %esp,%ebp
    3293:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3296:	68 5e 4c 00 00       	push   $0x4c5e
    329b:	e8 72 06 00 00       	call   3912 <unlink>
  pid = fork();
    32a0:	e8 15 06 00 00       	call   38ba <fork>
  if(pid == 0){
    32a5:	83 c4 10             	add    $0x10,%esp
    32a8:	85 c0                	test   %eax,%eax
    32aa:	74 3f                	je     32eb <bigargtest+0x5b>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    32ac:	0f 88 c2 00 00 00    	js     3374 <bigargtest+0xe4>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    32b2:	e8 13 06 00 00       	call   38ca <wait>
  fd = open("bigarg-ok", 0);
    32b7:	83 ec 08             	sub    $0x8,%esp
    32ba:	6a 00                	push   $0x0
    32bc:	68 5e 4c 00 00       	push   $0x4c5e
    32c1:	e8 3c 06 00 00       	call   3902 <open>
  if(fd < 0){
    32c6:	83 c4 10             	add    $0x10,%esp
    32c9:	85 c0                	test   %eax,%eax
    32cb:	0f 88 8c 00 00 00    	js     335d <bigargtest+0xcd>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    32d1:	83 ec 0c             	sub    $0xc,%esp
    32d4:	50                   	push   %eax
    32d5:	e8 10 06 00 00       	call   38ea <close>
  unlink("bigarg-ok");
    32da:	c7 04 24 5e 4c 00 00 	movl   $0x4c5e,(%esp)
    32e1:	e8 2c 06 00 00       	call   3912 <unlink>
}
    32e6:	83 c4 10             	add    $0x10,%esp
    32e9:	c9                   	leave  
    32ea:	c3                   	ret    
    32eb:	b8 00 5e 00 00       	mov    $0x5e00,%eax
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    32f0:	c7 00 b8 53 00 00    	movl   $0x53b8,(%eax)
    32f6:	83 c0 04             	add    $0x4,%eax
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    32f9:	3d 7c 5e 00 00       	cmp    $0x5e7c,%eax
    32fe:	75 f0                	jne    32f0 <bigargtest+0x60>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    3300:	51                   	push   %ecx
    3301:	51                   	push   %ecx
    3302:	68 68 4c 00 00       	push   $0x4c68
    3307:	ff 35 e8 5d 00 00    	pushl  0x5de8
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    330d:	c7 05 7c 5e 00 00 00 	movl   $0x0,0x5e7c
    3314:	00 00 00 
    printf(stdout, "bigarg test\n");
    3317:	e8 14 07 00 00       	call   3a30 <printf>
    exec("echo", args);
    331c:	58                   	pop    %eax
    331d:	5a                   	pop    %edx
    331e:	68 00 5e 00 00       	push   $0x5e00
    3323:	68 35 3e 00 00       	push   $0x3e35
    3328:	e8 cd 05 00 00       	call   38fa <exec>
    printf(stdout, "bigarg test ok\n");
    332d:	59                   	pop    %ecx
    332e:	58                   	pop    %eax
    332f:	68 75 4c 00 00       	push   $0x4c75
    3334:	ff 35 e8 5d 00 00    	pushl  0x5de8
    333a:	e8 f1 06 00 00       	call   3a30 <printf>
    fd = open("bigarg-ok", O_CREATE);
    333f:	58                   	pop    %eax
    3340:	5a                   	pop    %edx
    3341:	68 00 02 00 00       	push   $0x200
    3346:	68 5e 4c 00 00       	push   $0x4c5e
    334b:	e8 b2 05 00 00       	call   3902 <open>
    close(fd);
    3350:	89 04 24             	mov    %eax,(%esp)
    3353:	e8 92 05 00 00       	call   38ea <close>
    exit();
    3358:	e8 65 05 00 00       	call   38c2 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    335d:	50                   	push   %eax
    335e:	50                   	push   %eax
    335f:	68 9e 4c 00 00       	push   $0x4c9e
    3364:	ff 35 e8 5d 00 00    	pushl  0x5de8
    336a:	e8 c1 06 00 00       	call   3a30 <printf>
    exit();
    336f:	e8 4e 05 00 00       	call   38c2 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3374:	52                   	push   %edx
    3375:	52                   	push   %edx
    3376:	68 85 4c 00 00       	push   $0x4c85
    337b:	ff 35 e8 5d 00 00    	pushl  0x5de8
    3381:	e8 aa 06 00 00       	call   3a30 <printf>
    exit();
    3386:	e8 37 05 00 00       	call   38c2 <exit>
    338b:	90                   	nop
    338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003390 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3390:	55                   	push   %ebp
    3391:	89 e5                	mov    %esp,%ebp
    3393:	57                   	push   %edi
    3394:	56                   	push   %esi
    3395:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3396:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3398:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    339b:	68 b3 4c 00 00       	push   $0x4cb3
    33a0:	6a 01                	push   $0x1
    33a2:	e8 89 06 00 00       	call   3a30 <printf>
    33a7:	83 c4 10             	add    $0x10,%esp
    33aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    33b0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    33b5:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    33b7:	89 d9                	mov    %ebx,%ecx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    33b9:	f7 eb                	imul   %ebx
    33bb:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    33be:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    33c0:	83 ec 04             	sub    $0x4,%esp

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    33c3:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    33c7:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    33cb:	c1 fa 06             	sar    $0x6,%edx
    33ce:	29 f2                	sub    %esi,%edx
    33d0:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33d3:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    33d9:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33dc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33e1:	29 d1                	sub    %edx,%ecx
    33e3:	f7 e9                	imul   %ecx
    33e5:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    33e8:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    33ed:	c1 fa 05             	sar    $0x5,%edx
    33f0:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    33f2:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    33f7:	83 c2 30             	add    $0x30,%edx
    33fa:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    33fd:	f7 eb                	imul   %ebx
    33ff:	c1 fa 05             	sar    $0x5,%edx
    3402:	29 f2                	sub    %esi,%edx
    3404:	6b d2 64             	imul   $0x64,%edx,%edx
    3407:	29 d7                	sub    %edx,%edi
    3409:	89 f8                	mov    %edi,%eax
    340b:	c1 ff 1f             	sar    $0x1f,%edi
    340e:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    3410:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    3412:	c1 fa 02             	sar    $0x2,%edx
    3415:	29 fa                	sub    %edi,%edx
    3417:	83 c2 30             	add    $0x30,%edx
    341a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    341d:	f7 e9                	imul   %ecx
    341f:	89 d9                	mov    %ebx,%ecx
    3421:	c1 fa 02             	sar    $0x2,%edx
    3424:	29 f2                	sub    %esi,%edx
    3426:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3429:	01 c0                	add    %eax,%eax
    342b:	29 c1                	sub    %eax,%ecx
    342d:	89 c8                	mov    %ecx,%eax
    342f:	83 c0 30             	add    $0x30,%eax
    3432:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    3435:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3438:	50                   	push   %eax
    3439:	68 c0 4c 00 00       	push   $0x4cc0
    343e:	6a 01                	push   $0x1
    3440:	e8 eb 05 00 00       	call   3a30 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3445:	58                   	pop    %eax
    3446:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3449:	5a                   	pop    %edx
    344a:	68 02 02 00 00       	push   $0x202
    344f:	50                   	push   %eax
    3450:	e8 ad 04 00 00       	call   3902 <open>
    if(fd < 0){
    3455:	83 c4 10             	add    $0x10,%esp
    3458:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    345a:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    345c:	78 50                	js     34ae <fsfull+0x11e>
    345e:	31 f6                	xor    %esi,%esi
    3460:	eb 08                	jmp    346a <fsfull+0xda>
    3462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3468:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    346a:	83 ec 04             	sub    $0x4,%esp
    346d:	68 00 02 00 00       	push   $0x200
    3472:	68 c0 85 00 00       	push   $0x85c0
    3477:	57                   	push   %edi
    3478:	e8 65 04 00 00       	call   38e2 <write>
      if(cc < 512)
    347d:	83 c4 10             	add    $0x10,%esp
    3480:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3485:	7f e1                	jg     3468 <fsfull+0xd8>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3487:	83 ec 04             	sub    $0x4,%esp
    348a:	56                   	push   %esi
    348b:	68 dc 4c 00 00       	push   $0x4cdc
    3490:	6a 01                	push   $0x1
    3492:	e8 99 05 00 00       	call   3a30 <printf>
    close(fd);
    3497:	89 3c 24             	mov    %edi,(%esp)
    349a:	e8 4b 04 00 00       	call   38ea <close>
    if(total == 0)
    349f:	83 c4 10             	add    $0x10,%esp
    34a2:	85 f6                	test   %esi,%esi
    34a4:	74 22                	je     34c8 <fsfull+0x138>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    34a6:	83 c3 01             	add    $0x1,%ebx
    34a9:	e9 02 ff ff ff       	jmp    33b0 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    34ae:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34b1:	83 ec 04             	sub    $0x4,%esp
    34b4:	50                   	push   %eax
    34b5:	68 cc 4c 00 00       	push   $0x4ccc
    34ba:	6a 01                	push   $0x1
    34bc:	e8 6f 05 00 00       	call   3a30 <printf>
      break;
    34c1:	83 c4 10             	add    $0x10,%esp
    34c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    34c8:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    34cd:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    34cf:	89 d9                	mov    %ebx,%ecx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    34d1:	f7 eb                	imul   %ebx
    34d3:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    34d6:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    unlink(name);
    34d8:	83 ec 0c             	sub    $0xc,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    34db:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    34df:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    34e3:	c1 fa 06             	sar    $0x6,%edx
    34e6:	29 f2                	sub    %esi,%edx
    34e8:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34eb:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    34f1:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34f4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    34f9:	29 d1                	sub    %edx,%ecx
    34fb:	f7 e9                	imul   %ecx
    34fd:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    3500:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3505:	c1 fa 05             	sar    $0x5,%edx
    3508:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    350a:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    350f:	83 c2 30             	add    $0x30,%edx
    3512:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3515:	f7 eb                	imul   %ebx
    3517:	c1 fa 05             	sar    $0x5,%edx
    351a:	29 f2                	sub    %esi,%edx
    351c:	6b d2 64             	imul   $0x64,%edx,%edx
    351f:	29 d7                	sub    %edx,%edi
    3521:	89 f8                	mov    %edi,%eax
    3523:	c1 ff 1f             	sar    $0x1f,%edi
    3526:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    3528:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    352a:	c1 fa 02             	sar    $0x2,%edx
    352d:	29 fa                	sub    %edi,%edx
    352f:	83 c2 30             	add    $0x30,%edx
    3532:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3535:	f7 e9                	imul   %ecx
    3537:	89 d9                	mov    %ebx,%ecx
    name[5] = '\0';
    unlink(name);
    nfiles--;
    3539:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    353c:	c1 fa 02             	sar    $0x2,%edx
    353f:	29 f2                	sub    %esi,%edx
    3541:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3544:	01 c0                	add    %eax,%eax
    3546:	29 c1                	sub    %eax,%ecx
    3548:	89 c8                	mov    %ecx,%eax
    354a:	83 c0 30             	add    $0x30,%eax
    354d:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    3550:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3553:	50                   	push   %eax
    3554:	e8 b9 03 00 00       	call   3912 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3559:	83 c4 10             	add    $0x10,%esp
    355c:	83 fb ff             	cmp    $0xffffffff,%ebx
    355f:	0f 85 63 ff ff ff    	jne    34c8 <fsfull+0x138>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3565:	83 ec 08             	sub    $0x8,%esp
    3568:	68 ec 4c 00 00       	push   $0x4cec
    356d:	6a 01                	push   $0x1
    356f:	e8 bc 04 00 00       	call   3a30 <printf>
}
    3574:	83 c4 10             	add    $0x10,%esp
    3577:	8d 65 f4             	lea    -0xc(%ebp),%esp
    357a:	5b                   	pop    %ebx
    357b:	5e                   	pop    %esi
    357c:	5f                   	pop    %edi
    357d:	5d                   	pop    %ebp
    357e:	c3                   	ret    
    357f:	90                   	nop

00003580 <uio>:

void
uio()
{
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3586:	68 02 4d 00 00       	push   $0x4d02
    358b:	6a 01                	push   $0x1
    358d:	e8 9e 04 00 00       	call   3a30 <printf>
  pid = fork();
    3592:	e8 23 03 00 00       	call   38ba <fork>
  if(pid == 0){
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	74 1b                	je     35b9 <uio+0x39>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    359e:	78 3d                	js     35dd <uio+0x5d>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    35a0:	e8 25 03 00 00       	call   38ca <wait>
  printf(1, "uio test done\n");
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 0c 4d 00 00       	push   $0x4d0c
    35ad:	6a 01                	push   $0x1
    35af:	e8 7c 04 00 00       	call   3a30 <printf>
}
    35b4:	83 c4 10             	add    $0x10,%esp
    35b7:	c9                   	leave  
    35b8:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    35b9:	ba 70 00 00 00       	mov    $0x70,%edx
    35be:	b8 09 00 00 00       	mov    $0x9,%eax
    35c3:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    35c4:	ba 71 00 00 00       	mov    $0x71,%edx
    35c9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 98 54 00 00       	push   $0x5498
    35d1:	6a 01                	push   $0x1
    35d3:	e8 58 04 00 00       	call   3a30 <printf>
    exit();
    35d8:	e8 e5 02 00 00       	call   38c2 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 91 4c 00 00       	push   $0x4c91
    35e4:	6a 01                	push   $0x1
    35e6:	e8 45 04 00 00       	call   3a30 <printf>
    exit();
    35eb:	e8 d2 02 00 00       	call   38c2 <exit>

000035f0 <argptest>:
  wait();
  printf(1, "uio test done\n");
}

void argptest()
{
    35f0:	55                   	push   %ebp
    35f1:	89 e5                	mov    %esp,%ebp
    35f3:	53                   	push   %ebx
    35f4:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    35f7:	6a 00                	push   $0x0
    35f9:	68 1b 4d 00 00       	push   $0x4d1b
    35fe:	e8 ff 02 00 00       	call   3902 <open>
  if (fd < 0) {
    3603:	83 c4 10             	add    $0x10,%esp
    3606:	85 c0                	test   %eax,%eax
    3608:	78 39                	js     3643 <argptest+0x53>
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    360a:	83 ec 0c             	sub    $0xc,%esp
    360d:	89 c3                	mov    %eax,%ebx
    360f:	6a 00                	push   $0x0
    3611:	e8 4c 03 00 00       	call   3962 <sbrk>
    3616:	83 c4 0c             	add    $0xc,%esp
    3619:	83 e8 01             	sub    $0x1,%eax
    361c:	6a ff                	push   $0xffffffff
    361e:	50                   	push   %eax
    361f:	53                   	push   %ebx
    3620:	e8 b5 02 00 00       	call   38da <read>
  close(fd);
    3625:	89 1c 24             	mov    %ebx,(%esp)
    3628:	e8 bd 02 00 00       	call   38ea <close>
  printf(1, "arg test passed\n");
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 2d 4d 00 00       	push   $0x4d2d
    3634:	6a 01                	push   $0x1
    3636:	e8 f5 03 00 00       	call   3a30 <printf>
}
    363b:	83 c4 10             	add    $0x10,%esp
    363e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3641:	c9                   	leave  
    3642:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 20 4d 00 00       	push   $0x4d20
    364a:	6a 02                	push   $0x2
    364c:	e8 df 03 00 00       	call   3a30 <printf>
    exit();
    3651:	e8 6c 02 00 00       	call   38c2 <exit>
    3656:	8d 76 00             	lea    0x0(%esi),%esi
    3659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003660 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    3660:	69 05 e4 5d 00 00 0d 	imul   $0x19660d,0x5de4,%eax
    3667:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    366a:	55                   	push   %ebp
    366b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    366d:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    366e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3673:	a3 e4 5d 00 00       	mov    %eax,0x5de4
  return randstate;
}
    3678:	c3                   	ret    
    3679:	66 90                	xchg   %ax,%ax
    367b:	66 90                	xchg   %ax,%ax
    367d:	66 90                	xchg   %ax,%ax
    367f:	90                   	nop

00003680 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	53                   	push   %ebx
    3684:	8b 45 08             	mov    0x8(%ebp),%eax
    3687:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    368a:	89 c2                	mov    %eax,%edx
    368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3690:	83 c1 01             	add    $0x1,%ecx
    3693:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3697:	83 c2 01             	add    $0x1,%edx
    369a:	84 db                	test   %bl,%bl
    369c:	88 5a ff             	mov    %bl,-0x1(%edx)
    369f:	75 ef                	jne    3690 <strcpy+0x10>
    ;
  return os;
}
    36a1:	5b                   	pop    %ebx
    36a2:	5d                   	pop    %ebp
    36a3:	c3                   	ret    
    36a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000036b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	56                   	push   %esi
    36b4:	53                   	push   %ebx
    36b5:	8b 55 08             	mov    0x8(%ebp),%edx
    36b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    36bb:	0f b6 02             	movzbl (%edx),%eax
    36be:	0f b6 19             	movzbl (%ecx),%ebx
    36c1:	84 c0                	test   %al,%al
    36c3:	75 1e                	jne    36e3 <strcmp+0x33>
    36c5:	eb 29                	jmp    36f0 <strcmp+0x40>
    36c7:	89 f6                	mov    %esi,%esi
    36c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    36d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    36d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    36dd:	84 c0                	test   %al,%al
    36df:	74 0f                	je     36f0 <strcmp+0x40>
    36e1:	89 f1                	mov    %esi,%ecx
    36e3:	38 d8                	cmp    %bl,%al
    36e5:	74 e9                	je     36d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    36e7:	29 d8                	sub    %ebx,%eax
}
    36e9:	5b                   	pop    %ebx
    36ea:	5e                   	pop    %esi
    36eb:	5d                   	pop    %ebp
    36ec:	c3                   	ret    
    36ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    36f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    36f2:	29 d8                	sub    %ebx,%eax
}
    36f4:	5b                   	pop    %ebx
    36f5:	5e                   	pop    %esi
    36f6:	5d                   	pop    %ebp
    36f7:	c3                   	ret    
    36f8:	90                   	nop
    36f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003700 <strlen>:

uint
strlen(char *s)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3706:	80 39 00             	cmpb   $0x0,(%ecx)
    3709:	74 12                	je     371d <strlen+0x1d>
    370b:	31 d2                	xor    %edx,%edx
    370d:	8d 76 00             	lea    0x0(%esi),%esi
    3710:	83 c2 01             	add    $0x1,%edx
    3713:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3717:	89 d0                	mov    %edx,%eax
    3719:	75 f5                	jne    3710 <strlen+0x10>
    ;
  return n;
}
    371b:	5d                   	pop    %ebp
    371c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    371d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    371f:	5d                   	pop    %ebp
    3720:	c3                   	ret    
    3721:	eb 0d                	jmp    3730 <memset>
    3723:	90                   	nop
    3724:	90                   	nop
    3725:	90                   	nop
    3726:	90                   	nop
    3727:	90                   	nop
    3728:	90                   	nop
    3729:	90                   	nop
    372a:	90                   	nop
    372b:	90                   	nop
    372c:	90                   	nop
    372d:	90                   	nop
    372e:	90                   	nop
    372f:	90                   	nop

00003730 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	57                   	push   %edi
    3734:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3737:	8b 4d 10             	mov    0x10(%ebp),%ecx
    373a:	8b 45 0c             	mov    0xc(%ebp),%eax
    373d:	89 d7                	mov    %edx,%edi
    373f:	fc                   	cld    
    3740:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3742:	89 d0                	mov    %edx,%eax
    3744:	5f                   	pop    %edi
    3745:	5d                   	pop    %ebp
    3746:	c3                   	ret    
    3747:	89 f6                	mov    %esi,%esi
    3749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003750 <strchr>:

char*
strchr(const char *s, char c)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	53                   	push   %ebx
    3754:	8b 45 08             	mov    0x8(%ebp),%eax
    3757:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    375a:	0f b6 10             	movzbl (%eax),%edx
    375d:	84 d2                	test   %dl,%dl
    375f:	74 1d                	je     377e <strchr+0x2e>
    if(*s == c)
    3761:	38 d3                	cmp    %dl,%bl
    3763:	89 d9                	mov    %ebx,%ecx
    3765:	75 0d                	jne    3774 <strchr+0x24>
    3767:	eb 17                	jmp    3780 <strchr+0x30>
    3769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3770:	38 ca                	cmp    %cl,%dl
    3772:	74 0c                	je     3780 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3774:	83 c0 01             	add    $0x1,%eax
    3777:	0f b6 10             	movzbl (%eax),%edx
    377a:	84 d2                	test   %dl,%dl
    377c:	75 f2                	jne    3770 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    377e:	31 c0                	xor    %eax,%eax
}
    3780:	5b                   	pop    %ebx
    3781:	5d                   	pop    %ebp
    3782:	c3                   	ret    
    3783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003790 <gets>:

char*
gets(char *buf, int max)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	57                   	push   %edi
    3794:	56                   	push   %esi
    3795:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3796:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    3798:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    379b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    379e:	eb 29                	jmp    37c9 <gets+0x39>
    cc = read(0, &c, 1);
    37a0:	83 ec 04             	sub    $0x4,%esp
    37a3:	6a 01                	push   $0x1
    37a5:	57                   	push   %edi
    37a6:	6a 00                	push   $0x0
    37a8:	e8 2d 01 00 00       	call   38da <read>
    if(cc < 1)
    37ad:	83 c4 10             	add    $0x10,%esp
    37b0:	85 c0                	test   %eax,%eax
    37b2:	7e 1d                	jle    37d1 <gets+0x41>
      break;
    buf[i++] = c;
    37b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37b8:	8b 55 08             	mov    0x8(%ebp),%edx
    37bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    37bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    37bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    37c3:	74 1b                	je     37e0 <gets+0x50>
    37c5:	3c 0d                	cmp    $0xd,%al
    37c7:	74 17                	je     37e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37c9:	8d 5e 01             	lea    0x1(%esi),%ebx
    37cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37cf:	7c cf                	jl     37a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    37d1:	8b 45 08             	mov    0x8(%ebp),%eax
    37d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    37d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37db:	5b                   	pop    %ebx
    37dc:	5e                   	pop    %esi
    37dd:	5f                   	pop    %edi
    37de:	5d                   	pop    %ebp
    37df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    37e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    37e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    37e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37ec:	5b                   	pop    %ebx
    37ed:	5e                   	pop    %esi
    37ee:	5f                   	pop    %edi
    37ef:	5d                   	pop    %ebp
    37f0:	c3                   	ret    
    37f1:	eb 0d                	jmp    3800 <stat>
    37f3:	90                   	nop
    37f4:	90                   	nop
    37f5:	90                   	nop
    37f6:	90                   	nop
    37f7:	90                   	nop
    37f8:	90                   	nop
    37f9:	90                   	nop
    37fa:	90                   	nop
    37fb:	90                   	nop
    37fc:	90                   	nop
    37fd:	90                   	nop
    37fe:	90                   	nop
    37ff:	90                   	nop

00003800 <stat>:

int
stat(char *n, struct stat *st)
{
    3800:	55                   	push   %ebp
    3801:	89 e5                	mov    %esp,%ebp
    3803:	56                   	push   %esi
    3804:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3805:	83 ec 08             	sub    $0x8,%esp
    3808:	6a 00                	push   $0x0
    380a:	ff 75 08             	pushl  0x8(%ebp)
    380d:	e8 f0 00 00 00       	call   3902 <open>
  if(fd < 0)
    3812:	83 c4 10             	add    $0x10,%esp
    3815:	85 c0                	test   %eax,%eax
    3817:	78 27                	js     3840 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3819:	83 ec 08             	sub    $0x8,%esp
    381c:	ff 75 0c             	pushl  0xc(%ebp)
    381f:	89 c3                	mov    %eax,%ebx
    3821:	50                   	push   %eax
    3822:	e8 f3 00 00 00       	call   391a <fstat>
  close(fd);
    3827:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    382a:	89 c6                	mov    %eax,%esi
  close(fd);
    382c:	e8 b9 00 00 00       	call   38ea <close>
  return r;
    3831:	83 c4 10             	add    $0x10,%esp
}
    3834:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3837:	89 f0                	mov    %esi,%eax
    3839:	5b                   	pop    %ebx
    383a:	5e                   	pop    %esi
    383b:	5d                   	pop    %ebp
    383c:	c3                   	ret    
    383d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3840:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3845:	eb ed                	jmp    3834 <stat+0x34>
    3847:	89 f6                	mov    %esi,%esi
    3849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003850 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3850:	55                   	push   %ebp
    3851:	89 e5                	mov    %esp,%ebp
    3853:	53                   	push   %ebx
    3854:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3857:	0f be 11             	movsbl (%ecx),%edx
    385a:	8d 42 d0             	lea    -0x30(%edx),%eax
    385d:	3c 09                	cmp    $0x9,%al
    385f:	b8 00 00 00 00       	mov    $0x0,%eax
    3864:	77 1f                	ja     3885 <atoi+0x35>
    3866:	8d 76 00             	lea    0x0(%esi),%esi
    3869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3870:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3873:	83 c1 01             	add    $0x1,%ecx
    3876:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    387a:	0f be 11             	movsbl (%ecx),%edx
    387d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3880:	80 fb 09             	cmp    $0x9,%bl
    3883:	76 eb                	jbe    3870 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    3885:	5b                   	pop    %ebx
    3886:	5d                   	pop    %ebp
    3887:	c3                   	ret    
    3888:	90                   	nop
    3889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003890 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3890:	55                   	push   %ebp
    3891:	89 e5                	mov    %esp,%ebp
    3893:	56                   	push   %esi
    3894:	53                   	push   %ebx
    3895:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3898:	8b 45 08             	mov    0x8(%ebp),%eax
    389b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    389e:	85 db                	test   %ebx,%ebx
    38a0:	7e 14                	jle    38b6 <memmove+0x26>
    38a2:	31 d2                	xor    %edx,%edx
    38a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    38a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    38ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    38af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    38b2:	39 da                	cmp    %ebx,%edx
    38b4:	75 f2                	jne    38a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    38b6:	5b                   	pop    %ebx
    38b7:	5e                   	pop    %esi
    38b8:	5d                   	pop    %ebp
    38b9:	c3                   	ret    

000038ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    38ba:	b8 01 00 00 00       	mov    $0x1,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <exit>:
SYSCALL(exit)
    38c2:	b8 02 00 00 00       	mov    $0x2,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <wait>:
SYSCALL(wait)
    38ca:	b8 03 00 00 00       	mov    $0x3,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <pipe>:
SYSCALL(pipe)
    38d2:	b8 04 00 00 00       	mov    $0x4,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <read>:
SYSCALL(read)
    38da:	b8 05 00 00 00       	mov    $0x5,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <write>:
SYSCALL(write)
    38e2:	b8 10 00 00 00       	mov    $0x10,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <close>:
SYSCALL(close)
    38ea:	b8 15 00 00 00       	mov    $0x15,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <kill>:
SYSCALL(kill)
    38f2:	b8 06 00 00 00       	mov    $0x6,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <exec>:
SYSCALL(exec)
    38fa:	b8 07 00 00 00       	mov    $0x7,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <open>:
SYSCALL(open)
    3902:	b8 0f 00 00 00       	mov    $0xf,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <mknod>:
SYSCALL(mknod)
    390a:	b8 11 00 00 00       	mov    $0x11,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    

00003912 <unlink>:
SYSCALL(unlink)
    3912:	b8 12 00 00 00       	mov    $0x12,%eax
    3917:	cd 40                	int    $0x40
    3919:	c3                   	ret    

0000391a <fstat>:
SYSCALL(fstat)
    391a:	b8 08 00 00 00       	mov    $0x8,%eax
    391f:	cd 40                	int    $0x40
    3921:	c3                   	ret    

00003922 <link>:
SYSCALL(link)
    3922:	b8 13 00 00 00       	mov    $0x13,%eax
    3927:	cd 40                	int    $0x40
    3929:	c3                   	ret    

0000392a <mkdir>:
SYSCALL(mkdir)
    392a:	b8 14 00 00 00       	mov    $0x14,%eax
    392f:	cd 40                	int    $0x40
    3931:	c3                   	ret    

00003932 <chdir>:
SYSCALL(chdir)
    3932:	b8 09 00 00 00       	mov    $0x9,%eax
    3937:	cd 40                	int    $0x40
    3939:	c3                   	ret    

0000393a <dup>:
SYSCALL(dup)
    393a:	b8 0a 00 00 00       	mov    $0xa,%eax
    393f:	cd 40                	int    $0x40
    3941:	c3                   	ret    

00003942 <getpid>:
SYSCALL(getpid)
    3942:	b8 0b 00 00 00       	mov    $0xb,%eax
    3947:	cd 40                	int    $0x40
    3949:	c3                   	ret    

0000394a <getppid>:
SYSCALL(getppid)
    394a:	b8 19 00 00 00       	mov    $0x19,%eax
    394f:	cd 40                	int    $0x40
    3951:	c3                   	ret    

00003952 <getAllPids>:
SYSCALL(getAllPids)
    3952:	b8 17 00 00 00       	mov    $0x17,%eax
    3957:	cd 40                	int    $0x40
    3959:	c3                   	ret    

0000395a <shutdown>:
SYSCALL(shutdown)
    395a:	b8 18 00 00 00       	mov    $0x18,%eax
    395f:	cd 40                	int    $0x40
    3961:	c3                   	ret    

00003962 <sbrk>:
SYSCALL(sbrk)
    3962:	b8 0c 00 00 00       	mov    $0xc,%eax
    3967:	cd 40                	int    $0x40
    3969:	c3                   	ret    

0000396a <sleep>:
SYSCALL(sleep)
    396a:	b8 0d 00 00 00       	mov    $0xd,%eax
    396f:	cd 40                	int    $0x40
    3971:	c3                   	ret    

00003972 <uptime>:
SYSCALL(uptime)
    3972:	b8 0e 00 00 00       	mov    $0xe,%eax
    3977:	cd 40                	int    $0x40
    3979:	c3                   	ret    

0000397a <cps>:
SYSCALL(cps)
    397a:	b8 16 00 00 00       	mov    $0x16,%eax
    397f:	cd 40                	int    $0x40
    3981:	c3                   	ret    
    3982:	66 90                	xchg   %ax,%ax
    3984:	66 90                	xchg   %ax,%ax
    3986:	66 90                	xchg   %ax,%ax
    3988:	66 90                	xchg   %ax,%ax
    398a:	66 90                	xchg   %ax,%ax
    398c:	66 90                	xchg   %ax,%ax
    398e:	66 90                	xchg   %ax,%ax

00003990 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3990:	55                   	push   %ebp
    3991:	89 e5                	mov    %esp,%ebp
    3993:	57                   	push   %edi
    3994:	56                   	push   %esi
    3995:	53                   	push   %ebx
    3996:	89 c6                	mov    %eax,%esi
    3998:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    399b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    399e:	85 db                	test   %ebx,%ebx
    39a0:	74 7e                	je     3a20 <printint+0x90>
    39a2:	89 d0                	mov    %edx,%eax
    39a4:	c1 e8 1f             	shr    $0x1f,%eax
    39a7:	84 c0                	test   %al,%al
    39a9:	74 75                	je     3a20 <printint+0x90>
    neg = 1;
    x = -xx;
    39ab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    39ad:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    39b4:	f7 d8                	neg    %eax
    39b6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    39b9:	31 ff                	xor    %edi,%edi
    39bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    39be:	89 ce                	mov    %ecx,%esi
    39c0:	eb 08                	jmp    39ca <printint+0x3a>
    39c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    39c8:	89 cf                	mov    %ecx,%edi
    39ca:	31 d2                	xor    %edx,%edx
    39cc:	8d 4f 01             	lea    0x1(%edi),%ecx
    39cf:	f7 f6                	div    %esi
    39d1:	0f b6 92 f0 54 00 00 	movzbl 0x54f0(%edx),%edx
  }while((x /= base) != 0);
    39d8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    39da:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    39dd:	75 e9                	jne    39c8 <printint+0x38>
  if(neg)
    39df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    39e2:	8b 75 c0             	mov    -0x40(%ebp),%esi
    39e5:	85 c0                	test   %eax,%eax
    39e7:	74 08                	je     39f1 <printint+0x61>
    buf[i++] = '-';
    39e9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    39ee:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
    39f1:	8d 79 ff             	lea    -0x1(%ecx),%edi
    39f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    39f8:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    39fd:	83 ec 04             	sub    $0x4,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3a00:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a03:	6a 01                	push   $0x1
    3a05:	53                   	push   %ebx
    3a06:	56                   	push   %esi
    3a07:	88 45 d7             	mov    %al,-0x29(%ebp)
    3a0a:	e8 d3 fe ff ff       	call   38e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3a0f:	83 c4 10             	add    $0x10,%esp
    3a12:	83 ff ff             	cmp    $0xffffffff,%edi
    3a15:	75 e1                	jne    39f8 <printint+0x68>
    putc(fd, buf[i]);
}
    3a17:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a1a:	5b                   	pop    %ebx
    3a1b:	5e                   	pop    %esi
    3a1c:	5f                   	pop    %edi
    3a1d:	5d                   	pop    %ebp
    3a1e:	c3                   	ret    
    3a1f:	90                   	nop
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3a20:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3a22:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3a29:	eb 8b                	jmp    39b6 <printint+0x26>
    3a2b:	90                   	nop
    3a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003a30 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3a30:	55                   	push   %ebp
    3a31:	89 e5                	mov    %esp,%ebp
    3a33:	57                   	push   %edi
    3a34:	56                   	push   %esi
    3a35:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a36:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3a39:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3a3f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a42:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a45:	0f b6 1e             	movzbl (%esi),%ebx
    3a48:	83 c6 01             	add    $0x1,%esi
    3a4b:	84 db                	test   %bl,%bl
    3a4d:	0f 84 b0 00 00 00    	je     3b03 <printf+0xd3>
    3a53:	31 d2                	xor    %edx,%edx
    3a55:	eb 39                	jmp    3a90 <printf+0x60>
    3a57:	89 f6                	mov    %esi,%esi
    3a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3a60:	83 f8 25             	cmp    $0x25,%eax
    3a63:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    3a66:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3a6b:	74 18                	je     3a85 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a6d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3a70:	83 ec 04             	sub    $0x4,%esp
    3a73:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    3a76:	6a 01                	push   $0x1
    3a78:	50                   	push   %eax
    3a79:	57                   	push   %edi
    3a7a:	e8 63 fe ff ff       	call   38e2 <write>
    3a7f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3a82:	83 c4 10             	add    $0x10,%esp
    3a85:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a88:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3a8c:	84 db                	test   %bl,%bl
    3a8e:	74 73                	je     3b03 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    3a90:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    3a92:	0f be cb             	movsbl %bl,%ecx
    3a95:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a98:	74 c6                	je     3a60 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a9a:	83 fa 25             	cmp    $0x25,%edx
    3a9d:	75 e6                	jne    3a85 <printf+0x55>
      if(c == 'd'){
    3a9f:	83 f8 64             	cmp    $0x64,%eax
    3aa2:	0f 84 f8 00 00 00    	je     3ba0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3aa8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3aae:	83 f9 70             	cmp    $0x70,%ecx
    3ab1:	74 5d                	je     3b10 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3ab3:	83 f8 73             	cmp    $0x73,%eax
    3ab6:	0f 84 84 00 00 00    	je     3b40 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3abc:	83 f8 63             	cmp    $0x63,%eax
    3abf:	0f 84 ea 00 00 00    	je     3baf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3ac5:	83 f8 25             	cmp    $0x25,%eax
    3ac8:	0f 84 c2 00 00 00    	je     3b90 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ace:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3ad1:	83 ec 04             	sub    $0x4,%esp
    3ad4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3ad8:	6a 01                	push   $0x1
    3ada:	50                   	push   %eax
    3adb:	57                   	push   %edi
    3adc:	e8 01 fe ff ff       	call   38e2 <write>
    3ae1:	83 c4 0c             	add    $0xc,%esp
    3ae4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3ae7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3aea:	6a 01                	push   $0x1
    3aec:	50                   	push   %eax
    3aed:	57                   	push   %edi
    3aee:	83 c6 01             	add    $0x1,%esi
    3af1:	e8 ec fd ff ff       	call   38e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3af6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3afa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3afd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3aff:	84 db                	test   %bl,%bl
    3b01:	75 8d                	jne    3a90 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3b03:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b06:	5b                   	pop    %ebx
    3b07:	5e                   	pop    %esi
    3b08:	5f                   	pop    %edi
    3b09:	5d                   	pop    %ebp
    3b0a:	c3                   	ret    
    3b0b:	90                   	nop
    3b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3b10:	83 ec 0c             	sub    $0xc,%esp
    3b13:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b18:	6a 00                	push   $0x0
    3b1a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3b1d:	89 f8                	mov    %edi,%eax
    3b1f:	8b 13                	mov    (%ebx),%edx
    3b21:	e8 6a fe ff ff       	call   3990 <printint>
        ap++;
    3b26:	89 d8                	mov    %ebx,%eax
    3b28:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b2b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    3b2d:	83 c0 04             	add    $0x4,%eax
    3b30:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3b33:	e9 4d ff ff ff       	jmp    3a85 <printf+0x55>
    3b38:	90                   	nop
    3b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    3b40:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b43:	8b 18                	mov    (%eax),%ebx
        ap++;
    3b45:	83 c0 04             	add    $0x4,%eax
    3b48:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3b4b:	85 db                	test   %ebx,%ebx
    3b4d:	74 7c                	je     3bcb <printf+0x19b>
          s = "(null)";
        while(*s != 0){
    3b4f:	0f b6 03             	movzbl (%ebx),%eax
    3b52:	84 c0                	test   %al,%al
    3b54:	74 29                	je     3b7f <printf+0x14f>
    3b56:	8d 76 00             	lea    0x0(%esi),%esi
    3b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3b60:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b63:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    3b66:	83 ec 04             	sub    $0x4,%esp
    3b69:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3b6b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b6e:	50                   	push   %eax
    3b6f:	57                   	push   %edi
    3b70:	e8 6d fd ff ff       	call   38e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3b75:	0f b6 03             	movzbl (%ebx),%eax
    3b78:	83 c4 10             	add    $0x10,%esp
    3b7b:	84 c0                	test   %al,%al
    3b7d:	75 e1                	jne    3b60 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b7f:	31 d2                	xor    %edx,%edx
    3b81:	e9 ff fe ff ff       	jmp    3a85 <printf+0x55>
    3b86:	8d 76 00             	lea    0x0(%esi),%esi
    3b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b90:	83 ec 04             	sub    $0x4,%esp
    3b93:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3b96:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3b99:	6a 01                	push   $0x1
    3b9b:	e9 4c ff ff ff       	jmp    3aec <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3ba0:	83 ec 0c             	sub    $0xc,%esp
    3ba3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3ba8:	6a 01                	push   $0x1
    3baa:	e9 6b ff ff ff       	jmp    3b1a <printf+0xea>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3baf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bb2:	83 ec 04             	sub    $0x4,%esp
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3bb5:	8b 03                	mov    (%ebx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bb7:	6a 01                	push   $0x1
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3bb9:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bbc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3bbf:	50                   	push   %eax
    3bc0:	57                   	push   %edi
    3bc1:	e8 1c fd ff ff       	call   38e2 <write>
    3bc6:	e9 5b ff ff ff       	jmp    3b26 <printf+0xf6>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3bcb:	b8 28 00 00 00       	mov    $0x28,%eax
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
    3bd0:	bb e8 54 00 00       	mov    $0x54e8,%ebx
    3bd5:	eb 89                	jmp    3b60 <printf+0x130>
    3bd7:	66 90                	xchg   %ax,%ax
    3bd9:	66 90                	xchg   %ax,%ax
    3bdb:	66 90                	xchg   %ax,%ax
    3bdd:	66 90                	xchg   %ax,%ax
    3bdf:	90                   	nop

00003be0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3be0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3be1:	a1 80 5e 00 00       	mov    0x5e80,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    3be6:	89 e5                	mov    %esp,%ebp
    3be8:	57                   	push   %edi
    3be9:	56                   	push   %esi
    3bea:	53                   	push   %ebx
    3beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3bf0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bf3:	39 c8                	cmp    %ecx,%eax
    3bf5:	73 19                	jae    3c10 <free+0x30>
    3bf7:	89 f6                	mov    %esi,%esi
    3bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3c00:	39 d1                	cmp    %edx,%ecx
    3c02:	72 1c                	jb     3c20 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c04:	39 d0                	cmp    %edx,%eax
    3c06:	73 18                	jae    3c20 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c08:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c0a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c0c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c0e:	72 f0                	jb     3c00 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c10:	39 d0                	cmp    %edx,%eax
    3c12:	72 f4                	jb     3c08 <free+0x28>
    3c14:	39 d1                	cmp    %edx,%ecx
    3c16:	73 f0                	jae    3c08 <free+0x28>
    3c18:	90                   	nop
    3c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c20:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c26:	39 fa                	cmp    %edi,%edx
    3c28:	74 19                	je     3c43 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3c2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c2d:	8b 50 04             	mov    0x4(%eax),%edx
    3c30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c33:	39 f1                	cmp    %esi,%ecx
    3c35:	74 23                	je     3c5a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3c37:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3c39:	a3 80 5e 00 00       	mov    %eax,0x5e80
}
    3c3e:	5b                   	pop    %ebx
    3c3f:	5e                   	pop    %esi
    3c40:	5f                   	pop    %edi
    3c41:	5d                   	pop    %ebp
    3c42:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3c43:	03 72 04             	add    0x4(%edx),%esi
    3c46:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c49:	8b 10                	mov    (%eax),%edx
    3c4b:	8b 12                	mov    (%edx),%edx
    3c4d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3c50:	8b 50 04             	mov    0x4(%eax),%edx
    3c53:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c56:	39 f1                	cmp    %esi,%ecx
    3c58:	75 dd                	jne    3c37 <free+0x57>
    p->s.size += bp->s.size;
    3c5a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    3c5d:	a3 80 5e 00 00       	mov    %eax,0x5e80
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3c62:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3c65:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c68:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3c6a:	5b                   	pop    %ebx
    3c6b:	5e                   	pop    %esi
    3c6c:	5f                   	pop    %edi
    3c6d:	5d                   	pop    %ebp
    3c6e:	c3                   	ret    
    3c6f:	90                   	nop

00003c70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c70:	55                   	push   %ebp
    3c71:	89 e5                	mov    %esp,%ebp
    3c73:	57                   	push   %edi
    3c74:	56                   	push   %esi
    3c75:	53                   	push   %ebx
    3c76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c7c:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c82:	8d 78 07             	lea    0x7(%eax),%edi
    3c85:	c1 ef 03             	shr    $0x3,%edi
    3c88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3c8b:	85 d2                	test   %edx,%edx
    3c8d:	0f 84 93 00 00 00    	je     3d26 <malloc+0xb6>
    3c93:	8b 02                	mov    (%edx),%eax
    3c95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3c98:	39 cf                	cmp    %ecx,%edi
    3c9a:	76 64                	jbe    3d00 <malloc+0x90>
    3c9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3ca2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3ca7:	0f 43 df             	cmovae %edi,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    3caa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3cb1:	eb 0e                	jmp    3cc1 <malloc+0x51>
    3cb3:	90                   	nop
    3cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3cb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3cba:	8b 48 04             	mov    0x4(%eax),%ecx
    3cbd:	39 cf                	cmp    %ecx,%edi
    3cbf:	76 3f                	jbe    3d00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3cc1:	39 05 80 5e 00 00    	cmp    %eax,0x5e80
    3cc7:	89 c2                	mov    %eax,%edx
    3cc9:	75 ed                	jne    3cb8 <malloc+0x48>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    3ccb:	83 ec 0c             	sub    $0xc,%esp
    3cce:	56                   	push   %esi
    3ccf:	e8 8e fc ff ff       	call   3962 <sbrk>
  if(p == (char*)-1)
    3cd4:	83 c4 10             	add    $0x10,%esp
    3cd7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cda:	74 1c                	je     3cf8 <malloc+0x88>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3cdc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3cdf:	83 ec 0c             	sub    $0xc,%esp
    3ce2:	83 c0 08             	add    $0x8,%eax
    3ce5:	50                   	push   %eax
    3ce6:	e8 f5 fe ff ff       	call   3be0 <free>
  return freep;
    3ceb:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3cf1:	83 c4 10             	add    $0x10,%esp
    3cf4:	85 d2                	test   %edx,%edx
    3cf6:	75 c0                	jne    3cb8 <malloc+0x48>
        return 0;
    3cf8:	31 c0                	xor    %eax,%eax
    3cfa:	eb 1c                	jmp    3d18 <malloc+0xa8>
    3cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3d00:	39 cf                	cmp    %ecx,%edi
    3d02:	74 1c                	je     3d20 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3d04:	29 f9                	sub    %edi,%ecx
    3d06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3d09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3d0c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    3d0f:	89 15 80 5e 00 00    	mov    %edx,0x5e80
      return (void*)(p + 1);
    3d15:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3d18:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d1b:	5b                   	pop    %ebx
    3d1c:	5e                   	pop    %esi
    3d1d:	5f                   	pop    %edi
    3d1e:	5d                   	pop    %ebp
    3d1f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3d20:	8b 08                	mov    (%eax),%ecx
    3d22:	89 0a                	mov    %ecx,(%edx)
    3d24:	eb e9                	jmp    3d0f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3d26:	c7 05 80 5e 00 00 84 	movl   $0x5e84,0x5e80
    3d2d:	5e 00 00 
    3d30:	c7 05 84 5e 00 00 84 	movl   $0x5e84,0x5e84
    3d37:	5e 00 00 
    base.s.size = 0;
    3d3a:	b8 84 5e 00 00       	mov    $0x5e84,%eax
    3d3f:	c7 05 88 5e 00 00 00 	movl   $0x0,0x5e88
    3d46:	00 00 00 
    3d49:	e9 4e ff ff ff       	jmp    3c9c <malloc+0x2c>
