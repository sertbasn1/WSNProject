function [paths,dsp,lsp]=simulation(round,topology,graph,range,x,y,receiver,adj,N,dgraph)
       opt=2;
       nexp=2;
       lsp=zeros(N,N);       
       paths=zeros(N,N-1); %routing paths are saved
        for j=1:N
            if topology(4,j)==0 %jth node is dead!
                continue;
            end
            sender=j;
            if sender~=receiver
                if opt==1
                   [dsp,sp]=fwalgorithm(adj,sender,receiver); %default fw algorithm
                else
                   [dsp,sp]=dijkstra(graph,sender,receiver); %default dijkstra algorithm
                end
                
                disp(sp);
                for m=1:size(sp,2)-1
                    lsp(j,m)=power(dgraph(sp(m),sp(m+1)),nexp);
                end
                               
                %disp(dsp);
                pcount=size(sp,2);
                if pcount~=0
                paths(1:pcount,sender)=sp(1,:);
                end
                
                if opt==1
                     paths(N,sender)=dsp(sender,receiver); 
                end
                if opt==2 %path cost u N. sat?ra yaz
                     paths(N,sender)=dsp;
                     for n=1:N-1
                         if isinf(paths(N,n))
                             paths(1:N-1,n)=0;
                         end
                     end
                end
              
     
                simNet(round,range,topology,x,y,N);             
                %marking related nodes
                for k=1:numel(sp)
                 node=sp(k);
                 n_X=topology(2,node);
                 n_Y=topology(3,node);
                 plot (n_X,n_Y,'bo','LineWidth',3 ,'MarkerEdgeColor', 'm','MarkerSize',6);
                end
                pause(1);
                hold off;
            end
        end
        
       
    
    