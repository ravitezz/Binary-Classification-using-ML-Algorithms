
function [count] = num(x,y)

diff= x-y;
count=0;
for i=1:size(x,2)
    if(diff(i)~=0)
        count=count+1;
    end
end