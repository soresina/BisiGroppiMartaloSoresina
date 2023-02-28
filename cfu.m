function c=cfu(u,par) % diffusion tensor, for \pa_u div(c(u)grad v)
c=par*u./(1+u); 
end 