%Monto-carlo method to Calculate the integral I=int^1_0 x^3 dx

clc;
clear all;
M=50; % number of samples
X=rand(M,1).^3; % R = rand(N) returns an N-by-N matrix containing pseudorandom values drawn 
                    % from the standard uniform distribution on the open interval(0,1).
aM = mean(X);
bM = std(X);
conf_int = [aM-1.96*bM/sqrt(M) aM+1.96*bM/sqrt(M)];
I_true=1/4;
plot([M M],conf_int,'-g',M,aM,'xr',M,I_true,'xb')

                    
                    