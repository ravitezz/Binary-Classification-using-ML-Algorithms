clear all;close all;
load('SoftMarginDataSet_LinearKernel.mat')

C=1; % 10,1, 0.1, 0.01

alpha= zeros(size(X,2),1);

h=LinearKernel(X,X);

f=zeros(size(X,2),1);
ub=zeros(size(X,2),1);

for i=1:size(X,2)
   for j=1:size(X,2)
    h(i,j)=Y(i)*Y(j)*h(i,j);
   end
   f(i)=-1;
   ub(i)=C;
end

Aeq=Y';
beq=0;

lb=zeros(size(X,2),1);

alpha=quadprog(h,f,[],[],Aeq,beq,lb,ub);

boundedSVIdx=[];
SVIdx=[];
w=zeros(2,1);
for i=1:size(X,2)
 
 if(C-alpha(i)<0.001)
    
     boundedSVIdx=[boundedSVIdx;i];
     
 end    
 if(alpha(i)>=0.01)
    
     SVIdx=[SVIdx;i];
     
 end 
 w=w+alpha(i)*Y(i)*X(:,i);
 
end 


temp=0;

for i=1:size(boundedSVIdx,1)
    temp=temp+alpha(boundedSVIdx(i))*Y(i)*LinearKernel(X(:,i),X(:,16));
end




freeSVIdx=[];

for i=1:size(X,2)
 
 if(alpha(i)>0.001&&(C-alpha(i))>0.001)
    
     freeSVIdx=[freeSVIdx;i];
     
 end    
 
end 

b=Y(freeSVIdx(1))-w'*X(:,freeSVIdx(1));

% b=Y(16)-temp;

W_full=[b;w];

margin= 1/norm(W_full);

visualizeSoftMarginSVM_LinearKernel(X,Y,w,b,freeSVIdx,boundedSVIdx);






