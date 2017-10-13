# 13 October 2017
* Happy Friday 13th!
* Python 3.6.3 was revcently released. I updated ```install_python.sh``` and ```README.md``` to make Python 3.6.3 the default.
* The setup descriped here - with the exception of Julia - even works on a Raspberry Pi Zero W. 

# 22 August 2017
* I used the scripts to install Jupyter on a fresh install of ```Raspbian Stretch Lite``` which was recently released and now comes with ```Julia 0.6.0```. 
* 91 stars so far and still a clone or 2 a day. Not exactly trending but still worth the effort.

# 18 August 2017
* The Raspberry Pi Foundation just released ```Raspbian stretch```. I am currently installing from scratch on a Raspberry Pi Zero W. 

# 16 Aug 2017
* despite some github messages still mentioning Python 3.6.1 the Python version that we install here is 3.6.2
* removed link to original install instructions found online as the link is now dead
* nonetheless credits for installation procedure go to the creator of sowingseasons.com

# 21 Jul 2017
* changed installation order in '''install_stack.sh''' to address an exception during installation as identified George Fisher (grfiv). Thanks for the feedback!
 
# 19 Jul 2017
* updated  Python version from 3.6.1 to 3.6.2

# 23 Apr 2017
* removed R until I fixed my installer script

# 22 Apr 2017
* as per official documentation beginning with version 6.0, IPython stopped supporting compatibility with Python versions lower than 3.3 including all versions of Python 2.7.
* the entire setup works on Raspberry Pi Zero W probably turning it into one of the smallest Jupyter Notebook Servers. Not the fastest but still decent enough for tinkering.

# 16 Apr 2017
* Opened new issue. The pandoc version installed does not correctly handle links in notebooks. If you get internal server errors during notebook conversion, chances are that you have hit this issue.
* Only fix would be to complile the latest version of pandoc on the Pi 
# 9 Apr 2017
* renamed notes.md to CHANGELOG.md

# 8 Apr 2017
* Changed Julia installation to the brand new Raspbian packages. 

# 5 Apr 2017
* The release notes of notebook 5.0.0 encourage to try JupyterLab. It is seriously impressive - even on Pi.

# 31 Mar 2017
* Thomas Kluyver's bash kernel was the first I installed on top of Jupyter - and then forgot to add intsallation notes to this repository. 

# 22 Mar 2017
* updated installation to Python 3.6.1 

