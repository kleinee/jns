# 26 January 2018
* added support for sphinx
* in case you want to add this manually because you already already ran the installtion before thsi modification do the following:

```bash
sudo apt install latexmk
~/.venv/jns/bin/activate
pip3 install Sphinx docutils 
```

# 24 January 2018
* corrected `inst_jns.sh` and corresponding entry in `README.md`


# 22 January 2018
* set size of swap_file to 2048MB


# 21 January 2018
* modified `conf_jupyter.sh`in order to facilitate use of `ipywidgets` and `bqplot` in JupyterLab


# 20 January 2018
* new version on GitHub


# 15 January 2018
## IMPORTANT NOTIFICATION: I plan to release a new version of jns within this week

***KEY CHANGES***
* Rather than installing the latest version of Python, the new version will use the latest Python 3 version supported in Raspbian - as of this writing Python 3.5.3.
* Whilst this seems to be a step backwards, it is a in fact a giant step forward as we benefit from significant installation speedups made possible by the recently released  ***piwheels*** project.
* The scripts will work across the entire range of Raspberry Pis - perhaps with the exception of the early models with just 256MB of memory - I tested Pi 1, 2, 3 and ZeroW.
* The new version provides Python support for gpio, sensehat and picamera without the worries of breaking things on the system level as all Python modules will be pip installed into a virtual environment using a requirements.txt file.
* This achieves a more maintainable setup and opens up more possibilities.
* Pyhon 3, Julia and Bash kernels will be installed and configured. R, Ruby and Octave kernels are likely to follow as I find the time.
* JupyterLab will be installed and ready to use.

