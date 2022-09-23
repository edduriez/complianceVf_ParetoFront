# complianceVf_ParetoFront
Codes to produce precise c=f(Vf) Pareto fronts with Pando

paretosObtained folder:
all the Paretos (.txt) obtained for bridge, MBB and complex problems.
the compareParetos.m files draws these Paretos 


pandoCode folder :
The codes to obtain the Pareto fronts with 11 initial designs are in the folders "xxxinitial".
To use them, put every file on pando and use command "sbatch --partition=long scriptHRr3.slurm" and, when this first job is finished (very long), "sbatch scriptCHRr3.slurm"
In order to obtain better Pareto fronts still, it is posssible to rebuild the pareto fronts using the best designs of the initial front. This is done using the folders named "xxxbetter". (the .slurm files must be called in the right order). The complHRr3.txt file in these folders come from the folders xxxinitial.

