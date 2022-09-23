parpool('local',24)
density=0.01:0.0001:1;
m=size(density,2);
debugID=fopen('wrong');
cases=textscan(debugID,'%24.10f');
cases=reshape(cases{1,1},1,70)';

parfor i =1:70
    j=cases(i);
    locfilename=['pointHRr3',num2str(j)];
    j
    [v0,c1,v1,c2,v2]=mainTop88r3(200,100,density(j));
    locfileID=fopen(locfilename,'w');
    fprintf(locfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',v0,c1,v1,c2,v2);
end
    
fclose('all');


