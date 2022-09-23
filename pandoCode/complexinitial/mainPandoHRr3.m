parpool('local',24)
density=0.01:0.0001:1;
m=size(density,2);
parfor j =1:m
    locfilename=['pointHRr3',num2str(j)];
    if ~isfile(locfilename)
        j
        [v0,c1,v1,c2,v2]=mainTop88r3(200,100,density(j));
        locfileID=fopen(locfilename,'w');
        fprintf(locfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',v0,c1,v1,c2,v2);
    end
end
    
fclose('all');


