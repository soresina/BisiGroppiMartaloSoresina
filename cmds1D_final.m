%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Demyelization Patterns                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - creating a clear working space and setting pde2path

cFolPath='/Users/cinziasoresina/My Drive/UniversityAndWorks/MATLAB/pde2path/XXX-myworks-XXX/BisiGroppiMartalo/2eq_Allee_fromLogistic';
cd('/Users/cinziasoresina/My Drive/UniversityAndWorks/MATLAB/pde2path')

setpde2path
close all
clc
edtSvc=com.mathworks.mlservices.MLEditorServices; 
edtList=edtSvc.getEditorApplication.getOpenEditors.toArray;
for k=1:length(edtList)
    [~, fname]=fileparts(char(edtList(k).getLongName.toString));
    edt.(fname)=edtList(k);
end
%edt.setpde2path.closeNoPrompt % close setpde2path.m
cd(cFolPath)
keep pphome cFolPath
%% 2 - initialising the problem
p=[];
M=-0.5;
epsilon=0.08;
%m2=(M+1+sqrt(M^2-M+1))/3; Lambda=(4*m2*(1-m2)*(m2-M))^(-1);%caso1
Lambda=1/(1-M);%caso 2
par=[3.25,1,epsilon,1,1,1,M,Lambda]'; % 'chi','tau','epsilon','delta','beta','r','M','Lambda'

lx=6*pi;
nx=200;
p=demyelin1Dinit(p,lx,nx,par); 
p.Om=2*lx;
p=setfn(p,'0_stationary');  
p.nc.dsmax=1e-3;p.nc.lammax=3.6;p=cont(p,65); 
p.nc.dsmax=1e-4;p.nc.lammax=3.6;p=cont(p,150); 
p.nc.dsmax=1e-3;p.nc.lammax=3.6;p=cont(p,500); 

p=swibra('0_stationary','bpt1','q1_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt2','q2_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,500);
p=swibra('0_stationary','bpt3','q3_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt4','q4_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,300);
p=swibra('0_stationary','bpt5','q5_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt6','q6_d',-0.01);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt7','q7_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt8','q8_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt9','q9_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt10','q10_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt11','q11_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt12','q12_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt13','q13_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt14','q14_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt15','q15_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt16','q16_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt17','q17_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt18','q18_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
p=swibra('0_stationary','bpt19','q19_d',-0.05);p.nc.lammax=3.6;p.nc.dsmax=1e-2; p=cont(p,600);
%%
figure(4);clf(4);
box on

cmp=0; % L2norm
% cmp=1; % m left boundary
% cmp=2; % m middle point 
% cmp=3; % c middle point 
% cmp=4; % d middle point 

p.plot.pstyle=2; 

%plotbra('q19_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q18_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q17_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q16_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q15_d',4,cmp,'cl',[0.85, 0.0, 0.3]);%grey
plotbra('q14_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q13_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q12_d',4,cmp,'cl',[0.25 0.41 0.53]);%dark green
plotbra('q11_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q10_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q9_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q8_d',4,cmp,'cl',[1,0.55,0]);%orange
plotbra('q7_d',4,cmp,'cl',[0.55 0.57 0.67]);%grey
plotbra('q6_d',4,cmp,'cl',p2pc('c'));%light blue
plotbra('q5_d',4,cmp,'cl',[0.6 0.2 0.8]); % violet
plotbra('q4_d',4,cmp,'cl',p2pc('m'));
plotbra('q3_d',4,cmp,'cl',p2pc('g'));
plotbra('q2_d',4,cmp,'cl',p2pc('r'));
plotbra('q1_d',4,cmp,'cl',p2pc('b'));%blue
plotbra('0_stationary',4,cmp,'cl','k'); 


hold on 
%val_chi=[3.3, 3.31, 3.34, 3.37, 3.5, 4, 5];
val_chi=3.5;
for chi_x=val_chi
    plot([chi_x chi_x],[0 6.2],'k:')
end
xlabel('\chi')
ylabel('||m||_{L_2}')
%ylabel('m(6\pi)')
axis([3.25 3.6 4.8 6.2])