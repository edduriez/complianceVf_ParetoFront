function [initVf,mincP1,VfmincP1,mincP1vfOK,VfmincP1vfOK]=mainTop88r3(nelx,nely,volfrac)
%used to obtain compliance and time of top88 on the same grid as the one evaluating our
%method

%volfrac:   global volume fraction
%nelx:   number of elements in horizontal direction
%nely:   number of elements in vertical direction
%posttreat:   0 for no post-treatment, 
%             1 for forcing element densities to 0 or 1 while conserving
%             volume fraction

[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'volfrac'); %get top88 design
compliance1=evaluateTotalDesign(xPhys,1,'MBB')
vf1=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'box0'); %get top88 design
compliance2=evaluateTotalDesign(xPhys,1,'MBB')
vf2=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'boxgrey'); %get top88 design
compliance3=evaluateTotalDesign(xPhys,1,'MBB')
vf3=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'1'); %get top88 design
compliance4=evaluateTotalDesign(xPhys,1,'MBB')
vf4=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'box05'); %get top88 design
compliance5=evaluateTotalDesign(xPhys,1,'MBB')
vf5=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'x05'); %get top88 design
compliance6=evaluateTotalDesign(xPhys,1,'MBB')
vf6=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'x0'); %get top88 design
compliance7=evaluateTotalDesign(xPhys,1,'MBB')
vf7=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xgrey'); %get top88 design
compliance8=evaluateTotalDesign(xPhys,1,'MBB')
vf8=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xbox05'); %get top88 design
compliance9=evaluateTotalDesign(xPhys,1,'MBB')
vf9=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xbox0'); %get top88 design
compliance10=evaluateTotalDesign(xPhys,1,'MBB')
vf10=mean(mean(xPhys));
[xPhys]=top88DesignMBB(nelx,nely,volfrac,3,3,1,'xboxgrey'); %get top88 design
compliance11=evaluateTotalDesign(xPhys,1,'MBB')
vf11=mean(mean(xPhys));

comp=[compliance1,compliance2,compliance3,compliance4,compliance5,compliance6,compliance7,compliance8,compliance9,compliance10,compliance11];
vf=[vf1,vf2,vf3,vf4,vf5,vf6,vf7,vf8,vf9,vf10,vf11];


initVf=vf(1);
[mincP1,mini]=min(comp);
VfmincP1=vf(mini);

if max(vf)<0.999*volfrac
    mincP1vfOK=0;
    VfmincP1vfOK=0;
else
    [mincP1vfOK,minivf]=min(comp(vf>=0.999*volfrac));
    vfOK=vf(vf>=0.999*volfrac);
    VfmincP1vfOK=vfOK(minivf);
end
    







