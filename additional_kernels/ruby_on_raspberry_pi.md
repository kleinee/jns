# Ruby on the Raspberry Pi
As of this writing Raspbian Jessie Lite comes with ruby 2.1.5 and gem 2.2.2 prei-installed. You can check this with ```ruby -v``` and ```gem -v``` respectively.

# Adding the IRuby kernel
We install the Ruby extension for ZeroMQ, a couple of dependencies and the IRuby kernel itself:

```bash
sudo apt-get install libzmq3-dev
sudo apt-get install libtool libtool-bin autoconf
sudo gem install rbczmq
sudo gem install iruby

# Optional Dependencies for Additional Functionality
sudo gem install pry pry-doc awesome_print gnuplot rubyvis nyaplot
```

Once all packages are installed run ```iruby register``` to register the iruby kernel rith Jupyter. You can now start the server as usual with ```jupyter notebook``` end venture into Ruby programming.
