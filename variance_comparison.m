% variance comparison for E(X),where X = e^(sqrt(U)) and U is Unif(0,1)

clf
clear


j=1;
for M = 2.^[4:16]
   U=rand(M,1);
   X = exp(sqrt(U));
   X_2 = exp(sqrt(1-U));
   X_a = (X+X_2)/2;
   Y = exp(U);
   
   aM = mean(X);%standard MC
   bM(j) = std(X);
   conf_int_X = [aM-1.96*bM(j)/sqrt(M) aM+1.96*bM(j)/sqrt(M)];
   
   Covariance=sum((X-aM).*(Y-(exp(1)-1)))/M;
   variance_Y=2*exp(1)-0.5*exp(2)-3/2;
   theta=Covariance/variance_Y;
   Z=X+theta*((exp(1)-1)-Y);
   mean_Z=mean(Z);
   std_Z(j)=std(Z);   
   conf_int_Z=[mean_Z-1.96*std_Z(j)/sqrt(M) mean_Z+1.96*std_Z(j)/sqrt(M)];
   
   plot(log(M),bM(j),'xr')
   hold on
   plot(log(M),std_Z(j),'+k')
   
   j=j+1;
end

legend('Standard MC','Control variates')
xlabel('Log of number of samples')
ylabel('Sample Variance')

