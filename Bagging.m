clear all;
close all;
load('BaggingDataset.mat')
T_bag=5; %5,25,50
X_temp=[];
Y_temp=[];
Z=[];
all_w=[];
 for t=1:T_bag
   
   rand = randi(size(X,2),1,size(X,2));
   for i=1:size(X,2) 
    X_temp=[X_temp X(:,rand(i))];
    Y_temp=[Y_temp Y(rand(i))];
   end
   
   [w] = Pocket_PLA(X_temp,Y_temp);
   all_w=[all_w w];
   g=  sign(w'*X);
%    g=  w'*X;
%    errorcount=sum(Y~=g);
   Z=[Z;g];
   
% X_reg=X';
% Y_reg=Y';
X_temp=[];
Y_temp=[];
  
 end
 
X_train=Z';
Y_train=Y';

% W_Linear=inv(X'*X)*(X'*Y);
% alpha=(inv(X_train'*X_train)*X_train')*Y_train;
% alpha=(X_train'*X_train)\(X_train'*Y_train);
lamda=0.01;
alpha=(X_train'*X_train +lamda*eye(size(X_train,2)))\(X_train'*Y_train);
% save('W_Linear.mat','W_Linear');
% (X_train'*X_train)\(X_train'*Y_train);
X_test=Z;
Y_test=Y;

Y_pred=sign(alpha'*X_test);

error_Linear=sum(Y_pred~=Y_test); 
 
xmin = min(X(2,:)); xmax=max(X(2,:));ymin = min(X(3,:)); ymax=max(X(3,:));
gridcellsX = 400; gridcellsY = 400;
[x,y] = meshgrid(xmin:(xmax-xmin)/gridcellsX:xmax,ymin:(ymax-ymin)/gridcellsY:ymax);
z = reshape(alpha'*sign(all_w'*[ones(1,numel(x)); x(:)'; y(:)']),size(x,1),size(x,2));
figure; hold on;
posIdx=find(Y==1); negIdx=find(Y==-1);
plot(X(2,posIdx),X(3,posIdx),'rx');
plot(X(2,negIdx),X(3,negIdx),'bo');
contour(x,y,z,[0 0],'k')
hold off; 
% temp=zeros(1,20);
% for t=1:T_bag 
% temp=temp+alpha(t)*Z(t,:); 
% end
% 
% G=sign(temp);
% 
% error_bag=sum(Y_pred~=G); 

