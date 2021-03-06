% =========================================================================
% Part of the Matlab code to accompany the paper
% 'Solving heterogeneous agent models in discrete time with
% many idiosyncratic states by perturbation methods', CEPR Discussion Paper
% DP13071
% by Christian Bayer and Ralph Luetticke
% http://www.erc-hump-uni-bonn.net/
% =========================================================================

%% Initialize workspace and load directories

addpath(genpath('functions'))
addpath(genpath('latex'))

%% Switch options
casename='SS_BASELINE_HANC_JPEG';
printIRFs     = false;
mpar.overrideEigen = false;

%% Produce matrices to reduce state-space
% disp('Reduce State Space and Compute System for Steady State')
mainskript_statereduc

% F = @(a,b,c,d)Fsys_NoAdj(a,b,c,d,Xss,Yss,Gamma_state,indexMUdct,indexCOPdct,DC1,DC2,DC3,DC4,Copula,par,mpar,grid,meshes,P_H,aggrshock,oc,os);
% 
F = @(a,b,c,d)Fsys(a,b,c,d,Xss,Yss,Gamma_state,indexMUdct,indexCOPdct,DC1,DC2,DC3,DC4,Copula,par,mpar,grid,meshes,P_H,aggrshock,oc,os);


[Fss,LHS,RHS,Distr] = F(State,State_m,Contr,Contr_m);


%% Solve RE via Schmitt-Grohe-Uribe Form
% disp('Take Numerical Derivatives and Solve RE via Schmitt-Grohe-Uribe Form')
[hx,gx,F1,F2,F3,F4,par] = SGU_solver(F, mpar.numstates,mpar.numcontrols,oc,mpar,par,p);

