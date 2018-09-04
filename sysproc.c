#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "pstat.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int 
sys_shutdown(void)
{
cprintf("Shutdown signal sent\n");
outw(0xB004,0x0 | 0x2000);
return 0;
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_getppid(void)
{
return myproc()-> parent -> pid;
}

struct pstat pstat;
int
sys_getAllPids(void)
{

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
    return -1;
int i;
for(i=0;i< NPROC; i++){
 st -> inuse[i] = pstat.inuse[i];
 st -> pid[i] = pstat.pid[i];
 st -> name[i][0] = pstat.name[i][0];
    st -> name[i][1] = pstat.name[i][1];
        st -> name[i][2] = pstat.name[i][2];
 st -> hticks[i]= pstat.hticks[i];
 st -> lticks[i]= pstat.lticks[i];
}
return 0;

}


int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_cps(void)
{
  return cps ();
}
