#include <stdio.h>
#include <stdlib.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include "mcp3004.h"

#define BASE 100

int main(int type){

int e1;
int e2;
int e3;
int e4;
int l1;
int l2;
int l3;
int avr;
int avl;
int avf;
int i;
int time;
if (type == 1){
	time = 2500;

}
	FILE *fpoint;
	fpoint=fopen("ekg.csv","w");
	fprintf(fpoint,"Lead 1,Lead 2,Lead 3,aVR,aVL,aVF\n");

	wiringPiSetup();
	mcp3004Setup (BASE,0);

	for(i=0;i<2500;i++){
		e1=analogRead (BASE);
		e2=analogRead (BASE+1);
	//	e3=analogRead (BASE+2);
		e4=analogRead(BASE+3);

		l1=e1-e2;
		l2=e1-e4;
		l3=e2-e4;
	//	avr=e3-e1;
	//	avl=e3-e2;
	//	avf=e3-e4;

		fprintf(fpoint,"%d,%d,%d\n",l1,l2,l3);//add last leads

		delay(8);
	}
return 0;
}
