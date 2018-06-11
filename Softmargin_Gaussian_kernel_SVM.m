clear all; close all;
load('SoftMarginDataSet_GaussianKernel.mat')

C=2; 
gamma=0.1;%0.001, 0.01, 0.1, 0.25
alpha= zeros(size(X,2),1);
% h=zeros(size(X,2));
h=GaussianKernel(gamma,X,X);

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
freeSVIdx=[];

for i=1:size(X,2)
 
 if(alpha(i)>0.001&&(C-alpha(i))>0.001)
    
     freeSVIdx=[freeSVIdx;i];
     
 end    
 
end 

temp=0;

sv=freeSVIdx(1);

for i=1:size(SVIdx,1)
    temp=temp+alpha(SVIdx(i))*Y(SVIdx(i))*GaussianKernel(gamma,X(:,SVIdx(i)),X(:,sv));
end


b=Y(sv)-temp;

W_full=[b;w];

margin= 1/norm(W_full);


visualizeSoftMarginSVM_GaussianKernel(X,Y,alpha,b,freeSVIdx,boundedSVIdx,gamma);






