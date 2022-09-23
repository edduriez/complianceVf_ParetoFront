parpool('local',24)
density=0.01:0.0001:1;
m=size(density,2);
prob='bridge'
complfilename=['complHRr3.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,m)';
c0=compliance(:,2);
complfilename=['complHRr3initdes7.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,m-2)';
c2=compliance(:,1);
c2=[c0(1);c2;c0(end)];
complfilename=['complHRr3initdes8.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,m-2)';
c1=compliance(:,1);
c1=[c0(1);c1;c0(end)];
minToNow=10e9;
minToNowold=10e9;
locmins=[];
locminsold=[];
locminC=[];
loccon=[];
locconold=[];
locconC=[];
regN=10;
regmins=zeros(1,10);
regminsold=zeros(1,10);
for i=1:regN
    regspace=round(m/regN);
    [regminC,regmini]=min(density(regspace*(i-1)+1:regspace*i)'.*c1(regspace*(i-1)+1:regspace*i));
    regmins(i)=regmini+regspace*(i-1);
    [regminC,regmini]=min(density(regspace*(i-1)+1:regspace*i)'.*c2(regspace*(i-1)+1:regspace*i));
    regminsold(i)=regmini+regspace*(i-1);
end
for i=1:m-1
    if c1(i)<minToNow && c1(i)<0.998*c1(i+1)
        locmins=[locmins i];
        locminC=[locminC c1(i)];
        minToNow=c1(i);
    end
    if c2(i)<minToNowold && c2(i)<0.998*c2(i+1)
        locminsold=[locminsold i];
        minToNowold=c2(i);
    end
end
for i=4:m
    dif1=c1(i)-c1(i-1);
    dif2=c1(i-1)-c1(i-2);
    dif3=c1(i-2)-c1(i-3);
%    if 5*dif2>dif1 %locally concave
%    if dif2<0 && 5*dif2>dif1 %locally concave
    if dif3<0 && dif2<0 && 4*(dif2+dif3)/2>dif1  && c1(i)<0.998*c1(i-1) %locally highly concave
        loccon=[loccon i];
        locconC=[locconC c1(i)];
    end
    
    dif1old=c2(i)-c2(i-1);
    dif2old=c2(i-1)-c2(i-2);
    dif3old=c2(i-2)-c2(i-3);
%    if 5*dif2>dif1 %locally concave
%    if dif2<0 && 5*dif2>dif1 %locally concave
    if dif3old<0 && dif2old<0 && 4*(dif2old+dif3old)/2>dif1old  && c2(i)<0.998*c2(i-1) %locally highly concave
        locconold=[locconold i];
    end
end
impPts=union(loccon,union(locmins,regmins));
impPts=[1 impPts m];
locmins=[1 locmins];
loccon=[loccon m];

impPtsold=union(locconold,union(locminsold,regminsold));
impPtsold=[1 impPtsold m];
locminsold=[1 locminsold];
locconold=[locconold m];

debug=2000
%for i=2:size(impPts,2)
parfor i=1:size(impPts,2)
    i
    if i==1 || i==size(impPts,2)
        [v1,c2,v2,c3,v3,design5]=mainTop88allinit(200,100,density(impPts(i)),prob);
    else
        j=impPts(i);
        %%%
        %find closest local min with lower dens
        locmindifold=locminsold-j;
        closestLocMinold=find(locmindifold<0,1,'last');
        num2str(locminsold(closestLocMinold))
        desfilenameold=['initdes',num2str(locminsold(closestLocMinold))]
        desfileIDold=fopen(desfilenameold);
        designold=textscan(desfileIDold,'%24.10f');
        initdes1old=reshape(designold{1,1},100,200);
        [c1,v1,design1]=mainTop88oneinit(200,100,density(j),initdes1old,prob);


        %find closest local concave
        loccondifold=locconold-j;
        closestLocconold=find(loccondifold>0,1);
        num2str(locconold(closestLocconold))
        desfilenameold=['initdes',num2str(locconold(closestLocconold))]
        desfileIDold=fopen(desfilenameold);
        designold=textscan(desfileIDold,'%24.10f');
        initdes2old=reshape(designold{1,1},100,200);
        [c2,v2,design2]=mainTop88oneinit(200,100,density(j),initdes2old,prob);
        
        %regmin 
        regidx=floor(j/m*regN)+1;
        desfilename3=['initdes',num2str(regminsold(regidx))];
        desfileID3=fopen(desfilename3);
        design3=textscan(desfileID3,'%24.10f');
        initdes3=reshape(design3{1,1},100,200);
        [c3,v3,design3]=mainTop88oneinit(200,100,density(j),initdes3,prob);
        
        
        comp=[c1,c2,c3];
        vf=[v1,v2,v3];
        des=[design1;design2;design3];
        [c5,mini]=min(comp);
        vf5=vf(mini);
        design5=des(mini,:);
    end
    locfilename=['initdes2_',num2str(impPts(i))];
    locfileID=fopen(locfilename,'w');
    fprintf(locfileID,'%14.10f',design5(:));
end
%%%
%test following 
    
% parfor j =1:m
%     %find closest local min with lower dens
%     locmindif=locmins-j;
%     closestLocMin=find(locmindif<0,1,'last');
%     desfilename=['initdes',num2str(locmins(closestLocMin))];
%     desfileID=fopen(desfilename);
%     design=textscan(desfileID,'%24.10f');
%     initdes1=reshape(design{1,1},100,200);
%     [c1,v1]=mainTop88initdes(200,100,density(j),initdes1);
%     
%     
%     %find closest local concave
%     loccondif=loccon-j;
%     closestLoccon=find(loccondif>0,1);
%     desfilename=['initdes',num2str(loccon(closestLoccon))];
%     desfileID=fopen(desfilename);
%     design=textscan(desfileID,'%24.10f');
%     initdes2=reshape(design{1,1},100,200);
%     [c2,v2]=mainTop88initdes(200,100,density(j),initdes2);
% 
%     comp=[c1,c2];
%     vf=[v1,v2];
%     [c3,mini]=min(comp);
%     vf3=vf(mini);
%     locfilename=['pointHRr3initdes',num2str(j)];
%     locfileID=fopen(locfilename,'w');
%     fprintf(locfileID,'%14.10f %14.10f %14.10f %14.10f %14.10f',c3,c1,v1,c2,v2);
% end
    
fclose('all');


