% Antithetic sampling Monte Carlo method for calculating the call price

clf
clear

S0 = 10; E = 5; T = 1; r = 0.02; sigma = 0.25;
phi = @(x) max(x-E,0);

[call put] = blsprice(S0,E,T,r,sigma,0);
plot([log(2^4) log(2^16)],[call call])
hold on

%printf('Call price = %f\n\n',call)

for M = 2.^[5:15]/2
   for i = 1:M
      temp=randn;
      ST1 = S0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*temp);
      ST2=S0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*(-temp));
      V(i) = exp(-r*T)*(phi(ST1));
      U(i) = exp(-r*T)*(phi(ST2));
   end
   aM = mean((V+U)/2);
   bM = std((V+U)/2);
   confint = [aM-1.96*bM/sqrt(M) aM+1.96*bM/sqrt(M)];
   plot(log(M),aM,'xr')
   hold on
   plot([log(M) log(M)],confint,'-g')
   hold on
   %fprintf('No. of samples = %d   Option price approximation = %f\n',M,aM)
end
legend('Black-Scholes call price','Option price approximation','Confidence intervals')
xlabel('Log of number of samples')
ylabel('Option price approximation')
