clear all;
load('LinearSeparable.mat')

w= zeros(size(X,1),1);
y_pred= sign(w'*X);
num_iterations=0;

% if ( y_pred*Y'<=0)
    count= num(y_pred,Y);
    while(count~=0) 
        for i=1:size(X,2)
            
            if ( sign(w'*X(:,i))== Y(i))
                continue;
            else
                w= w + Y(i)*X(:,i);
            end          
        end
        
        Y_new= sign(w'*X);
        count= num(Y_new,Y);
        visualise(X,Y,w);
        num_iterations=num_iterations+1;
    end
  

