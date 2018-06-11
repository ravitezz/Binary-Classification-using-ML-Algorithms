clear all;
load('LinearSeparable.mat')

D= size(X,1);
H=[0 zeros(1,D);zeros(D,1) eye(D)];

f=zeros(D+1,1);

A=zeros(size(X,2),D+1);
b1=zeros(size(X,2),1);

for i=1:size(X,2)
    A(i,:)=[-Y(i) -Y(i)*X(:,i)'];
    b1(i)=-1;
end

x=quadprog(H,f,A,b1);
b=x(1);
w=x(2:3);
g_svm=sign(w'*X+b);
pred=g_svm';

error=sum(pred~=Y)/size(Y,2);

SV=zeros(size(Y,1),1);

for i=1:size(Y,1)

SV(i)=Y(i)*(w'*X(:,i)+b);   

end

svIdx=[4;5;6]; 
visualizeSVM(X,Y,w,b,svIdx);
margin= 1/norm(w);



