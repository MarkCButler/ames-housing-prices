# ames-housing-prices
Data analysis and machine-learning prediction of sale price for the
[Ames Housing Dataset](http://www.amstat.org/publications/jse/v19n3/decock.pdf).

The analysis and predictions are reported in the R markdown file
*housing_prices.Rmd*.  The rendered html output is available at

https://markcbutler.github.io/ames-housing-prices/housing_prices.html

Two models are developed:

  - A multilinear model that aims to give insight into the housing market
    represented by the data set
  - A random-forest model that attempts to improve on the accuracy of the
    multilinear model

However, even after searches to optimize the feature set and hyperparameters,
the root-mean-square logarithmic error of the random-forest model for the test
data is 4.4% larger than that of the multilinear model.

The script *preprocess.R* was used to repair some inconsistencies in the data,
and the resulting log file *data_repair.log* is included in the repo.
Functions for K-fold target encoding of the categorical variables are defined
in the script *encode.R*.

Note that rendering the markdown file involves generating a large number of
plots, as well as a random forest of 5000 trees for a data set containing
24 predictors and about 1500 observations.
