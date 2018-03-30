libname learn 'C:\445_695\Course_data';
proc means data=learn.fitness noprint;
	var TimeMile RestPulse MaxPulse;
	output out=work.fitness mean= M_TimeMile M_RestPulse M_MaxPulse;
run;

data _null_;
	set work.fitness;
	call symput('TimeM',M_TimeMile );
	call symput('RestP',M_RestPulse);
	call symput('MaxP',M_MaxPulse);
run;
data NewFitness;
	set work.fitness;
	P_TimeMile  = TimeMile/&TimeM;
	P_RestPulse = RestPulse/&RestP;
	P_MaxPulse  = MaxPulse/&MaxP;
	format P_TimeMile P_RestPulse P_MaxPulse percent8.;
	*keep  P_TimeMile P_RestPulse P_MaxPulse; 
run;

proc print data=NewFitness;
run;
