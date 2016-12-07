# Social Media as a sentinel for disease surveillance: what does sociodemographic status have to do with it?

The code in this repository was used in analyzing the data presented in the paper *Social Media as a sentinel for disease surveillance: what does sociodemographic status have to do with it?* 

Code was written in R 3.2.2 and Python 3.4.3+

Users of this code should cite, Nsoesie EO, et al. Social Media as a Sentinel for Disease Surveillance: What Does Sociodemographic Status Have to Do with It?. PLOS Currents Outbreaks. 2016 Dec 5 . Edition 1. doi: 10.1371/currents.outbreaks.cc09a42586e16dc7dd62813b7ee5d6b6.). 

For questions, please contact Adyasha at adyasha@uw.edu or Elaine at en22@uw.edu or @ensoesie.

## Description of the Files

* **NBAnalysis.ipynb**: This jupyter notebook contains the code to run a linear Naive Bayes Classifier to classify tweets into 'sick' and 'junk' categories, and generate the statistics for performance of the classifier along with a list of the top 10 most significant terms

* **combineData.ipynb**: This jupyter notebook contains the code to combine two files, one containing the geographic location of a tweet and the other containing all other information about the tweet, related by a tweet-id. The output file is used for mapping the geo-spatial distribution of 'sick' tweets using R scripts present in the repository

* **mappingCode_new.R**: This R script contains the code the variables required to generate geo-spatial mappings of tweet distributions in three of the most populated states of Brazil: Sao Paulo, Minas Gerais and Rio Janeiro

* **spatial_plots.R**: This R Script generates Figure 1 from the paper i.e. the plot comparing Dengue Tweet Density and Actual Case Density among the three states: Sao Paulo, Minas Gerais and Rio Janeiro, using the variables saved by executing the script mappingCode_new.R

* **Boxplots.R**: This R script generates Figure 2 from the paper i.e. a comparison of distribution of relevant socio-demographic indices among social media users

* **Barplots_regression.R**: This R Script generates Figure 3 from the paper i.e. a time-series plot of actual dengue case and tweets counts, and a univariate regression model fitted to the time-series plots


