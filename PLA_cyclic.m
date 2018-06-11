
load('LinearSeparable.mat')
%load('NonLinearSeparable.mat')
w= zeros(size(X,1),1);
y_pred= sign(w'*X);
num_iterations=0;
% if ( y_pred*Y'<=0)
    count= num(y_pred,Y);
    while(count~=0) 
        rando = randperm(size(X,2));% select randomly the training data
        for i=1:size(X,2) 
            
            if (  sign(w'*X(:,rando(i)))== Y(rando(i)))
                continue;
            else
                w= w + Y(rando(i))*X(:,rando(i));
            end          
        end
        
        Y_new= sign(w'*X);
        count= num(Y_new,Y);
        visualise(X,Y,w);
        num_iterations=num_iterations+1;
    end
  

