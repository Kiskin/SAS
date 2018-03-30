
*Bonus question on the titanic.
We include the data used (both the .csv file and the .sas dataset created) in the submission folder. 
;
Title1 'Titanic Bonus Question';
libname learn 'C:\445_695\Course_data';
proc import datafile ='C:\445_695\Course_data\titanic'
DBMS = xlsx
out=learn.Titanic replace;
Run;
*Print and observe dataset;
proc print data=learn.Titanic;
run;

proc format;
value Sex 0='Female'
		  1 ='Male';
value Pclass 1='First Class'
			 2='Second Class'
			 3='Third Class';
value _2urvived 0='Died'
				1='Survived';

Title2 'Frequency Count: Gender x Passenger class x Survival rate';
*Label statement doesn't seem to work within the proc freq statement?;
proc freq data=learn.Titanic;

	table Sex*Pclass*_2urvived;
	format Sex Sex. Pclass Pclass. _2urvived _2urvived. ;
	label Pclass ='Passenger Class'
		  _2urvived = 'Survival'
		  Sex ='Gender';
	format Sex Sex. Pclass Pclass. _2urvived _2urvived.;	

Run;

Title;
*b;
Title2 'Frequency Count: Passenger class x Survival rate';
*Label statement doesn't seem to work within the proc freq statement?;
proc freq data=learn.Titanic;

	table Pclass*_2urvived;
	format  Pclass Pclass. _2urvived _2urvived. ;
	label Pclass ='Passenger Class'
		  _2urvived = 'Survival'
		  Sex ='Gender';
	format Pclass Pclass. _2urvived _2urvived.;	

Run;

Title;

*
LIFT of survival per passenger class.
Definition: Lift= Prob(Survived and A)/[Prob(A)*Prob(Survived)]. 

a. Lift of survival in first class:
		Lift= Prob(Survived and First class)/[Prob(First class)*Prob(Survived)]. 
		 From frequency table above: 
		p(survived|FirstClass) = 0.104
		P(survived) =0.261
		P(FirstClass) = 0.247
		Therefore LIFT = (0.104)/(0.247)*(0.261) = 1.61

 Lift of survival in second class:
		Lift= Prob(Survived and second class)/[Prob(second class)*Prob(Survived)]. 
		 From frequency table above: 
		p(survived|SecondClass) = 0.065
		P(survived) =0.261
		P(SecondClass) = 0.212
		Therefore LIFT = (0.065)/(0.212)*(0.261) = 1.20

 Lift of survival in third class:
		Lift= Prob(Survived and third class)/[Prob(third class)*Prob(Survived)]. 
		 From frequency table above: 
		p(survived|ThirdClass) = 0.091
		P(survived) =0.261
		P(ThirdClass) = 0.542
		Therefore LIFT = (0.091)/(0.542)*(0.261) = 0.64.


Explanation: The chances of survival increases as one moves from third class passenger category to first class.
In the first class, one had a 61% chance of surviving, in the second class the chances of survival fell down to 20%.
In the third class, the chance of survival fell to -37%!

Proc freq options:
NLEVELS : Gives a break down levels for a given variable. 
misprint
missing

;
* d;
proc freq data=learn.Titanic MISSING;

	table Pclass*_2urvived;
	format  Pclass Pclass. _2urvived _2urvived. ;
	label Pclass ='Passenger Class'
		  _2urvived = 'Survival'
		  Sex ='Gender';
	format Pclass Pclass. _2urvived _2urvived.;	

Run;


Title 'A Histogram of survivors';
*Create a data set of the ages of survivals;
	data SurvivalByAge;
		set learn.Titanic;
			where( _2urvived=1);
			Keep =Age;
		Run;
* e
	Draw a bar chart of those who survived by age;		
	proc gchart data=SurvivalByAge;
		vbar Age /;
		format Sex Sex.;
	run;
* The majprity of survivors where 32 years of age, followed by those about 24 years old;
