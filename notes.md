# 15 October 2016
* Now Julia has a bug in her hair...
* I added R and the IRkernel

# 3 October 2016
* Update of padas from pandas-0.18.1 to pandas-0.19.0 requires cython.
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
