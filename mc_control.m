% Control variates for E(X),where X = e^(sqrt(U)) and U is Unif(0,1)

clf
clear
%rand('state',0)
EX = 2;
plot([log(2^4) log(2^16)],[EX EX],'-b')
%legend('Expected value')
hold on


for M = 2.^[4:16]
   U=rand(M,1);
   X = exp(sqrt(U));
   X_2 = exp(sqrt(1-U));
   X_a = (X+X_2)/2;
   Y = exp(U);
   
   aM = mean(X);%standard MC
   bM = std(X);
   conf_int_X = [aM-1.96*bM/sqrt(M) aM+1.96*bM/sqrt(M)];   
 
   Covariance=sum((X-aM).*(Y-(exp(1)-1)))/M;
   variance_Y=2*exp(1)-0.5*exp(2)-3/2;
   theta=Covariance/variance_Y;
   Z=X+theta*((exp(1)-1)-Y);
   mean_Z=mean(Z);
   std_Z=std(Z);   
   conf_int_Z=[mean_Z-1.96*std_Z/sqrt(M) mean_Z+1.96*std_Z/sqrt(M)];
   
   plot(log(M),mean_Z,'xr')
   hold on
   plot([log(M) log(M)],conf_int_Z,'-g') 
   hold on
   plot(log(M),aM,'*b')
   hold on
   plot([log(M) log(M)],conf_int_X,'-k') 
end

legend('Expected value','Sample mean of Z','Confidence intervals of Z','Sample mean of X','Confidence intervals of X')
xlabel('Log of number of samples')
ylabel('Sample mean')

