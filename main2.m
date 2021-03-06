%
% CMPE524_Computer Network Architecture
% Energy Efficient Routing in wireless sensor networks Project
% Nurefsan Sertbas #2016700132
% November 2016

function [EofNodes,fij,graph]=main2(x,y,N,receiver,sense_range,topology,Einit,Etx,Erx,treshold,termRatio,deadTresh,out)
%for distance based routing 
tic;
out=0; %number of nodes has no any node/sink in its sensing range

fprintf('Simulation has been started with %d nodes\n',N-1);
fprintf('Creating topology..\n');

% initial calculations
EofNodes=zeros(1,N-1);%energy initialization of N-1 nodes 
EofNodes(1:N-1)=Einit;
fij=zeros(4,N); %transmission reception counters
fij(1,1:N)=1:N;


%plot the network
fprintf('Network visualizing...\n');
figure(1);
str1 = sprintf('Network Topology with %d nodes, %dm sensing range\n',N-1,sense_range);
title(str1);
adj=printNet(sense_range,topology,x,y); %returns with adjacency of nodes according to sensing range

%distance based graph
dgraph=zeros(N,N);
        len=size(adj,1);
        for i=1:len
          dgraph(adj(i,1),adj(i,2))=adj(i,3);
        end

% start simulation
i=0;
while 1
    i=i+1;
    X = ['** Round ',num2str(i),' **'];
    disp(X);
    figure(2);
    
    fij(4,:)=0;
    [paths,dsp,lsp]=simulation(i,topology,dgraph,sense_range,x,y,receiver,adj,N,dgraph);
    disp(EofNodes);
    for b=1:N-1
           if isinf(paths(N,b))==0
               ncol=paths(:,b);
               col=ncol(ncol~=0);
               for j=1:size(col,1)-1
                   node=col(j,1);
                    if j==1 %rx
                        fij(3,node)=fij(3,node)+1;
                    elseif j==size(col,1)-1  %tx
                        fij(2,node)=fij(2,node)+1;
                    else
                       fij(2,node)=fij(2,node)+1;
                       fij(3,node)=fij(3,node)+1;
                    end
               end
           end
    end
    
    %check unreachable nodes only for the first time of the execution
    if i==1
        for s=1:N-1
            if fij(2,s)==0 && fij(3,s)==0
                topology(4,s)=0;
                out=out+1;
                fprintf('Node %d is out of the range (no communication)\n',s);
            end
        end
    end
    
    
%     %residiual energy must be updated
%     for k=1:N-1
%     EofNodes(1,k)= EofNodes(1,k)- Etx*fij(2,k)- Erx*fij(3,k);
%     if le(EofNodes(1,k),deadTresh)
%         EofNodes(1,k)=deadTresh;
%     end
%     end
    
    for es=1:N-1
        el=1;
        while paths(el,es)~=N
            if paths(el,es)~=0
            fij(4,paths(el,es))=fij(4,paths(el,es))+lsp(es,el);  
            else
             break;
            end
            el=el+1;
        end
    end
    
    %residiual energy must be updated
    for k=1:N-1
    EofNodes(1,k)= EofNodes(1,k)- Etx*fij(4,k)- Erx*fij(3,k);
    if le(EofNodes(1,k),deadTresh)
        EofNodes(1,k)=deadTresh;
    end
    end
    
    %dead/active nodes are checked and dead nodes are deleted from the graph   
    [topology]=checkNodeStatus(deadTresh,topology,EofNodes,N);
   
    %updateNodeStatus
        for n=1:N-1
            if topology(4,n)==0
        %delete the dead node(i) links
                for m=1:N
                    if dgraph(m,n)~=0
                       dgraph(m,n)=0;
                       dgraph(n,m)=0;                
                    end      
                end
            end 
        end

    %if the coverage decreaces to the given ratio means that nw is dead. 
    %end of the simulation
    ratio=CheckCoverage(topology,N);
    
    if (ratio<termRatio) %nw dead!
        fprintf('\n\n');
        fprintf('****End of the simulation****\n');
        fprintf('Num of living nodes %d out of %d, after %d rounds\n',ratio/(N-1),N-1,i);
        fprintf('Num of nodes out of the coverage is %d\n', out);
        active=N-1-out;
        fprintf('Simulation has been done with %d active nodes\n',active );
        EofNodes=ConsumedEnergy(Einit,deadTresh,EofNodes,topology,N,active);
        fprintf('**** **** **** **** **** ****\n\n');
        break;
    end
    
 end
 
     %bar plot for total exchanged messages
        figure(3);
        %fij(4,:) output olarak tx rx toplam?n? g?sterisn
        fij(4,:) = fij(2,:)+ fij(3,:);
        bar(fij(4,1:N-1));
        set(gca,'FontSize',10,'YGrid','off','YGrid','on','XLim',[0 N],'XMinorTick','on');
        xlabel('Node id');
        ylabel('Number of total messages');
        str3 = sprintf('Total number of received and transmitted messages for each node');
        title(str3);
        hold on;
       
         if i==1
                EperRound(1,i)=(N-1)*Einit-sum(EofNodes);
         else
                EperRound(1,i)=(N-1)*Einit-sum(EofNodes);
                EperRound(1,i)=EperRound(1,i)-EperRound(1,i-1);
         end
        
        fprintf('Total number of received messages by sink is %d\n', fij(4,N));
       % disp(EperRound);
  
graph=0;
toc;

end
