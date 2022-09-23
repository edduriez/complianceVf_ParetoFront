function [compliance,vf,design]=mainTop88oneinit(nelx,nely,volfrac,initdes,prob)
%used to obtain compliance and time of top88 on the same grid as the one evaluating our
%method

%volfrac:   global volume fraction
%nelx:   number of elements in horizontal direction
%nely:   number of elements in vertical direction
%posttreat:   0 for no post-treatment, 
%             1 for forcing element densities to 0 or 1 while conserving
%             volume fraction

[xPhys]=top88DesignMBBinitdes(nelx,nely,volfrac,3,3,1,initdes,prob); %get top88 design
compliance=evaluateTotalDesign(xPhys,1,prob);
vf=mean(mean(xPhys));
design=xPhys(:)';

% [xPhys2]=top88DesignMBBinitdes(nelx,nely,volfrac,3,3,1,initdes2); %get top88 design
% compliance2=evaluateTotalDesign(xPhys2,1,'MBB');
% vf2=mean(mean(xPhys2));
% 
% comp=[compliance1,compliance2];
% vf=[vf1,vf2];
% 
% [mincP1,mini]=min(comp);
% VfmincP1=vf(mini);