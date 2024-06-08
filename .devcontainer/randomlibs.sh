#!/bin/bash -xe

## Make updates for Java & R
sudo apt-get update -y
sudo apt-get upgrade -y

## install some Java Deps
sudo apt-get install -y libxi6 
sudo apt-get install -y libxtst6

## install cool Rlibs that did not work using devcontainer features
sudo apt-get install -y r-cran-crayon r-cran-e1071 r-cran-forecast r-cran-hexbin r-cran-htmltools r-cran-htmlwidgets r-cran-randomforest r-cran-rcurl r-cran-rmarkdown r-cran-rodbc r-cran-rsqlite 
sudo apt-get install -y r-cran-tidyverse r-cran-tidymodels r-cran-nycflights23