ssh root@<ip>
apt-get update
apt install r-base-core
git clone https://github.com/czeildi/erum-2018-clean-r-code.git
cd erum-2018-clean-r-code
git checkout infra
# or git pull if change since pull
# edit container num in infra/start_multiple_rstudio.R
R -f ./infra/start_multiple_rstudio.R

# on local machine:
# scp -R data root@ip:/home/rstudio

access your containers at <ip>:20001 ...
