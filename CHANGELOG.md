# 20 December 2018
* updated requirements

# 27 November 2018
* updated requirements
* fixed inst_opencv.sh as suggested by @mt08
* corrected README.md accordingly

# 10 November 2018
* updated requirements

# 27 October 2018
* updated requirements

# 20 October 2018
* updated requirements

# 15 October 2018
* updated requirements

# 6 October 2018
* updated requirements

# 4 October 2018
* updated requirements
* both ipython and jupyter-console are now compatible with prompt-toolkit 2.0.5 
* merged 2 pull requests from @bennuttall - THANKS BEN! 

# 1 October 2018
* added tensorflow
* updated requirements

# 23 September 2018
* updated requirements
* modified conf_jupyter.sh to fix issue #26 by setting ```c.NotebookApp.allow_remote_access = True``` in the configuration file located at ```~/.jupyter/jupyter_notebook_config.py```. In existing installtions just edit the configuration file manually

# 15 September 2018
* updated requirements
* simpified requirements using pipdeptree -f --warn silence | grep -P '^[\w0-9\-=.]+'

# 14 Septmber 2018
* updated requirements.txt
=======
# 13 September 2018
* created new branch dev
* shifted bash scripts into `scripts` folder
* adjusted `README.md' accordingly  
>>>>>>> create dev branch

# 12 September 2018
* updated requirements
* removed service.sh as it is renamed to conf_servivice.sh

# 9 September 2018
* installed from scratch on a Raspberry Pi 3 and in the process made some fixes
* updated requirements

# 28 August 2018
* updated requirements
* made minor corrections to README.md

# 18 August 2018
* updated requirements

# 12 August 2018
* updated requirements
* added SQLite3 kernel installation script
* correted prep.sh - thanks mt08xx
* adopted mt08xx's nice solution to start the server as a service

# 7 August 2018
* updated requirements

# 31 July 2018
* updated requirements

# 20 July 2018
* upgated requirements

# 8 July 2018
* updated requirements
* added snowballstemmer back in

# 1 July 2018
* updated requirements

# 12 June 2018
* updated requirements

# 3 June 2018
* made minor changes to `README.md`
* added dependencies for `python-opencv-headless` to `prep.sh`
* updated requirements

# 1 June 2018
* fixed typo in `README.md`
* closed issue # 23
* updated requirements

# 31 May 2018
* removed `inst_node.sh`, modified ```conf_jupyter.sh` and added `inst_lab_ext.sh` as proposad by @Kevin--R to address issue #23 - Thanks Kevin!
* modified `README.md` to refelct the changes above 

# 26 May 2018
* updated requirements
* corrected a typo

# 21 May 2018
* Thanks to comments received form @Kevin--R issue 22 should now be fixed 

# 20 May 2018
* ***fixed further issue*** buy modifying ```inst_node.sh``` - see issue #22
* ***fixed issue 22*** by modifying ```conf_jupyter.sh``` in accordance with a hint found [here](https://stackoverflow.com/questions/43659084/source-bashrc-in-a-script-not-working).
* if you encountered this issue, please run the modified version of ```conf_jupyter.sh```

# 19 May 2018
* updated requirements

# 5 May 2018
* updated requirements
* added altair + vega_datasets - see https://altair-viz.github.io/index.html for details

# 25 April 2018
* updated requirements

# 17 April 2018
* updated requirements
* removed `format = 'legacy'` in README.md because it is deprecated in the latest version of `pip`
* temporarily removed the altair package from requirements.txt due to incompatibility 

# 09 April 2018
* closed issue #21

# 07 April 2018
* updated requirements
* fixed typo in README.md - thanks for reporting it @m-r-white 
* ran a fresh install based on the DESKTOP version of Raspbian Stretch to fix issue #21 opened by @gusdrawn and independently confirmed by @m-r-white (Thanks to both!) and updated `README.md` and `conf_jupyter` to clarify what possibly went wrong in their installations. The short answer: `nodejs 5+` is required for `conf_jupyter.sh` to run properly. 

# 01 April 2018
* updated requirements

# 27 March 2018
* updated requirements
* in the wake of recent abuse of datascience tools: ***DO NO EVIL!***

# 19 March 2018
* updated ```requiremnets```
* fixed ```inst_julia.sh```

# 15 March 2018
* added note to the end of ```README.md``` on how to stop the server if launched on boot

# 14 March 2018
* closed  issue #17
* added the solution as an option to ```README.md``` as this might be useful to some

# 12 March 2018
* removed necessity to reboot after changing ```swap_size``` by stopping and starting the service
* updated ```requirements``` 

# 11 March 2018
* closed issues #15 and #16
* issue #15 is personal preference - I may pick up on this at a later stage
* issue #16 is fixed by installing ```nodejs``` with a separate script. For further info please refer to the issue itself
* cut down Julia installation as the JuliaBerry packages lead to segmentation faults
* simplified TeX installtion as suggested in the documentation of ```nbconvert```

# 22 February 2018
* updated requirements
* manually installed the bokeh jupyter lab extension for testing by running: ```jupyter labextension install jupyterlab_bokeh``` Took some time to build but seems to work fine

# 21 Febuary 2017
* updated requirements  

# 17 February 2017
* updated requirements
* it is really amazing how quickly updated packages become available on piwheels...

# 14 February 2018
* HAPPY VALENTINE'S DAY
* updated requirements 

# 10 February 2018
* updated requirements
* if you installed prior to this update, just run:

```bash
source /home/pi/.venv/jns/bin/activate
pip list --outdated --format='legacy'
pip install -U package1 package2...
```
where ```package1 package2...``` is a list of package names of the packages you want to update
 

# 26 January 2018
* added support for Sphinx for new installations 
* in case you want to add this manually because you already have a working jns installation  just run:

```bash
sudo apt install latexmk
source ~/.venv/jns/bin/activate
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

