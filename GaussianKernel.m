function [ output_args ] = GaussianKernel( gamma,X,Y )

for i=1:size(X,2)
   for j=1:size(Y,2)
    output_args(i,j)=exp(-gamma*norm(X(:,i)-Y(:,j))^2);%Y(i)*Y(j)*h(i,j);
   end
end

%     output_args=X'*Y;

end

