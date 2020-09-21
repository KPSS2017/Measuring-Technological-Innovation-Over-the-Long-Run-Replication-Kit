clear

clc

addpath('C:\Utilities\Matlab')

cd('E:\ReplicationCode\figures\')

% Import the csv file
csv_data = importdata('Fig_IndInnovationLR.csv');
index = csv_data.data(:,2:end);
year = csv_data.data(:,1);
name = csv_data.colheaders';
name = name(2:end, 1);

% Add the industry labels
name{1,1} = 'Agriculture, Food';
name{2,1} = 'Mining, Extraction';
name{3,1} = 'Utilities';
name{4,1} = 'Construction';
name{5,1} = 'Furniture, Textiles, Apparel';
name{6,1} = 'Wood, Paper, Printing';
name{7,1} = 'Petroleum, Coal';
name{8,1} = 'Chemical Manufacturing';
name{9,1} = 'Plastics, Rubber';
name{10,1} = 'Mineral Processing';
name{11,1} = 'Metal Manufacturing';
name{12,1} = 'Machinery Manufacturing';
name{13,1} = 'Computers, Electronics';
name{14,1} = 'Electrical Equipment';
name{15,1} = 'Transportation Equipment';
name{16,1} = 'Medical Equipment';

% Save the data into a matlab file 
save('TS-industry-data','index','name','year');


load('TS-industry-data')
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 

%**************************************************************************
% Stacked area plots
%**************************************************************************

% Order by time of peak
[~,ix]  = max(index);
[~,ix1] = sort(ix,'ascend');
index   = index(:,ix1);
name    = name(ix1);

% Combine small indices into 'other'
figure1 = figure;
axes1   = axes('Parent',figure1);
mi      = max(index);
smi     = sort(mi);
smix	= find(mi<smi(9));
nsmix	= find(mi>=smi(9));
index1  = sum(index(:,smix),2);
index2  = index(:,nsmix);
name2   = name(nsmix);
name3   = [name2(1:4); {'Other'} ; name2(5:end)];
index3  = [index2(:,1:4) index1 index2(:,5:end)];
clear index1 index2 name1 name2

% Area plot
h       = area(index3./sum(index3,2));

% Select colors
h(1).FaceColor = [0 0 1];
h(2).FaceColor = [0 0.5 1];
h(3).FaceColor = [0 0.75 1];
h(4).FaceColor = [0 1 1];
h(5).FaceColor = [.8 .8 .8];
h(6).FaceColor = [0.95 0.95 0];
h(7).FaceColor = [0.95 0.66 0];
h(8).FaceColor = [0.95 0.33 0];
h(9).FaceColor = [0.95 0 0];

% Rotate plot vertical
view(90,90)
axis tight

% Add year labels
xticks = get(gca,'xtick');
xticks = xticks+1;
set(gca,'xticklabels',year(xticks),'fontname','timesnewroman','ytick',[])
set(gcf,'position',[360     1   400   697])

% Add industry labels
% text(1:5:5*length(name3)', .1:.1:.1*length(name3)', name3);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman','String',{'Wood, Paper,','Printing'},...
    'Position',[10.7645924218846 0.0828675364468683 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String',{'Machinery','Manufacturing'},'Position',[46.291495893383 0.202974406049254 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String',{'Transportation','Equipment'},'Position',[64.1125720972257 0.295453368146072 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String',{'Chemical','Manufacturing'},'Position',[98.7559482528205 0.177294766785913 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String','Other','Position',[77.7902947798448 0.485185276425703 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String','Plastics, Rubber','Position',[114.217706877603 0.593054618479328 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman','String',{'Electrical','Equipment'},...
    'Position',[92.368137736211 0.717934722016394 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman','String',{'Agriculture,','Food'},...
    'Position',[17.7976169805651 0.878006329179035 -1.4210854715202e-14]);
text('Parent',axes1,'HorizontalAlignment','center','FontName','timesnewroman',...
    'String','Computers, Electronics','Position',[154.641133910025 0.687826180385587 -1.4210854715202e-14]);
set(gca,'fontname','timesnewroman')
legend('hide') 
return
matlab2tikz('IndustryInnovationComposition.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);

 
% Save

saveas(gcf,'IndustryInnovationComposition', 'pdf')
 
%**************************************************************************
% Individual time series plots
%**************************************************************************

clear

load('TS-industry-data')

%name = {{'Computers,','Electronics'};{'Agriculture,','Food'};{'Medical','Equipment'};{'Chemical','Manufacturing'};{'Plastics, Rubber'};{'Electrical','Equipment'};{'Mining','Extraction'};{'Petroleum','Coal'};{'Metal','Manufacturing'};{'Mineral','Processing'};{'Utilities'};{'Furniture,','Textiles, Apparel'};{'Wood, Paper,','Printing'};{'Machinery','Manufacturing'};{'Transportation','Equipment'};{'Construction'}}

% Order by time of peak
[~,ix]  = max(index);
[~,ix1] = sort(ix,'descend');
index   = index(:,ix1);
name    = {name{ix1,:}}';

% Standardize series
index   = zscore(index);

% Separate vertically
yticks   = ones(size(name));
for i=1:size(index,2)
    index(:,i)  = index(:,i) + 5*i;
    yticks(i)    = 5*i;
end
set(gcf,'position',[360     1   400   697])

% Plot time series
plot(index,'-b','linewidth',2)
axis tight

% Add year labels
xticks = get(gca,'xtick');
xticks = xticks+1;
set(gca,'ytick',yticks,'yticklabels','','xticklabels',year(xticks),'fontname','timesnewroman')

% Add industry labels
text(-38+zeros(size(name)),5:5:5*length(name)', name, 'fontname','timesnewroman');

% Save
saveas(gcf,'StackPlotIndustry', 'eps2c')
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 

legend('hide') 
matlab2tikz('StackPlotIndustry.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
