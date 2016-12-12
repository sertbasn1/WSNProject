function nodes = create_topology(N,x,y)
%N number of nodes
%x Width of the grid
%y Height of the grid
%%%%%%%%%%%%%%%%%%%%%%%%%

sink(1,1) =1;
% sink(2,1) = x.*rand(1,1);
% sink(3,1) = y.*rand(1,1);
sink(2,1) = x/2;
sink(3,1) = y/2;

%x and y cordinates
nodes(1,1:N-1)=(1:N-1);
nodes(2,1:N-1) = x.*rand(N-1,1);
nodes(3,1:N-1) = y.*rand(N-1,1);

nodes(1,N)=N;
nodes(2,N)=sink(2,:);
nodes(3,N)=sink(3,:);

nodes(4,1:N)=1; %all nodes are living
end

