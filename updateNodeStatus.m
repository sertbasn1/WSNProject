function [cgraph]=updateNodeStatus(cgraph,topology,N)

for i=1:N-1
    if topology(4,i)==0
        %delete the dead node(i) links
        for m=1:N
            if cgraph(m,i)~=0
                cgraph(m,i)=0;
                cgraph(i,m)=0;                
            end      
        end
   end 
end

end