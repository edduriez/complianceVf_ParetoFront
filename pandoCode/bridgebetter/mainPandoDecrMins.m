parpool('local',24)
density=0.01:0.0001:1;
m=size(density,2);
prob='bridge';
complfilename=['complHRr3.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,m)';
c1=compliance(:,2);
minToNow=10e9;
locmins=[];
locminC=[];
loccon=[];
locconC=[];
regN=10;
regmins=zeros(1,10);
for i=1:regN
    regspace=round(m/regN);
    [regminC,regmini]=min(density(regspace*(i-1)+1:regspace*i)'.*c1(regspace*(i-1)+1:regspace*i));
    regmins(i)=regmini+regspace*(i-1);
end
for i=1:m-1
    if c1(i)<minToNow && c1(i)<0.998*c1(i+1)
        locmins=[locmins i];
        locminC=[locminC c1(i)];
        minToNow=c1(i);
    end
end
for i=4:m
    dif1=c1(i)-c1(i-1);
    dif2=c1(i-1)-c1(i-2);
    dif3=c1(i-2)-c1(i-3);
%    if 5*dif2>dif1 %locally concave
%    if dif2<0 && 5*dif2>dif1 %locally concave
    if dif3<0 && dif2<0 && 4*(dif2+dif3)/2>dif1 && c1(i)<0.998*c1(i-1) %locally highly concave
        loccon=[loccon i];
        locconC=[locconC c1(i)];
    end
end
impPts=union(loccon,union(locmins,regmins));
impPts=[1 impPts m];
locmins=[1 locmins];
loccon=[loccon m];

parfor i=1:size(impPts,2)
    [v1,c2,v2,c3,v3,design]=mainTop88allinit(200,100,density(impPts(i)),prob);
    locfilename=['initdes',num2str(impPts(i))];
    locfileID=fopen(locfilename,'w');
    fprintf(locfileID,'%14.10f',design(:));
end
    
% parfor j =1:m
%     %find closest local min with lower dens
%     locmindif=locmins-j;
%     closestLocMin=find(locmindif<0,1,'last');
%     if c1(j)>=locminC(closestLocMin)
%         initdes=locminDes(closestLocMin,:);
%         initdes=reshape(initdes,100,200);
%         [c1,v1]=mainTop88initdes(200,100,density(j),initdes);
%         locfilename=['pointHRr3initdes',num2str(j)];
%         locfileID=fopen(locfilename,'w');
%         fprintf(locfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',v1,c1,v1,c1,v1);
%     end
% end
    
fclose('all');


