function [x,y,N,receiver,sense_range,topology,Einit,Etx,Erx,treshold,termRatio,deadTresh,out] = Setup()

%% Topology specification
x=30;
y=30;
N=21;   %number of nodes+1(sink)
receiver=N; %sink 
sense_range=20;
topology=create_topology(N,x,y);


%% parameter initialization
Einit=0.5;%joule
Etx=2*power(10,-5);%joule/packet
Erx=power(10,-5);%joule/packet

treshold=60; %battery
termRatio=80; %if coverage decreases below that finish simulation

deadTresh=3*power(10,-5);% treshold to evaluate node as dead
out=0;

end

