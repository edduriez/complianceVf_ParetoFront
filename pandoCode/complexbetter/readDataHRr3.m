clear all
density=0.01:0.0001:1;
density=density';
m=size(density,1);
complfilename=['complHRr3.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,9901)';
c1=compliance(:,2);

complfilename=['complHRr3initdes6.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,9899)';
c2=compliance(:,1);
c2=[c1(1);c2;c1(end)];


complfilename=['complHRr3initdes5.txt'];
complfileID=fopen(complfilename);
compliance=textscan(complfileID,'%24.10f');
compliance=reshape(compliance{1,1},5,9899)';
c0=compliance(:,1);
c0=[c1(1);c0;c1(end)];
% c3=compliance(:,2);
% c3=[c1(1);c3;c1(end)];
% c4=compliance(:,4);
% c4=[c1(1);c4;c1(end)];


%allmin=min(c1,c2);

fclose('all')

figure(1)
plot(density,c1)
% figure(2)
% plot(density,c2)
% figure(3)
% plot(density,c1-c2)

% figure(11)
% plot(density,c3)
% figure(12)
% plot(density,c4)
% figure(13)
% plot(density,(c3-c4)./(c3+c4))
% 
figure(4)
plot(density,c1)
hold on
plot(density,c2)
% hold on
% plot(density,c3)
% hold on
% plot(density,c4)
%legend('11initdes','11initdes+backfront','locmins','loccon')
legend('11initdes','11initdes+backfront')
hold off


%max(density-v0)
%max(density-v1)
%max(density-v2)
%volfrac times compliance
optim1=density.*c1;
optim2=density.*c2;
optim0=density.*c0;
figure(5)
plot(density,optim1)
figure(6)
plot(density,optim2)
xlabel('volume fraction (V_f)');
ylabel('V_f * f(V_f)');
figure(8)
plot(density,optim1)
hold on
plot(density,optim2)
%xlim([0.16 0.22])
legend('11initdes','11initdes+backfront')
hold off

figure(9)
plot(density,optim1)
hold on
plot(density,optim2)
hold on
plot(density,optim0)
%xlim([0.16 0.22])
legend('11initdes','11initdes+2backfront','11initdes+backfront')
hold off


figure(18)
plot(density,optim2)
hold on
plot(density,optimallmin)
hold off
legend('backfront','min old and backfront')

%c=vf^n
%filter first
oFilt10P1 = filter((1/10)*ones(1,10),1,optimP1);
% %gauss filter
% n=11 %number of points
% sig=n/8
% xgauss=0:1:n-1
% ygauss=1/(sig*sqrt(2*pi))*exp(-0.5*(xgauss-(n-1)/2).^2./sig^2);
% oFiltGaussP1 = conv(optimP1,ygauss);
figure(9)
plot(density,oFilt10P1)
% figure(10)
% plot(density,oFiltGaussP1(1:end-10))

window=[3,10,30,100,300,1000];
%window=[10,100,1000];
n=size(window,2)
for i=1:n
    %cP1=c01;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    win=window(i);
    hwin=round(win/2);
    cFilt=filter((1/win)*ones(1,win),1,cP1);
    cFilt=cFilt(win:end);
    densT=density(hwin:end-(win-hwin));
    npower=(cFilt(2:end)-cFilt(1:end-1))./(densT(2)-densT(1)).*densT(1:end-1)./cFilt(1:end-1);
    figure(20+i)
    plot(densT(1:end-1),npower)
    %figure(30+i)
    %plot(densT,cFilt)
    xgauss=0:1:win-1;
    sig=win/8;
    ygauss=1/(sig*sqrt(2*pi))*exp(-0.5*(xgauss-(win-1)/2).^2./sig^2);
    cFiltG=conv(cP1,ygauss);
    cFiltGT=cFiltG(win:end-win);
    densTG=density(hwin+1:end-win+hwin);
    %figure(40+i)
    %plot(densTG,cFiltGT)
    npowerG=(cFiltGT(2:end)-cFiltGT(1:end-1))./(densTG(2)-densTG(1)).*densTG(1:end-1)./cFiltGT(1:end-1);
    figure(50+i)
    plot(densTG(1:end-1),-npowerG)
    hold on  %superimpose
    nanal1=(3*densTG.^3-15*densTG.^2+24*densTG-24)./((4*densTG.^2-12*densTG+12).*(densTG-2));
    plot(densTG(1:end-1),nanal1(1:end-1)) %superimpose
    nanal2=(3-6*densTG+3*densTG.^2)./(3-3*densTG+densTG.^2);
    plot(densTG(1:end-1),nanal2(1:end-1)) %superimpose
    nanal3=(2*densTG-2)./(densTG-2);  %superimpose
    plot(densTG(1:end-1),nanal3(1:end-1)) %superimpose
    nanal4=5/3*densTG.*(1-densTG)./((1-densTG).^(1/3)-(1-densTG).^2);
    plot(densTG(1:end-1),nanal4(1:end-1)) %superimpose
    hold off %superimpose
    ylim([0 2]);
    xlabel('density')
    ylabel('n')
    legend('numerical','1st model','2nd model','3rd model','4th model')
    
    figure(60+i)
    plot(densTG,cFiltGT.*densTG)
    xlabel('volume fraction(V_f)')
    ylabel('V_f \times f(V_f)')
end



fclose('all')