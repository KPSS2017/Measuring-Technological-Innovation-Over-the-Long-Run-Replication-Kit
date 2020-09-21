# Replication Code and Data for Kelly, B., Papanikolaou, D., Seru, A. and Taddy, M., 2020 AERI Forthcoming 

This package provides the replication code for the main results in **Kelly, B., Papanikolaou, D., Seru, A. and Taddy, M., 2020. Measuring Technological Innovation Over the Long Run.  Forthcoming, American Economic Review: Insights** The paper is available at https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3286887.

The folder ./code contains all programs, while the folder ./input_data includes all needed input data files. 

## Code 

The folder ./code includes code files of two types of programs: Stata and Matlab. 

#### Preliminaries:

Please complete the following steps in this order:

1. The file **winsorizeJ.ado** is program which allows for winsorizing the data by groups (here, year). It should be copied to your personal ado directory.

2. The file **CreateMergedData.do** creates a merged dataset that is needed to run the patent-level regressions.

3. The file **IdentifyBreakthroughPatents.do** identifies a set of breakthrough patents and outputs the data to an intermediate file named "Breakthrough_Patents.dta". 

4. The files **Create_Innovation_Indices_NAICSx.do** take the input above and create the time-series indices at the Naics x-digit level. Note: the 5-digit and 6-digit files use the 1997 NAICS definitions, to better match to Kendrick's definition of industries. 

5. The file **Create_Innovation_Indices_Agg.do** creates aggregate innovation indices.

#### Paper Figures and Tables:

1. To create Figure 1, run the matlab file **CreatePlotsSimilarityCites.m**

2. To create Figure 3A and 3B and Tables A2 and A3: 

	a. Run the files  **patent_level_figs_CITES.do** and **patent_level_figs_KPSS.do** for the figures 
	
	b. Run the files **patent_level_regressions_CITES.do** and **patent_level_regressions_KPSS.do** for the regressions

3. To create Figure 4, run the matlab file **TSaggplot.m**

4. To create Figure A4 and A5, do the following in sequence:

	a. Run the file **Innovation_Productivity_NAICS4.do** for the industry productivity regressions
	
	b. Run the matlab file **TimeSeriesRegressions_Industry_MatlabFigs.m** to generate tikz plots for Figures A.4 and A.5 in the Appendix

5. To create Figure 5, do the following in sequence:

	a. Run the file **CreateIndustryPlots.do** to aggregate the industries at a relatively coarse level; it generates as outputs "Fig_IndInnovationLR.csv"
	
	b. Run the matlab file **TSindustryplot.m** to generate Figure 5 in the paper

6. To create Table A.1 and Figure A.1, follow these steps in sequence:

	a. Run the file **HistoricallyImportantPatents_List.do** to generate an intermediate output file named "important_patents_list.csv" which contains the list of patents in Table A.1
	
	b. Run the matlab file **Hist_Important_Patents_Fig.m** to generate Figure A.1 in the Appendix

7. To generate Figure A.2, run the file **BreakthroughInnovation_by_TechClass.do**

8. To generate Figure A.3, running the file **Aggregate_productivity_regs.do** first and then run the matlab file **TimeSeriesRegressions_MatlabFigs.m**

## Contact

Please contact Dimitris Papanikolaou (d-papanikolaou@kellogg.northwestern.edu) or Amit Seru (aseru@stanford.edu) for any questions regarding the codes or data.

**Please see the paper for more information on the codes and data. If you use these codes files or data, please CITE this paper as the source.**
