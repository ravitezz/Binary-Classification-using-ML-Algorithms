function [d,thre,sign_left,P,alpha,y_pred]=stump_train(X,y,w)
%Input:
%X(features): D*N; y(labels,+/-1): N*1; w(weights on data): N*1, sum(w)=1.
%Output:
%d: the chosen feature dimension for the stump, 1<=d<=D
%thre: threshold on the chosen feature dimension
%sign_left: representing if the range left to the threshold is +1 or -1
%P: the weighted probability of the classification error
%alpha: weight of this stump
%y_pred: the predicted labels

d=randi(size(X,1));
temp=X(d,:);
minv= min(temp);
maxv= max(temp);
thre=temp(randi(size(X,2)));
% thre=maxv+minv/2;
temp1=[-1,1];
t=randi(size(temp1,2));
sign_left=temp1(t);
P=0;
y_pred= zeros(size(temp,2),1);
for i=1:size(X,2)
 if(sign_left==1)
    if(temp(:,i)<=thre)
        y_pred(i)=-1;
    else   
        y_pred(i)=1;
        
    end
 else   
    if(temp(:,i)<=thre)
        y_pred(i)=1;
    else   
        y_pred(i)=-1;
        
    end
    
 end
end    

prob=(sum(y_pred~=y));

for i=1:size(y,1)
    
    if(y_pred(i)~=y(i))
       
        P=P+w(i);
        
    end    
   
end    

alpha=0.5*(log(abs((1-P))/P));


end

