function p=demyelin1Dinit(p,lx,nx,par)
% (generic) init routine for the
    %% setting standard parameters and screenlayout
    p=stanparam(p); % infuses p with standard parameter settings
    screenlayout(p); % open, clear and arrange the common figures
    %% special parameters related to this model
    % basics
    p.nc.neq=2; % number of equations in the model
    p.nc.nsteps=1000;
    p.sw.foldcheck=1;
    p.sw.bifcheck=2;
    p.sw.sfem=-1; % type of numerical calculation, here OOPDE
    p.sw.jac=1; % 0 use numerical jacobian, 1 use sGjac
    p.sw.spjac=0; % use analytical Jacobian for spectral point cont (fold cont)
    % description of the model
    p.fuha.sG=@sG; % the model itself
    p.fuha.sGjac=@sGjac; % the Jacobian of the model  
    p.fuha.outfu=@demyelbra; % output quantities
    p.fuha.cfu=@cfu; 
    %% domain and mesh
    p.pdeo=stanpdeo1D(lx,2*lx/nx); % mesh [-lx ,lx], max mesh pt 2* lx/r
    bc=p.pdeo.grid.neumannBC('0');
    p.pdeo.grid.makeBoundaryMatrix(bc);
    p.np=p.pdeo.grid.nPoints ; % number of meshpoints
    p.nu=p.np*p.nc.neq; % number of unknowns (=2*( mesh points ), as 3 components )
    p=setfemops(p); % compute FEM - operators
    %% bifurcation parameter , continuation basics and first guess for solution
    %p.usrlam=[3.7 4 4.5 5 5.5]; % compute point and write to disk at these par values
    p.nc.ilam=1; % primary bifurcation parameter located at p.u(p.np+p.nc.ilam )
    p.nc.lammin=1e-4; % lower bound for primary parameter during continuation
    p.nc.lammax=21; % upper bound for primary parameter during continuation
    p.sol.xi=1/p.nu; % weight in arclength - continuation
    p.sol.ds=0.0001; % starting stepsize
    p.nc.dsmax=5e-4; % maximal stepsize
    p.nc.dsmin=1e-7; % minimal stepsize
    % construction the trivial solution
    % initial guess
    % homogeneous branch
    %chi=par(1); tau=par(2); epsilon=par(3); r=par(6);
    delta=par(4); beta=par(5); 
    m=ones(p.np,1); c=(beta+delta)*ones(p.np,1);
    p.u=[m; c; par];  % initial solution guess with parameters
    %% Plot
    p.plot.pcmp=1; % plotsol plots the 2nd component
    p.plot.auxdict ={'chi','tau','epsilon','delta','beta','r','M','Lambda'}; % parameter names 
end