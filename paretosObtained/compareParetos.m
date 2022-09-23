clear all
density=0.01:0.0001:1;
density=density';
m=size(density,1);

filenames=[{'MBB200100r3mono.txt'};{'MBB200100r3multi4.txt'};{'MBB200100r3multi11.txt'}];
filecolumn=[2;2;2];
fileline=[m;m;m];
for i =1:5
    filename=['MBB200100r3multi11bf' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;2];
    fileline=[fileline;m-2];
end
for i =1:5
    filename=['MBB200100r3multi11bfce' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:9
    filename=['MBB200100r3multi11bfcep' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:6
    filename=['MBB200100r3multi11bfcepr' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end


nf=size(filenames,1);

ccc=10^9*ones(m,nf,3);

for i=1:nf
    i
    filename=filenames(i);
    filename=char(filename);
    fileID=fopen(filename);
    compl=textscan(fileID,'%24.10f');
    col=5;
    if i==1
        col=3;
    end
    compl=reshape(compl{1,1},col,fileline(i))';
    ccctemp=compl(:,filecolumn(i));
    if i>3
        ccctemp=[ccc(1,3,1);ccctemp;ccc(m,3,1)];
    end
    ccc(:,i,1)=ccctemp;
    fclose(fileID);
end


%filenames=[{'MBB200100r3mono.txt'};{'MBB200100r3multi4.txt'};{'MBB200100r3multi11.txt'}];
%filecolumn=[2;2;2];
%fileline=[m;m;m];
filenames=[{'bridge200100r3multi11ce.txt'}];
filecolumn=[2];
fileline=[m];
% for i =1:5
%     filename=['MBB200100r3multi11bf' num2str(i) '.txt'];
%     filename={filename};
%     filenames=[filenames; filename];
%     filecolumn=[filecolumn;2];
%     fileline=[fileline;m-2];
% end
for i =1:5
    filename=['bridge200100r3multi11bfce' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:9
    filename=['bridge200100r3multi11bfcep' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:6
    filename=['bridge200100r3multi11bfcepr' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end


nf=size(filenames,1);


for i=1:nf
    i
    filename=filenames(i);
    filename=char(filename);
    fileID=fopen(filename);
    compl=textscan(fileID,'%24.10f');
    col=5;
%     if i==1
%         col=3;
%     end
    compl=reshape(compl{1,1},col,fileline(i))';
    ccctemp=compl(:,filecolumn(i));
    if i>1
        ccctemp=[ccc(1,3,2);ccctemp;ccc(m,3,2)];
    end
    ccc(:,i,2)=ccctemp;
    fclose(fileID);
end

%filenames=[{'MBB200100r3mono.txt'};{'MBB200100r3multi4.txt'};{'MBB200100r3multi11.txt'}];
%filecolumn=[2;2;2];
%fileline=[m;m;m];
filenames=[{'complex200100r3multi11ce.txt'}];
filecolumn=[2];
fileline=[m];
% for i =1:5
%     filename=['MBB200100r3multi11bf' num2str(i) '.txt'];
%     filename={filename};
%     filenames=[filenames; filename];
%     filecolumn=[filecolumn;2];
%     fileline=[fileline;m-2];
% end
for i =1:5
    filename=['complex200100r3multi11bfce' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:9
    filename=['complex200100r3multi11bfcep' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end
for i =1:6
    filename=['complex200100r3multi11bfcepr' num2str(i) '.txt'];
    filename={filename};
    filenames=[filenames; filename];
    filecolumn=[filecolumn;1];
    fileline=[fileline;m-2];
end


nf=size(filenames,1);


for i=1:nf
    i
    filename=filenames(i);
    filename=char(filename);
    fileID=fopen(filename);
    compl=textscan(fileID,'%24.10f');
    col=5;
%     if i==1
%         col=3;
%     end
    compl=reshape(compl{1,1},col,fileline(i))';
    ccctemp=compl(:,filecolumn(i));
    if i>1
        ccctemp=[ccc(1,3,3);ccctemp;ccc(m,3,3)];
    end
    ccc(:,i,3)=ccctemp;
    fclose(fileID);
end




reference=min(ccc(2:end-1,:,:),[],2);

%error=(ccc(2:end-1,:)-reference)./reference;

%maxerrors=max(error);
%meanerror=mean(error);

figure(1)
plot(density(2:end-1), reference(:,1,1)./reference(end,1,1))
hold on
plot(density(2:end-1), reference(:,1,2)./reference(end,1,2))
hold on
plot(density(2:end-1), reference(:,1,3)./reference(end,1,3))
hold off

figure(2)
plot(density(2:end-1), reference(:,1,1)./reference(end,1,1).*density(2:end-1))
hold on
plot(density(2:end-1), reference(:,1,2)./reference(end,1,2).*density(2:end-1))
hold on
plot(density(2:end-1), reference(:,1,3)./reference(end,1,3).*density(2:end-1))
hold off

% maxerror=2*ones(9000,3);
% maxerror01=2*ones(9000,3);
% for i=1:3
%     for di=1:9000
%         %metamodel 1
%         nlow=0.01;
%         nup=100;
%         %di=4950 % density coordinate of intersection between data and model
%         %di=3000 % density coordinate of intersection between data and model
%         %data=reference(:,1,i);
%         data=ccc(2:end-1,1,i);
%         if i==1
%             data=ccc(2:end-1,3,i);
%         end
%         datadi=data(di);
%         while nup-nlow>0.01
%             n=(nup+nlow)/2;
%             model=1./density(2:end-1).*exp((density(2:end-1).^n)./n);
%             aaa=data(end)/model(end);
%             modelAdjusted=aaa*model;
%             modeldi=modelAdjusted(di);
%             if modeldi > datadi
%                 nup=n;
%             else
%                 nlow=n;
%             end
%         end
%         error=(modelAdjusted-data)./data;
%         maxerror(di,i)=max(abs(error));
%         maxerror01(di,i)=max(abs(error(1000:end)));
%     end
% end
% n
% % figure(311)
% % plot(density(2:9001),maxerror(:,1))
% % figure(312)
% % plot(density(2:9001),maxerror01(:,1))
% % figure(411)
% % plot(density(2:9001),maxerror(:,2))
% % figure(412)
% % plot(density(2:9001),maxerror01(:,2))
% % figure(511)
% % plot(density(2:9001),maxerror(:,3))
% % figure(512)
% % plot(density(2:9001),maxerror01(:,3))
% 
% figure(3)
% plot(density(2:9001),maxerror(:,1))
% hold on
% plot(density(2:9001),maxerror(:,2))
% hold on
% plot(density(2:9001),maxerror(:,3))
% hold off
% 
% figure(4)
% plot(density(2:9001),maxerror01(:,1))
% hold on
% plot(density(2:9001),maxerror01(:,2))
% hold on
% plot(density(2:9001),maxerror01(:,3))
% hold off


% %metamodel 2
% maxerror=2*ones(9000,3);
% maxerror01=2*ones(9000,3);
% for i=1:3
%     for di=1:9000
%         %di=4950 % density coordinate of intersection between data and model
%         %di=3000 % density coordinate of intersection between data and model
%         data=reference(:,1,i);
% %         data=ccc(2:end-1,1,i);
% %         if i==1
% %             data=ccc(2:end-1,3,i);
% %         end
%         datadi=data(di);
%         indextrans=find(density>density(di)*datadi/data(end),1);
%         %indextrans=di;
%         model(1:indextrans)=density(di)*datadi./density(1:indextrans);
%         model(indextrans:m)=data(end);
%         error=(model(2:end-1)'-data)./data;
%         maxerror(di,i)=max(abs(error));
%         maxerror01(di,i)=max(abs(error(1000:end)));
%     end
% end
% 
% figure(6)
% plot(density(2:9001),maxerror(:,1))
% hold on
% plot(density(2:9001),maxerror(:,2))
% hold on
% plot(density(2:9001),maxerror(:,3))
% hold off
% 
% figure(7)
% plot(density(2:9001),maxerror01(:,1))
% hold on
% plot(density(2:9001),maxerror01(:,2))
% hold on
% plot(density(2:9001),maxerror01(:,3))
% hold off


%metamodel 3
maxerror=2*ones(9000,3);
maxerror01=2*ones(9000,3);
for i=1:3
    for di=1:9000

        %data=reference(:,1,i);
        data=ccc(2:end-1,1,i);
        if i==1
            data=ccc(2:end-1,3,i);
        end
        nlow=0.01;
        nup=data(end);
        %di=4950 % density coordinate of intersection between data and model
        %di=3000 % density coordinate of intersection between data and model

        datadi=data(di);
        while nup-nlow>0.01
            n=(nup+nlow)/2;
            model=n./density(2:end-1)+(data(end)-n).*density(2:end-1).^(n/(data(end)-n));
            modeldi=model(di);
            if modeldi > datadi
                nup=n;
            else
                nlow=n;
            end
        end
        error=(model-data)./data;
        maxerror(di,i)=max(abs(error));
        maxerror01(di,i)=max(abs(error(1000:end)));
    end
end
n


figure(9)
plot(density(2:9001),maxerror(:,1))
hold on
plot(density(2:9001),maxerror(:,2))
hold on
plot(density(2:9001),maxerror(:,3))
hold off

figure(10)
plot(density(2:9001),maxerror01(:,1))
hold on
plot(density(2:9001),maxerror01(:,2))
hold on
plot(density(2:9001),maxerror01(:,3))
hold off





fclose('all')