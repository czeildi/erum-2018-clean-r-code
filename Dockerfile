FROM rocker/tidyverse:3.4

RUN R -e "install.packages('plotly')"

COPY infra/mkusers.sh /home/mkusers.sh
COPY infra/users.csv /home/users.csv

RUN /home/mkusers.sh

RUN mkdir -p /home/erum-project

COPY erum-2018-clean-r-code.Rproj /home/erum-project/erum-2018-clean-r-code.Rproj
COPY home_location.R /home/erum-project
COPY R /home/erum-project/R

RUN chmod -R 777 /home/erum-project
