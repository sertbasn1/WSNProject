function ratio = CheckCoverage(topology,N)
counter=0;

for i=1:N-1
    if topology(4,i)==0 %dead/unreachable node
        counter=counter+1;
    end
end

ratio= 100*((N-1-counter)./(N-1));
end

