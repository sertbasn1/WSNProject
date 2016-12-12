function EofNodes = ConsumedEnergy(Einit,deadTresh,EofNodes,topology,N,active)

cons=zeros(1,N-1);

for i=1:N-1
   if topology(4,i)==1  %aktif enrrji harcam?s node
       cons(1,i)=Einit-EofNodes(1,i);
   elseif topology(4,i)==0 %dead olabilir/range d?s?nda olabilir
       if EofNodes(1,i)< Einit  %dead
          cons(1,i)=Einit-deadTresh;
       end
   end 
end

consumed=sum(cons);
fprintf('Total consumed energy in network: %.4f\n',consumed);
fprintf('Consumed energy per sensor: %.4f\n',consumed./active);


end

