clear all;
close all;
load('AdaBoostDataset.mat')
w= zeros(size(X,2),1);
w_new= zeros(size(X,2),1);
K=200;
alpha_all=[];
sign_left_all=[];
thre_all=[];
for i=1:size(X,2)  
    w(i)=1/i;
end
Z1=sum(w);

w=w/Z1;
d_all=[];
for m=1:K
   
%     stump_train(X,Y,w);
   [d,thre,sign_left,P,alpha,y_pred]=stump_train(X,Y,w);

    for i=1:size(X,2)  
        w_new(i)= w(i)*exp(-Y(i)*alpha*y_pred(i));
    
    end
%     Y_pred1 =  sign(alpha_all*y_pred);
%      error(m)=(sum(Y_pred1~=Y));
    Z=sum(w_new);
    w_new=w_new/Z;
    w=w_new;
    w_new= zeros(size(X,2),1);
    alpha_all=[alpha_all;alpha];
    d_all=[d_all;d];
    sign_left_all=[sign_left_all;sign_left];
    thre_all=[thre_all;thre];
end

%visualize the decision boundary
figure; hold on;
posIdx = find(Y==1); negIdx = find(Y==-1);
plot(X(1,posIdx),X(2,posIdx),'r.',X(1,negIdx),X(2,negIdx),'bx');
xmin = min(X(1,:)); xmax = max(X(1,:)); ymin = min(X(2,:)); ymax = max(X(2,:));
gridcellsX = 80; gridcellsY = 80;
[x,y] = meshgrid(xmin:(xmax-xmin)/gridcellsX:xmax,ymin:(ymax-ymin)/gridcellsY:ymax);
X_test = [x(:)'; y(:)'];
Y_pred = zeros(K,size(X_test,2));
for m = 1:K %K is the number of weak classifiers
Y_pred(m,:) = alpha_all(m)*(2*(X_test(d_all(m),:)>thre_all(m))-1)*(-sign_left_all(m));
end
z = reshape(2*(sum(Y_pred)>0)-1,size(x,1),size(x,2));
contour(x,y,z,[0 0],'k')
hold off;




