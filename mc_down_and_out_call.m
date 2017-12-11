% Standard Monte Carlo method for calculating the down and out call price

clf
clear

S0 = 10; E = 8; B=5;T = 1; r = 0.02; sigma = 0.3;n = 400; dt = T/n;
phi = @(x) max(x-E,0);

% calculate option prices with True formula

V_TRUE=blsprice(S0,E,r,T,sigma,0)-(B/S0)^(2*r/sigma^2-1)*blsprice(B^2/S0,E,r,T,sigma,0);
plot([log(10^1) log(10^7)],[V_TRUE V_TRUE],'-b')
hold on

for M = 10.^[2:6]
   for i = 1:M
       temp=randn;  
       S1(1)=S0*exp((r-0.5*sigma^2)*dt+sigma*sqrt(dt)*temp);
       
       for j=2:n
           temp=randn;
           S1(j) = S1(j-1)*exp((r-0.5*sigma^2)*dt+sigma*sqrt(dt)*temp);
       end
       S1min = min(S1);
       if S1min>B
            V(i) = exp(-r*T)*max(S1(end)-E,0);
       else
            V(i) = 0;
       end

   end
     
   aM = mean(V);
   bM = std(V);
   confint = [aM-1.96*bM/sqrt(M) aM+1.96*bM/sqrt(M)];
   plot(log(M),aM,'xr')
   hold on
   plot([log(M) log(M)],confint,'-g')
   hold on
   %fprintf('No. of samples = %d   Option price approximation = %f\n',M,aM)
end
legend('Exact Solution','Option price approximation','Confidence intervals')
xlabel('Log of number of samples')
ylabel('Option price approximation')
