function out=demyelbra(p,u)
% m(0.5cm) nel punto centrale ==> m(0)
nn=(p.np+1)/2;
out=[u(1);...
    u(nn);...
    u(p.np+nn);
    sum(abs(p.mat.M(1:p.np,1:p.np)*(u(1:p.np))))/p.Om;...%||m||_L^1
    sum(abs(p.mat.M(1:p.np,1:p.np)*(u(p.np+1:2*p.np))))/p.Om];%||c||_L^1
end
% outfu for chemotax, put ||u-1||_L^1 first on branch 
%n=sum(abs(p.mat.M(1:p.np,1:p.np)*(1-u(1:p.np))))/p.vol; 
%out=[n; max(u(1:p.nu))];
