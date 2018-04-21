apt-get install update
apt install r-base-core
git clone https://github.com/czeildi/erum-2018-clean-r-code.git
git checkout infra
# or git pull if change since pull

# docker pull czeildi/erum-clean-r-code
R -f erum-2018-clean-r-code/infra/start_multiple_rstudio.R
