% Implements the forward in time, central in space (FTCS) scheme
% with homogeneous Dirichlet boundary conditions

clear
clf

% Initialize variables
L = pi; T = 3;
I = 20; J = 600;
h = L/I; k = T/J; lambda = k/h^2;

% Define initial condition
f = @(x) sin(x);

% Define boundary conditions
a = @(t) 0;
b = @(t) 0;

% Define coefficient matrix for FTCS
F = diag((1-2*lambda)*ones(1,I-1))+diag(lambda*ones(1,I-2),1)+diag(lambda*ones(1,I-2),-1);

% Set up initial condition
U = f(h*[1:I-1])';

% Implement FTCS scheme
for j = 0:J-1
    p = lambda*[a(j*k) zeros(1,I-3) b(j*k)]';
    U = F*U+p;
    if mod(j,100) == 0
        plot([0:h:L],[a(k*J) U' b(k*J)],'-ob') 
        hold on
        plot([0:h:L],exp(-j*k)*sin([0:h:L]),'-r')  
        hold on
    end
end


plot([0:h:L],[a(J*k) U' b(J*k)],'-ob')
hold on
plot([0:h:L],exp(-j*k)*sin([0:h:L]),'-r')
legend('Numerical','Exact')
xlabel('x')
ylabel('u(x,t)')
