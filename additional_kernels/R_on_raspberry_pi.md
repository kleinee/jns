
# Installing R on a Raspbery Pi 3

Basic installation from source is described [here](http://mygeeks014.blogspot.com/2015/09/compiling-and-install-r-312-32-bit-in.html). Since we install R verion 3.3.3 ON TOP of our Jupyter Server, a couple of dependencies are already met and otheres need to be added. The following shell script downloads, installs dependencies, configures and compiles R.

```bash
#!/bin/bash
# script name:     install_R.sh
# last modified:   2016/10/13
# sudo:            yes
# 
# see: http://mygeeks014.blogspot.com/2015/09/compiling-and-install-r-312-32-bit-in.html

mkdir $home/R
cd $home/R

$R_version="R-3.3.1"

#------------------------------------------------------
apt-get install libreadline6-dev 
apt-get install libjpeg-dev 
apt-get install libcairo2-dev
apt-get install xvfb

apt-get install libcurl4-openssl-dev
apt-get install liblzma-dev
apt-get install libbz2-dev
apt-get install lbzip2

apt-get install libzmq-dev
#------------------------------------------------------

wget "https://cran.rstudio.com/src/base/R-3/$R_version.tar.gz"
tar "-zxvf $R_version.tar.gz"
cd "$R_version"
./configure --with-cairo --with-jpeglib
make
make install
```

All going well you should now be able to start R by just typing ```R``` at the commandline:

```
R version 3.3.1 (2016-06-21) -- "Bug in Your Hair"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: armv7l-unknown-linux-gnueabihf (32-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 
```

# Adding the IRkernel to Jupyter

With R installation complete we can proceed to install the IRkernel for our Jupyter Notebook Server. [This link](https://irkernel.github.io/installation/#linux-panel) explains how. Start ```R``` and execute the following commands

```R
install.packages(c('crayon', 'pbdZMQ', 'devtools'))
devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))
IRkernel::installspec()
```

# Customization

Add:

```R
options(bitmapType = "cairo")
options(jupyter.plot_mimetypes = "image/svg+xml")
```

to:

```
/usr/local/lib/R/Rprofile.site
```

# Starting the Server

[This link](http://stackoverflow.com/questions/37999772/how-to-run-jupyter-rkernel-notebook-with-inline-graphics-on-machine-without-disp) explains how to run the notebook under the virtual framebuffer X server, xvfb on a linux machine with no display hardware and no physical input devices.

```bash
xvfb-run jupyter notebook
```
