close all
clear
  
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 

oAa=csvread('E:\ReplicationCode\intermediate_data\important_patents.csv',1,0); 

color{1}=[0.00000 0.44700 0.74100];
color{2}=[0.85000 0.32500 0.09800];
color{3}=[0.92900 0.69400 0.12500]; 

urank_lrfsim05  = oAa(:,1);
rank_rrfsim05   = oAa(:,2);
urank_lrfsim010 = oAa(:,3);
rank_rrfsim010  = oAa(:,4);
urank_lfcit05   = oAa(:,5);
rank_rlfcit05   = oAa(:,6);
urank_lfcit010  = oAa(:,7);
rank_rlfcit010  = oAa(:,8);
urank_fcitA     = oAa(:,9);
rank_fcitA      = oAa(:,10);

crank_lrfsim05  = oAa(:,11);
crank_lrfsim010 = oAa(:,12);
crank_lfcit05   = oAa(:,13);
crank_lfcit010  = oAa(:,14);
crank_fcitA     = oAa(:,15);

lrfsim05=urank_lrfsim05;
lfcit05=urank_lfcit05; 

N=length(urank_lrfsim05);
TableOut=zeros(6,5);

TableOut(1,1:5)=[mean(urank_lrfsim05)  mean(urank_lrfsim010) mean(urank_lfcit05) mean(urank_lfcit010)  mean(urank_fcitA) ];
TableOut(2,1:5)=[std(urank_lrfsim05)/sqrt(N)  std(urank_lrfsim010)/sqrt(N) std(urank_lfcit05)/sqrt(N) std(urank_lfcit010)/sqrt(N)  std(urank_fcitA)/sqrt(N) ];

TableOut(3,1:5)=[mean(rank_rrfsim05) mean(rank_rrfsim010) mean(rank_rlfcit05) mean(rank_rlfcit010)  mean(rank_fcitA) ];
TableOut(4,1:5)=[std(rank_rrfsim05)/sqrt(N) std(rank_rrfsim010)/sqrt(N) std(rank_rlfcit05)/sqrt(N)  std(rank_rlfcit010)/sqrt(N)  std(rank_fcitA)/sqrt(N) ];

TableOut(5,1:5)=[mean(crank_lrfsim05) mean(crank_lrfsim010)  mean(crank_lfcit05) mean(crank_lfcit010)  mean(crank_fcitA) ];
TableOut(6,1:5)=[std(crank_lrfsim05)/sqrt(N) std(crank_lrfsim010)/sqrt(N) std(crank_lfcit05)/sqrt(N)  std(crank_lfcit010)/sqrt(N)  std(crank_fcitA)/sqrt(N) ]

 
 

figure(1);
histogram([urank_lrfsim010],'BinWidth',0.025,'Normalization','probability');xlim([0 1]) ; hold on;
histogram([urank_fcitA],'BinWidth',0.025,'Normalization','probability'); xlim([0 1]) 
hold off;
legend('hide');
matlab2tikz('E:\ReplicationCode\figures\important_patents_urank2.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);


figure(2);
histogram([rank_rrfsim010],'BinWidth',0.025,'Normalization','probability');xlim([0 1]) ; hold on;
histogram([rank_fcitA],'BinWidth',0.025,'Normalization','probability');  xlim([0 1])
hold off;
legend('hide');
matlab2tikz('E:\ReplicationCode\figures\important_patents_rankFE2.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);


figure(3);
histogram([crank_lrfsim010],'BinWidth',0.025,'Normalization','probability');xlim([0 1]) ; hold on;
histogram([crank_fcitA],'BinWidth',0.025,'Normalization','probability');xlim([0 1])  
hold off;
legend('hide');
matlab2tikz('E:\ReplicationCode\figures\important_patents_crank2.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);

 
