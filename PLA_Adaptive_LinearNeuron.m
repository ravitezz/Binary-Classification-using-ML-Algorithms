
load('LinearSeparable.mat')
% load('NonLinearSeparable.mat')
w= zeros(size(X,1),1);
y_pred= sign(w'*X);

learning_rate=0.1;
num_iterations=0;
% if ( y_pred*Y'<=0)
    count= num(y_pred,Y);
    while(count~=0) 
        for i=1:size(X,2)
            
            if ( sign(w'*X(:,i))== Y(i))
                continue;
            else
                w= w + learning_rate*(Y(i)-sign(w'*X(:,i)))*X(:,i); % Adaptive Linear Neuron
                
            end          
        end
        
        Y_new= sign(w'*X);
        count= num(Y_new,Y);
        visualise(X,Y,w);
        num_iterations=num_iterations+1;
    end
  

