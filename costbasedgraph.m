function cgraph=costbasedgraph(nofneighbors,cgraph,dgraph,EofNodes,N)
%nofneighbors(1,1:N)=1;

nexp=2; %bw 2 and 4

for i=1:N-1
    for j=1:N-1
        if dgraph(i,j)~=0 
             cgraph(i,j)=nofneighbors(1,i)*nofneighbors(1,j)*power(dgraph(i,j),nexp)/(EofNodes(1,i)+EofNodes(1,j));
        end
    end
end

for i=1:N-1
    if dgraph(N,i)~=0 
    cgraph(N,i)= nofneighbors(1,i)*power(dgraph(N,i),nexp)/EofNodes(1,i);
    end
end
for i=1:N-1
 if dgraph(i,N)~=0
     cgraph(i,N)=nofneighbors(1,i)* power(dgraph(i,N),nexp)/EofNodes(1,i);
 end
end

           
cgraph(N,N)=0;