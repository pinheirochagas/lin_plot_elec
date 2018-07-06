function el_add(els,elcol,makerType,msize,subplotNum)
    
if ~exist('msize','var')
    msize=20; %marker size
end

if exist('elcol')==0, 
    elcol='r'; %default color if none input
end

subplot(subplotNum(1),subplotNum(2),subplotNum(3))
hold on
%plot3(els(:,1),els(:,2),els(:,3),'Marker', makerType,'Color', elcol,'MarkerSize',msize, 'MarkerFaceColor',elcol, 'MarkerEdgeColor', 'none')
plot3(els(:,1),els(:,2),els(:,3),'Marker', makerType,'Color', elcol,'MarkerSize',msize, 'MarkerFaceColor',elcol)

%hold on, plot3(els(:,1),els(:,2),els(:,3),'o','MarkerFaceColor', elcol,'MarkerSize',msize,'MarkerEdgeColor', edgcol,'LineWidth',1)