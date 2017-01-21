**NOTE*** Whilst installation of ```Julia``` from a nighly build is painless,  ```IJulia``` currently fails to install properly. I am getting a lot of deprecation warnings and ultimately errors. If you are a Julia weizzard and can fix what is wrong, please drop me a line.

# Installing Julia on Raspberry Pi 2/3
Download the latest nightly build for ARM 32-bit hardfloat from http://julialang.org/downloads/ into the home directory of user jns. The binary of the current stable release 0.5.0 does not work (for me) as it keeps complaining about not recognizing the CPU.

```bash
wget https://status.julialang.org/download/linux-armv7l
```

Once the download is complete, unpack the archive and rename the directory to julia for easier reference. You may also  want to clean up by deleting the ```linux-armv7l``` archive.

```bash
tar -xvf linux-armv7l
mv julia-* julia
rm linux-armv7l
```

Whilst it is possible to run julia using the complete path to the binary, it is much easier to add a soft link in ```/usr/local/bin```:

```bash
sudo ln -s /home/jns/julia/bin/julia /usr/local/bin/julia
```

Welcome Julia!

```bash
julia
```

```
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.6.0-dev.2224 (2017-01-20 06:36 UTC)
 _/ |\__'_|_|_|\__'_|  |  Commit ff22bd9 (0 days old master)
|__/                   |  armv7l-unknown-linux-gnueabihf` 

julia>
```

# Want to remove Julia?

To un-install just run:

```bash
rm -rf /home/jns/julia
rm -rf /home/jns/.julia
```

The softlink created above might be obsolete as well.
