function [initVf,mincP1,VfmincP1,mincP1vfOK,VfmincP1vfOK,design]=mainTop88allinit(nelx,nely,volfrac,prob)
%used to obtain the optimal design of a case

%volfrac:   global volume fraction
%nelx:   number of elements in horizontal direction
%nely:   number of elements in vertical direction
%posttreat:   0 for no post-treatment, 
%             1 for forcing element densities to 0 or 1 while conserving
%             volume fraction

[xPhys1]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'volfrac',prob); %get top88 design
compliance1=evaluateTotalDesign(xPhys1,1,prob);
vf1=mean(mean(xPhys1));
[xPhys2]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'box0',prob); %get top88 design
compliance2=evaluateTotalDesign(xPhys2,1,prob);
vf2=mean(mean(xPhys2));
[xPhys3]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'boxgrey',prob); %get top88 design
compliance3=evaluateTotalDesign(xPhys3,1,prob);
vf3=mean(mean(xPhys3));
[xPhys4]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'1',prob); %get top88 design
compliance4=evaluateTotalDesign(xPhys4,1,prob);
vf4=mean(mean(xPhys4));
[xPhys5]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'box05',prob); %get top88 design
compliance5=evaluateTotalDesign(xPhys5,1,prob);
vf5=mean(mean(xPhys5));
[xPhys6]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'x05',prob); %get top88 design
compliance6=evaluateTotalDesign(xPhys6,1,prob);
vf6=mean(mean(xPhys6));
[xPhys7]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'x0',prob); %get top88 design
compliance7=evaluateTotalDesign(xPhys7,1,prob);
vf7=mean(mean(xPhys7));
[xPhys8]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xgrey',prob); %get top88 design
compliance8=evaluateTotalDesign(xPhys8,1,prob);
vf8=mean(mean(xPhys8));
[xPhys9]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xbox05',prob); %get top88 design
compliance9=evaluateTotalDesign(xPhys9,1,prob);
vf9=mean(mean(xPhys9));
[xPhys10]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xbox0',prob); %get top88 design
compliance10=evaluateTotalDesign(xPhys10,1,prob);
vf10=mean(mean(xPhys10));
[xPhys11]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xboxgrey',prob); %get top88 design
compliance11=evaluateTotalDesign(xPhys11,1,prob);
vf11=mean(mean(xPhys11));

comp=[compliance1,compliance2,compliance3,compliance4,compliance5,compliance6,compliance7,compliance8,compliance9,compliance10,compliance11];
vf=[vf1,vf2,vf3,vf4,vf5,vf6,vf7,vf8,vf9,vf10,vf11];
xPhys=[xPhys1(:)';xPhys2(:)';xPhys3(:)';xPhys4(:)';xPhys5(:)';xPhys6(:)';xPhys7(:)';xPhys8(:)';xPhys9(:)';xPhys10(:)';xPhys11(:)'];

initVf=vf(1);
[mincP1,mini]=min(comp);
VfmincP1=vf(mini);
design=xPhys(mini,:);

if max(vf)<0.999*volfrac
    mincP1vfOK=0;
    VfmincP1vfOK=0;
else
    [mincP1vfOK,minivf]=min(comp(vf>=0.999*volfrac));
    vfOK=vf(vf>=0.999*volfrac);
    VfmincP1vfOK=vfOK(minivf);
end
    







