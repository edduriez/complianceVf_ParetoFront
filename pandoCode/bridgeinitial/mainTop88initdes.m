function [compliance,vf]=mainTop88initdes(nelx,nely,volfrac,initdes)
%used to obtain the optimal design of a case

%volfrac:   global volume fraction
%nelx:   number of elements in horizontal direction
%nely:   number of elements in vertical direction
%posttreat:   0 for no post-treatment, 
%             1 for forcing element densities to 0 or 1 while conserving
%             volume fraction

[xPhys]=top88DesignMBBinitdes(nelx,nely,volfrac,3,3,1,initdes); %get top88 design
compliance=evaluateTotalDesign(xPhys,1,'MBB');
vf=mean(mean(xPhys));








