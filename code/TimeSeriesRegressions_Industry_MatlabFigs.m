close all
clear
 addpath('C:\Utilities\Matlab')
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 

tmp1 = cell(0);
tmp1{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp1{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp1{3} = 'axis lines=left';   
tmp1{4} = 'scaled y ticks=false'; 
tmp1{5} = 'xtick={-2,0,3},'; 
tmp1{6} = 'xticklabels={Pre,0,Post},'; 


color{1}=[0.00000 0.44700 0.74100];
color{2}=[0.85000 0.32500 0.09800];
SEbounds=1.67;

adjH = [3 2 1 1 1:5]';
 

figure(1)
oA=['E:\ReplicationCode\figures\ind_tfp_naics4.csv' ];
oAa=csvimport(oA); 
SR=5;
SC=2;
ER=size(oAa,1);
EC=9;
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
bK  = [100*tA(1,1:3)';0; 100*tA(1,4:8)']./adjH;
seK = [100*tA(2,1:3)';0; 100*tA(2,4:8)']./adjH;
TT= [-3 -2 -1 0:K]';

s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 5]);xlabel('Years (h)');
legend('hide')

matlab2tikz('E:\ReplicationCode\figures\FigNAICS_q10_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);

 



tA=[];
figure(2)
oA=['E:\ReplicationCode\figures\\ind_tfp_kendrick.csv' ];
oAa=csvimport(oA); 
SR=3;
SC=2;
ER=4;
EC=3;
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
bK  = [100*ones(3,1)*tA(1,1);0; 100*ones(5,1)*tA(1,2)] ;
seK = [100*ones(3,1)*tA(2,1);0; 100*ones(5,1)*tA(2,2)];
bK  = [100*ones(1,1)*tA(1,1);0; 100*ones(1,1)*tA(1,2)] ;
seK = [100*ones(1,1)*tA(2,1);0; 100*ones(1,1)*tA(2,2)];


TT= [ -2 0  3]';
s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 5]);xlabel('Years (h)');
legend('hide')

matlab2tikz('E:\ReplicationCode\figures\FigKendrick.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp1,'parseStrings',false);


figure(3)
oA=['E:\ReplicationCode\figures\ind_tfp_naics4_cites.csv' ];
oAa=csvimport(oA); 
SR=5;
SC=2;
ER=size(oAa,1);
EC=9;
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
bK  = [100*tA(3,1:3)';0; 100*tA(3,4:8)']./adjH;
seK = [100*tA(4,1:3)';0; 100*tA(4,4:8)']./adjH;
TT= [-3 -2 -1 0:K]';

s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 5]);xlabel('Years (h)');
legend('hide')
 

matlab2tikz('E:\ReplicationCode\figures\FigNAICS_cites.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);


tA=[];
figure(4)
oA=['E:\ReplicationCode\figures\ind_tfp_kendrick_cites.csv' ];
oAa=csvimport(oA); 
SR=3;
SC=2;
ER=4;
EC=3;
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
bK  = [100*ones(3,1)*tA(1,1);0; 100*ones(5,1)*tA(1,2)] ;
seK = [100*ones(3,1)*tA(2,1);0; 100*ones(5,1)*tA(2,2)];
bK  = [100*ones(1,1)*tA(1,1);0; 100*ones(1,1)*tA(1,2)] ;
seK = [100*ones(1,1)*tA(2,1);0; 100*ones(1,1)*tA(2,2)];


TT= [ -2 0  3]';
s = shadedErrorBar(TT,bK,SEbounds*seK,'lineprops','b','patchSaturation',0.1);
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
hold on;
plot([-3.5 5],0*[-3.5 55],'k--'); ylabel('\%')
s.patch.FaceColor = color{1};
errorbar(TT,bK,0*seK,'-s','MarkerSize',4,...
    'MarkerEdgeColor','black','MarkerFaceColor','black','Color',color{1},'LineWidth',0.8)
hold off;
xlim([-3.5 5]);xlabel('Years (h)');
legend('hide')

matlab2tikz('E:\ReplicationCode\figures\FigKendrick_cites.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp1,'parseStrings',false);





 


