clear all;
load('NonLinearSeparable.mat')

w= zeros(size(X,1),1);
% y_pred= sign(w'*X);

% if ( y_pred*Y'<=0)
%     count= num(y_pred,Y);
num_iterations=0;
w_old=zeros(size(X,1),1);
    for it=1:100
        Y_ear= sign(w'*X);
        earlier= num(Y_ear,Y);
%         rando = randperm(size(X,2));
        for i=1:20
           
            if ( sign(w'*X(:,i))== Y(i))
                continue;
            else
                
                w= w + Y(i)*X(:,i);
                
%                   visualise(X,Y,w);  
            end     
            
        end
%         w_old=w;
        Y_nu= sign(w'*X);
        Y_old= sign(w_old'*X);
        count= num(Y_nu,Y);
        count_old= num(Y_old,Y);
        if(count_old<count)
                    
             w= w_old;
        else
            
            w_old=w;
                
        end     
        Y_new= sign(w'*X);
        counter= num(Y_new,Y);
        visualise(X,Y,w);
        
        if(earlier~=counter)
            num_iterations=num_iterations+1;
        end
        
    end
    
  
   

