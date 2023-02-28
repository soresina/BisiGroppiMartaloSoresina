function Gu=sGjac(p,u) 
% m_t=Lap u-chi*div((m/(1+m))*grad c)+m(1-m),  
% c_t=epsilon/tau Lap c+(delta*d-c+beta*m)/tau
% d_t= rm^2/(1+m)*(1-d)
par=u(p.nu+1:end);
chi=par(1); tau=par(2); epsilon=par(3); delta=par(4); beta=par(5); r=par(6);  M=par(7); Lambda=par(8);

u=u(1:p.nu);
n=p.np;
u1=u(1:n); 
u2=u(n+1:2*n);

f1m=Lambda*(-3*u1.^2+2*(1+M)*u1-M); f1c=0*f1m;
f2m=beta*ones(p.np,1)/tau; f2c=-ones(p.np,1)/tau; 

Fu=[[spdiags(f1m,0,n,n),spdiags(f1c,0,n,n)]; % Jac of semilin. nonlin. 
    [spdiags(f2m,0,n,n),spdiags(f2c,0,n,n)]];
   

ut=p.mat.p2c*u1; 
gr=p.pdeo.grid; 
fem=p.pdeo.fem; 
cc=p.fuha.cfu(ut,chi); 
K=p.mat.K; 
[K12,~,~]=fem.assema(gr,cc,0,0);  % cross-diffusion 

% jacsw=1; 
% switch jacsw; 
%     case 0 % approximate way, does not work for all branches here 
%   vx=p.mat.Dx*u2; vy=p.mat.Dy*u2; % 1st derivatives as coefficients   
%   KK=p.mat.Kx*spdiags(vx,0,n,n)+p.mat.Ky*spdiags(vy,0,n,n); 
%   Gu=[d*K+lam*KK -lam*K12;  0*K K]-p.mat.M*Fu; 
%     case 1 % using getKuvd to obtain \pa_u \div(c(u)\nabla v) via numjac
  Kuvd=getKuvd(p,1,u1,u2); 
  Gu=[K-chi*Kuvd -K12;  0*K epsilon/tau*K]-p.mat.M*Fu;  
end