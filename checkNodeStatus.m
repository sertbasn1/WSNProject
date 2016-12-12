function topology=checkNodeStatus(deadTresh,topology,EofNodes,N)

for i=1:N-1
    if le(EofNodes(1,i),deadTresh)
        topology(4,i)=0;
        fprintf('Node %d dead\n',i);
   end 
end

end

