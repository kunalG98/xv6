#ifndef _PSTAT_H_
#define _PSTAT_H_

#include "param.h"

struct pstat{

int inuse[NPROC];
	int pid[NPROC];
	char name[NPROC][16];
	int hticks[NPROC];
	int lticks[NPROC];
};

#endif
