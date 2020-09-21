close all
clear
  
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 



 

T=readtable('E:\ReplicationCode\Figures\time_series_measures_compare.csv'); 


year = T.year;
Breakthrough_cites10_pc = T.Breakthrough_cites10_pc/1000;
Breakthrough_pc = T.Breakthrough_pc/1000;
npats_pc =T.npats_pc*1000;
kpss = log(T.kpss) +6;
Breakthrough_citesA_pc = T.Breakthrough_citesA_pc/1000;



f1=figure(1)
f1.PaperOrientation='landscape';

plot(year,npats_pc,'k','Linewidth',1.15);xlabel('year');ylabel('\# of patents per 1000 people');xlim([1840 2010]); legend('hide')
matlab2tikz('E:\ReplicationCode\Figures\Fig_npats_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
 
 
 


f2=figure(2)
f2.PaperOrientation='landscape';

plot(year, Breakthrough_cites10_pc,'k','Linewidth',1.15);hold on;
plot(year, Breakthrough_citesA_pc,'b','Linewidth',1.15);hold off
ylabel('\# of breakthrough patents per 1000 people');xlabel('year');xlim([1830 2010]);  legend('hide')

matlab2tikz('E:\ReplicationCode\Figures\Fig_QualityC_both_pc_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);

 
    

f3=figure(3)
f3.PaperOrientation='landscape';

plot(year,kpss,'k','Linewidth',1.15);xlabel('year');ylabel('KPSS Index, log');xlim([1830 2010]); legend('hide')
matlab2tikz('E:\ReplicationCode\Figures\Fig_kpss_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
 
 
f4=figure(4)
f4.PaperOrientation='landscape';

plot(year,Breakthrough_pc,'k','Linewidth',1.15);ylabel('\# of breakthrough patents per 1000 people');xlabel('year');;xlim([1830 2010]);  legend('hide')
matlab2tikz('E:\ReplicationCode\Figures\Fig_Quality_pc_v201910.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
 
 
 