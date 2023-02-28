clear
close all
clc 
% Turing bifurcation point - \chi_bif

%Parameters
pioverL=1/12; %domain [0,L]
M=-0.5; %Allee threshold
Lambda=1/(1-M);%case1
%m2=(M+1+sqrt(M^2-M+1))/3; Lambda=(4*m2*(1-m2)*(m2-M))^(-1);%caso2
epsilon=0.08;
tau=1; delta=1; beta=1; r=1; 
%chi_c=2*(1+sqrt(epsilon))^2/beta;

N=200; %wavenumbers to check
CHI_BIF=zeros(1,N);
for k=1:N
    lambda_k=(pioverL*k)^2;%eigenvalues of the Laplacian
    %chi_c_k=2*(epsilon*lambda_k^2+Lambda*(1-M)+(1+epsilon*Lambda*(1-M))*lambda_k)/(beta*lambda_k);
    chi_c_k=2*(Lambda*(1-M)+lambda_k)*(1+epsilon*lambda_k)/(beta*lambda_k);
    CHI_BIF(k)=chi_c_k;
end

[bif,k_bif]=sort(CHI_BIF);
disp(['lambda_k    ','chi_bif    ','#peaks'])
formatSpec = '%4.0f & %4.0f & %4.6f & %4.1f\\\\ \n';
fprintf(formatSpec,[(1:N);k_bif;bif;k_bif/2])

figure()
box on
hold on
%plot(chi_c,0,'*r')
plot(CHI_BIF,zeros(1,N),'ob') % chi(lambda_k) at the bifurcation
plot(bif,k_bif/2,'*r') % number of peaks at the bifurcation
axis([3 10 -1 25])
