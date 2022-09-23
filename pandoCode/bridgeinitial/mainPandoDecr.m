%%%%%%%%%%%%%%%%parpool('local',24)
density=0.01:0.0001:1;
m=size(density,2);
complfilename=['complHRr3_old.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,m)';
c1=compliance(:,2);
minToNow=10e9;
locmins=[];
locminC=[];
for i=1:m-1
    if c1(i)<minToNow && c1(i)<c1(i+1)
        locmins=[locmins i];
        locminC=[locminC c1(i)];
        minToNow=c1(i);
    end
end
locminDes=[];
for i=1:size(locmins,2)
    design=mainTop88getdes(200,100,density(locmins(i)));
    locminDes=[locminDes;design(:)'];
end
%%%
%test
    
parfor j =1:m
    %find closest local min with lower dens
    locmindif=locmins-j;
    closestLocMin=find(locmindif<0,1,'last');
    if c1(j)>=locminC(closestLocMin)
        initdes=locminDes(closestLocMin,:);
        initdes=reshape(initdes,100,200);
        [c1,v1]=mainTop88initdes(200,100,density(j),initdes);
        locfilename=['pointHRr3initdes',num2str(j)];
        locfileID=fopen(locfilename,'w');
        fprintf(locfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',v1,c1,v1,c1,v1);
    end
end
    
fclose('all');


