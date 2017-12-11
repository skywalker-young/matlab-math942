function [ price ] = European_put_binomial( S0,K,r,T,sigma,M )

%M+1 is the nu. of the time step 
dt=T/M;

% parameters for setting up the tree
A=1/2*(exp(-r*dt)+exp((r+sigma^2)*dt));
a=A+sqrt(A^2-1);%mu
b=A-sqrt(A^2-1);%d
p=(exp(r*dt)-b)/(a-b);

SM=zeros(M+1,1); %all possible terminal asset values at the M+1 time step
for i=1:M+1
    SM(i,1)=b^(M-i+1)*a^(i-1)*S0;
end
VM=max(K-SM,0);  %option value at the (M+1)th time step
V2=VM;

for k=M:-1:1
     V1=zeros(k,1);
    for m=1:k
        V1(m,:)=exp(-r*dt)*(p*V2(m+1,1)+(1-p)*V2(m,1)); % V1: the option value at the kth step, 
                                                  %V2: the option value at the (k+1)th step (previous step).
                                                
    end
    V2=V1;
end
price=V1;

end

