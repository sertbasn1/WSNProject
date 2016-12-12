function simNet(round,R,topology,x,y,N)
    set(gca,'FontSize',8,'YGrid','off')
    xlabel('\it x \rm [m] \rightarrow')
    ylabel('\it y \rm [m] \rightarrow')
    xlim([0 x])
    ylim([0 y])
    plot(topology(2,:),topology(3,:),'ko','MarkerSize',5,'MarkerFaceColor','k');
    axis([0 x 0 y]);
    hold all;
    for j=1:numel(topology(1,:))
        for jTemp=1:numel(topology(1,:))
         X1=topology(2,j);
         Y1=topology(3,j);
         X2=topology(2,jTemp);
         Y2=topology(3,jTemp);
         xSide=abs(X2-X1);
         ySide=abs(Y2-Y1);
         d=sqrt(xSide^2+ySide^2);
         if (d<R)&&(j~=jTemp)
             vertice1=[X1,X2];
             vertice2=[Y1,Y2];
             plot(vertice1,vertice2,'-.k','LineWidth',0.1);
             hold all;
         end
        end
    end
    v=topology(1,:);
    vv=v';
    s=int2str(vv);
    text(topology(2,:)+0.4,topology(3,:)+0.4,s,'FontSize',8,'VerticalAlignment','Baseline');
    str2 = sprintf('Step %d simulation of sending data to Sink(node %d)',round,N);
    title(str2);
    hold all;