# 05 Mar 2017
* I removed the softlink that made pip run pip3 and replaced all occurrences of pip in the scripts by pip3 - thanks to [Priyabrata Dash](http://priyabgeek.blogspot.ca/2017/02/raspberry-pi-experiments-running.html?m=1&utm_content=buffer3c732&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer) for the suggestion. 

```bash
sed -i -- 's/pip/pip3/g' *.sh 
```

* After running the command above I also corrected README.md in similar fashion and made some minor cosmetic corrections as the command above also replces legit occurrences of pip3 into pip33.

# 06 February 2017
* merged pull request fixing dependency issue
* adjusted modification dates in two scripts affected by pull request
* made respective changes in the writeup

# 14 January 2017
* added a directory ```additional_kernels``` 
* moved files related to R, Julia etc. into this directory
* added ```ruby_on_raspberry_pi.md```, a minimalistic instruction for adding the IRuby kernel.

# 3 January 2017
* nothing spectacular - just added year 2017 to LICENCE.md - HAPPY NEW YEAR

# 29 December 2016
* Added ```libreadline-dev``` and ```libbz2-dev``` in ```install_python.sh```. Without readline the standard Python prompt is unusable as it generates segmentation faults and Bus errors. ```IPython``` was unaffected as the Jupyter team switched to prompt-toolkit a while back.

# 28 December 2016
* minor changes to configure_jupyter.sh: if notebook directory exists, we keep it (-p) if configuration file exeists, we overwrite it (-y)
* this way the script can be re-run if things go wrong
* I also found ```grep "^[^#;]" /home/jns/.jupyter/jupyter_notebook_config.py``` to be useful to just print out the lines that are active in the configuration file

# 25 December 2016
* switched to Python 3.6.0. Note that I tried to do this on an exiting installation and ended up in a mess
* changed the server port to 8888 as this seems to be standard
* made the server listen on all IP addresses
* deleted ```configure_disk_image.sh```
* cleaned up ```configure_jupyter.sh```

# 22 December 2016
* as of version 5.0.0 nbconvert uses xelatex by default for latex export, improving unicode and font support - I added one line at the end of ```install_tex.sh```

# 15 October 2016
* Now Julia has a bug in her hair...
* I added R and the IRkernel

# 3 October 2016
* Update of pandas from pandas-0.18.1 to pandas-0.19.0 requires cython.
* Before manually updating pandas install cyton first:
```bash
sudo pip install cython
sudo pip install -U pandas
```
* For new installations I added ```pip install cython``` to ```install_stack.sh```. 

# 29 September 2016
*  If you came here for Julia Notebooks and are setting up your server on a Raspberry Pi 2 or 3 you are no longer out of luck. See separate file in this repository on installation of Julia (binary) and IJulia. 

# 1 August 2016
## Experience so far
* I am running a Jupyter Notebook Server on a Raspberry Pi 3 for quite a while now and am rather pleased with it. Don't be fooled by the lack of my GitHub activity: Thanks to the brilliant team developing Jupyter, all the bright people involved in development of open source software and the Raspberry Pi Foundation the setup is rather stable and easy to maintain.

* Without making changes to the repository I have already switched to Python 3.5.2

* I consider to remove ```configure_disk_image.sh``` because as I recently spotted Raspbian Jessie already sets up a swap parition. Your comments and suggestions are welcome. 

* This repository generates in the order of 200 views by 100 unique visitors in a fortnight and is being cloned more or less once per day.

## Ouput of ```pip list```
backports.shutil-get-terminal-size (1.0.0), bash-kernel (0.4.1), beautifulsoup4 (4.5.0), bokeh (0.12.1), Bottleneck (1.1.0), coverage (4.2), cycler (0.10.0), decorator (4.0.10), entrypoints (0.2.2), et-xmlfile (1.0.1), html5lib (0.999999999), ipykernel (4.3.1), ipyparallel (5.1.1), ipython (5.0.0), ipython-genutils (0.1.0), ipywidgets (5.2.2), jdcal (1.2), Jinja2 (2.8), jsonschema (2.5.1), jupyter (1.0.0), jupyter-client (4.3.0), jupyter-console (5.0.0), jupyter-core (4.1.0), lxml (3.6.1), MarkupSafe (0.23), matplotlib (1.5.1), mistune (0.7.3), mpmath (0.19), nbconvert (4.2.0), nbformat (4.0.1), networkx (1.11), nose (1.3.7), notebook (4.2.1), numexpr (2.6.1), numpy (1.11.1), openpyxl (2.3.5), pandas (0.18.1), path.py (8.2.1), patsy (0.4.1), pexpect (4.2.0), pickleshare (0.7.3), pip (8.1.2), plotly (1.12.4), prompt-toolkit (1.0.3), ptyprocess (0.5.1), Pygments (2.1.3), pyparsing (2.1.5), python-dateutil (2.5.3), pytz (2016.6.1), PyYAML (3.11), pyzmq (15.3.0), qtconsole (4.2.1), readline (6.2.4.1), requests (2.10.0), scipy (0.18.0), setuptools (25.1.1), simplegeneric (0.8.1), six (1.10.0), SQLAlchemy (1.0.14), sympy (1.0), terminado (0.6), tornado (4.4.1), traitlets (4.3.0.dev0), wcwidth (0.1.7), webencodings (0.5), widgetsnbextension (1.2.6), xlrd (1.0.0), XlsxWriter (0.9.3), xlwt (1.1.2)
