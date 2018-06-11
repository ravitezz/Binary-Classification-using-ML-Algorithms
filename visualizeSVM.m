function visualizeSVM(X,Y,w,b,svIdx)
%X: D*N
%Y: N*1
%(w,b) from SVM
%svidx: a column vector contains the index of support vectors regarding to
%the input data (X,Y)

%Note:
%the line equations of the decision boundary is w^T*x+b=0;
%the line equations along the support vectors are w^T*x+b=1 and w^T*x+b=-1;

N = size(X,2);
maxX1 = max(X(1,:)); minX1 = min(X(1,:));
maxX2 = max(X(2,:)); minX2 = min(X(2,:));
posIdx = find(Y==1);
negIdx = find(Y==-1);
figure; axis([minX1 maxX1 minX2 maxX2]); hold on;
plot(X(1,posIdx), X(2,posIdx), 'o', 'Linewidth', 2, 'Markersize', 10, 'Color', 'b');
plot(X(1,negIdx), X(2,negIdx), 'x', 'Linewidth', 2, 'Markersize', 10, 'Color', 'r');
plot(X(1,svIdx), X(2,svIdx), 's', 'Linewidth', 2, 'Markersize', 15, 'Color', 'k');
text(X(1,:)+.01,X(2,:),num2str([1:N]'));
if w(1)~=0
    minVal = - (w(2) * minX2 + b) / w(1);
    maxVal = - (w(2) * maxX2 + b) / w(1);
    plot([minVal, maxVal],[minX2, maxX2],'Linewidth',2,'Color','k');        
    minVal = - (w(2) * minX2 + b + 1) / w(1);
    maxVal = - (w(2) * maxX2 + b + 1) / w(1);
    plot([minVal, maxVal],[minX2, maxX2],'Linewidth',2,'Color','g');        
    minVal = - (w(2) * minX2 + b - 1) / w(1);
    maxVal = - (w(2) * maxX2 + b - 1) / w(1);
    plot([minVal, maxVal],[minX2, maxX2],'Linewidth',2,'Color','g');        
elseif w(2)~=0
    minVal = - (w(1) * minX1 + b) / w(2);
    maxVal = - (w(1) * maxX1 + b) / w(2);
    plot([minX1, maxX1],[minVal, maxVal],'Linewidth',2,'Color','k');                    
    minVal = - (w(1) * minX1 + b + 1) / w(2);
    maxVal = - (w(1) * maxX1 + b + 1) / w(2);
    plot([minX1, maxX1],[minVal, maxVal],'Linewidth',2,'Color','g');                    
    minVal = - (w(1) * minX1 + b - 1) / w(2);
    maxVal = - (w(1) * maxX1 + b - 1) / w(2);
    plot([minX1, maxX1],[minVal, maxVal],'Linewidth',2,'Color','g');                    
end
drawnow; 