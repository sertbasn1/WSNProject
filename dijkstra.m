function [cost,path] = dijkstra(graph,s,d)
if s==d
    cost=0;
    path=s;
else

for i=1 : size(graph,1)
    for j=1 :size(graph,1)
        if graph(i,j)==0
            graph(i,j)=inf;
        end
    end
end

tmp=graph(:,1);
graph(:,1)=graph(:,s);
graph(:,s)=tmp;

tmp=graph(1,:);
graph(1,:)=graph(s,:);
graph(s,:)=tmp;


lengthA=size(graph,1);
W=zeros(lengthA);
for i=2 : lengthA
    W(1,i)=i;
    W(2,i)=graph(1,i);
end

for i=1 : lengthA
    D(i,1)=graph(1,i);
    D(i,2)=i;
end

D2=D(2:length(D),:);
path=2;
while path<=(size(W,1)-1)
    path=path+1;
    D2=sortrows(D2,1);
    k=D2(1,2);
    W(path,1)=k;
    D2(1,:)=[];
    for i=1 : size(D2,1)
        if D(D2(i,2),1)>(D(k,1)+graph(k,D2(i,2)))
            D(D2(i,2),1) = D(k,1)+graph(k,D2(i,2));
            D2(i,1) = D(D2(i,2),1);
        end
    end
    
    for i=2 : length(graph)
        W(path,i)=D(i,1);
    end
end
if d==s
    path=[1];
else
    path=[d];
end
cost=W(size(W,1),d);
path = listdijkstra(path,W,s,d);

path=fliplr(path);
[~, idxs, ~] = unique(path, 'first');
path = path(sort(idxs));


end