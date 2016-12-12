function [m,n,newE] = checkMatrix(adj) % The validation of array 

   if isnumeric(adj) && isreal(adj) && all(all(adj(:,1:2)>0)) && all(all((adj(:,1:2)==round(adj(:,1:2)))))
    se=size(adj); 
    if length(size(adj)) ~= 2,
        error('The array must be 2D!') 
    end
    if (se(2)<2),
        error('The array must have 2 or 3 columns!'), 
    end

    m=se(1);
    if se(2)<3, % not set the weight
      adj(:,3)=1; % all weights =1
    end
    newE=adj(:,1:3);
    n=max(max(newE(:,1:2))); % number of vertexes
else
    error('The adj is not suitable!'), 
end
return