
load('LinearSeparable.mat')
% load('NonLinearSeparable.mat')
w= zeros(size(X,1),1);
y_pred= sign(w'*X);

% batch=size(X,2)/4;

learning_rate=0.1;
num_iterations=0;
sum= zeros(size(X,1),1);
% if ( y_pred*Y'<=0)
    count= num(y_pred,Y);
    while(count~=0) 
        for i=1:size(X,2)
            
            if ( sign(w'*X(:,i))== Y(i))
                continue;
            else
              sum=  sum+(Y(i)-sign(w'*X(:,i)))*X(:,i); % Adaptive Linear Neuron
                
            end          
        end
        w= w + learning_rate*sum;
        Y_new= sign(w'*X);
        count= num(Y_new,Y);
        visualise(X,Y,w);
        num_iterations=num_iterations+1;
    end
  

