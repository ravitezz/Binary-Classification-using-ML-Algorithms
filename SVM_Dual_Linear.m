clear all;
load('LinearSeparable.mat')

alpha= zeros(size(X,2),1);

h=X'*X;

f=zeros(size(X,2),1);

for i=1:size(X,2)
   for j=1:size(X,2)
    h(i,j)=Y(i)*Y(j)*h(i,j);
   end
   f(i)=-1;
end

Aeq=Y';
beq=0;

lb=zeros(size(X,2),1);

alpha=quadprog(h,f,[],[],Aeq,beq,lb,[]);

w=zeros(2,1);

for i=4:6
    
    w=w+alpha(i)*Y(i)*X(:,i);
    
end

b=Y(5)-w'*X(:,5);

svIdx=[4;5;6]; 
visualizeSVM(X,Y,w,b,svIdx);
margin= 1/norm(w);





