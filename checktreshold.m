function [ status ] = checktreshold( Einit,EofNodes,nodes,treshold )

if ge((Einit-EofNodes(1,nodes)),treshold*Einit/100)==1 
status=1;%just transmit
else
    status=0; %transmit and receive
end
end

