FROM rocker/tidyverse:3.4

RUN R -e "install.packages('plotly')"

RUN mkdir -p /home/rstudio/erum-project


COPY erum-2018-clean-r-code.Rproj /home/rstudio/erum-project/erum-2018-clean-r-code.Rproj
COPY home_location.R /home/rstudio/erum-project
COPY R /home/rstudio/erum-project/R

RUN chown -R rstudio:rstudio /home/rstudio/erum-project
