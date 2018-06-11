function visualizeSoftMarginSVM_LinearKernel(X,Y,w,b,freeSVIdx,boundedSVIdx) 

%visualization
xmin = min(X(1,:)); xmax=max(X(1,:));ymin = min(X(2,:)); ymax=max(X(2,:));
gridcellsX = 20; gridcellsY = 20;
[x,y] = meshgrid(xmin:(xmax-xmin)/gridcellsX:xmax,ymin:(ymax-ymin)/gridcellsY:ymax);
z = reshape(w'*[x(:)'; y(:)']+b,size(x,1),size(x,2));
figure; hold on;
posIdx=find(Y==1); negIdx=find(Y==-1);
plot(X(1,posIdx),X(2,posIdx),'rx');
plot(X(1,negIdx),X(2,negIdx),'bo');
plot(X(1,freeSVIdx),X(2,freeSVIdx),'ks','Markersize',10);
plot(X(1,boundedSVIdx),X(2,boundedSVIdx),'k^','Markersize',10);
contour(x,y,z,[0 0],'k')
contour(x,y,z,[-1 -1],'b-.')
contour(x,y,z,[1 1],'r-.')