# R on Raspberry Pi running Raspbian Stretch
## Installation of R
Raspbian Stretch now comes with R version 3.3.3. To install it, just open a terminal and run:

```bash
sudo apt install r-base r-base-core r-base-dev
```

## Installation of of additional dependencies
Two further dependencies are required for the IRkernel installation to function:

```bash
sudo apt install libcurl4-gnutls-dev
sudo apt install libzmq3-dev
```

## Installation of the IRkernel
With R and dependencies in place, we can now start R and install the kernel:

```R
install.packages(c('crayon', 'pbdZMQ', 'devtools'))
devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))
IRkernel::installspec()
```
