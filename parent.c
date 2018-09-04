#include "types.h"
#include "user.h"

int main(void)
{
int ChildPid=fork();
if(ChildPid<0)
	printf(1,"Fork failed %d\n",ChildPid);
else if (ChildPid >0)
{
	printf(1,"I am the parent.My pid is %d, Child id is %d\n",getpid(),ChildPid);
	wait();
}
else
{
	printf(1,"I am the child.My pid is %d, My parent id is %d\n",getpid(),getppid());
}
exit();
}
