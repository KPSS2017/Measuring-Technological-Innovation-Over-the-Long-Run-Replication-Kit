close all
clear
  
tmp = cell(0);
tmp{1} = 'xticklabel style={/pgf/number format/1000 sep={}}';  % this is important to prevent scientific format
tmp{2} = 'yticklabel style={/pgf/number format/fixed}';  % for numbers along the tick marks
tmp{3} = 'axis lines=left';   
tmp{4} = 'scaled y ticks=false'; 

cd E:\ReplicationCode

clear
load input_data\CollapsedSimilarity

 

 
figure(1)
plot(SimilarityCDF(:,1)/1000,SimilarityCDF(:,3),'k-');xlabel('Cosine Similarity');title('Empirical CDF'); legend('hide')
matlab2tikz('figures\SimilarityCDF.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
 
figure(2)
semilogy(MeanCitesBySimilarity(:,1)/1000,MeanCitesBySimilarity(:,2),'k.');xlabel('Cosine Similarity');ylabel('Probability of Citation'); legend('hide')
matlab2tikz('figures\ProbCite_bySimilarity.tikz','height', '\fheight', ...
    'width', '\fwidth','showInfo', false,...
    'extraAxisOptions',tmp,'parseStrings',false);
 
 

