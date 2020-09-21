close all
clear
addpath('C:\Utilities\Matlab')
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 


color{1}=[0.00000 0.44700 0.74100];
color{2}=[0.85000 0.32500 0.09800];
 

SEbounds=1.67;

 


adjH = [3 2 1 1 1:10]';



figure(1)
oA=['E:\ReplicationCode\figures\AggTFP_NW_New_v201907.csv' ];
oAa=csvimport(oA); 
SR=3;
SC=2;
ER=4;
EC=14;
for i=1:ER-SR+1
    for j=1:EC-SC+1
        
        if ischar(cell2mat(oAa(SR-1+i,SC-1+j)))==1
         t1= str2num(cell2mat(oAa(SR-1+i,SC-1+j)));
        else
         t1=  cell2mat(oAa(SR-1+i,SC-1+j));
            
        end

        
        if isempty(t1)

             tA(i,j)=NaN;
 
        else

             tA(i,j)=str2num(t1);
 

            
        end
    end
end
K=5;
bK  = [100*tA(1,1:3)';0; 100*tA(1,4:13)']./adjH;
seK = [100*tA(2,1:3)';0; 100*tA(2,4:13)']./adjH;
TT= [-3 -2 -1 0:10]';



s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 10],0*[-3 10],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 10]);xlabel('Years (h)');
legend('hide')
matlab2tikz('E:\ReplicationCode\figures\AggTFP_NW_New_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);




 
 
 
figure(2)
oA=['E:\ReplicationCode\figures\AggTFP_NW_Old_v201907.csv' ];
oAa=csvimport(oA); 
SR=3;
SC=2;
ER=4;
EC=14;
for i=1:ER-SR+1
    for j=1:EC-SC+1
        
        if ischar(cell2mat(oAa(SR-1+i,SC-1+j)))==1
         t1= str2num(cell2mat(oAa(SR-1+i,SC-1+j)));
        else
         t1=  cell2mat(oAa(SR-1+i,SC-1+j));
            
        end

        
        if isempty(t1)

             tA(i,j)=NaN;
 
        else

             tA(i,j)=str2num(t1);
 

            
        end
    end
end
K=5;
bK  = [100*tA(1,1:3)';0; 100*tA(1,4:13)']./adjH;
seK = [100*tA(2,1:3)';0; 100*tA(2,4:13)']./adjH;
TT= [-3 -2 -1 0:10]';
s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 10],0*[-3 10],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 10]);xlabel('Years (h)');
legend('hide')
matlab2tikz('E:\ReplicationCode\figures\AggTFP_NW_Old_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);




