% Milstein method for the SDE dX_t = mu X_t dt + sigma X_t d W_t (GBM)

clear
clf

% Repeatable trials on/off
%randn('state',100)

% Input model parameters
mu = 0; sigma = 1; X0 = 1; T = 1;

% Initialise variables for Brownian motion
J = 2^8; dt = T/J;

% Calculates Brownian motion
dW = sqrt(dt)*randn(1,J);
W = cumsum(dW);

% Plot true solution to SDE
Xtrue = X0*exp((mu - 0.5*sigma^2)*[dt:dt:T] + sigma*W);

% Initialise variables for SDE
R= 1; K = J/R; du = R*dt;

% Preallocate for efficiency
Xmil = zeros(1,K);

% Initialise temporary variable for numerical solution
Xtemp = X0;

% Loop to calculate solution
for k = 1:K
   Winc = sum(dW((k-1)*R+1:k*R));
   Xtemp = Xtemp + mu*Xtemp*du + sigma*Xtemp*Winc+0.5*sigma^2*Xtemp*(Winc^2-du);
   Xmil(k) = Xtemp;
end

% Plot numerical solution
plot([0:dt:T],[X0 Xtrue],'-b',[0:du:T],[X0 Xmil],'-r')
xlabel('t')
ylabel('X_t','rotation',0)
legend('True solution','Numerical solution')

% Calculate error between numerical and true solutions at t = T 
emerr = abs(Xmil(end) - Xtrue(end)) 