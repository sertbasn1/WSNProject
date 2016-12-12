function adj=printNet(range,nodes,x,y)
    set(gca,'FontSize',8,'YGrid','off')
    xlabel('\it x \rm [m]')
    ylabel('\it y \rm [m]')
    xlim([0 x])
    ylim([0 y])
    hold on;
    plot(nodes(2,:),nodes(3,:),'r*','MarkerSize',7,'MarkerFaceColor','k');
    plot(nodes(2,end),nodes(3,end),'mo','MarkerSize',9,'MarkerFaceColor','k');
    
    rd=1;
    hold on;
    for j=1:numel(nodes(1,:))
        for jTemp=1:numel(nodes(1,:))
         X1=nodes(2,j);
         Y1=nodes(3,j);
         X2=nodes(2,jTemp);
         Y2=nodes(3,jTemp);
         xSide=abs(X2-X1);
         ySide=abs(Y2-Y1);
         d=sqrt(xSide^2+ySide^2);
         if (d<range)&&(j~=jTemp)
             vertice1=[X1,X2];
             vertice2=[Y1,Y2];
             plot(vertice1,vertice2,'-.b','LineWidth',0.3);
             adj(rd,1)=j;
             adj(rd,2)=jTemp;
             adj(rd,3)=d;
             rd=rd+1;
             hold all;
         end
         
        end
    end
    v=nodes(1,:);
    vv=v';
    s=int2str(vv);
    text(nodes(2,:)+0.4,nodes(3,:)+0.4,s,'FontSize',8,'VerticalAlignment','Baseline');
    hold all;
