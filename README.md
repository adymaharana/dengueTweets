# Social Media as a sentinel for disease surveillance: what does sociodemographic status have to do with it?

The data and code in this repository allows users to replicate results and generate figures appearing in the main text of the paper *Social Media as a sentinel for disease surveillance: what does sociodemographic status have to do with it?* 

Code was written in R 3.2.2 and Python 3.4.3+

Users of this data should cite Nsoesie, Elaine, et. al. (2017). If you find a consequential error, please email Adyasha at adyasha@uw.edu

## Description of the Files

* NBAnalysis.ipynb: This jupyter notebook contains the code to run a linear Naive Bayes Classifier to classify tweets into 'sick' and 'junk' categories, and generate the statistics for performance of the classifier along with a list of the top 10 most significant terms

* combineData.ipynb: This jupyter notebook contains the code to combine two files, one containing the geographic location of a tweet and the other containing all other information about the tweet, related by a tweet-id. The output file is used for mapping the geo-spatial distribution of 'sick' tweets using R scripts present in the repository

* mappingCode_new: This R script contains the code to generate geo-spatial mappings of tweet distributions in three of the most populated states of Brazil: Sao Paulo, Mineas Gerais and 


