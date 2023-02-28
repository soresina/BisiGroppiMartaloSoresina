function r=sG(p,u) % pde for chemotaxis model 
% m_t=Lap u-chi*div((m/(1+m))*grad c)+m(1-m),  
% c_t=epsilon/tau Lap c+(delta*d-c+beta*m)/tau
% d_t= rm^2/(1+m)*(1-d)
par=u(p.nu+1:end);
chi=par(1); tau=par(2); epsilon=par(3); delta=par(4); beta=par(5); r=par(6);
M=par(7); Lambda=par(8);

u=u(1:p.nu);
n=p.np;
u1=u(1:n); 
u2=u(n+1:2*n);

f1=Lambda*u1.*(1-u1).*(u1-M); 
f2=(delta-u2+beta*u1)/tau;
f=[f1;f2]; % semilin.nonlinearity 

ut=p.mat.p2c*u1; 
gr=p.pdeo.grid; 
fem=p.pdeo.fem; 
cc=p.fuha.cfu(ut,chi); % quasilin. coefficient, here simply c(u)=u

[K12,~,~]=fem.assema(gr,cc,0,0); % assemble matrix for cross-diff 
K=p.mat.K; 
r=[K -K12; 0*K epsilon/tau*K]*u-p.mat.M*f; % putting rhs together
end