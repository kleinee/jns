
# Installing Julia on Raspberry Pi 2/3

Download the latest nightly build for ARM 32-bit hardfloat from http://julialang.org/downloads/ into the home directory of user jns. The binary of the the current stable release 0.5.0 does not work (for me) as it keeps complaining about not recognizing the CPU.

```bash
wget https://status.julialang.org/download/linux-arm
```

Once the download is complete, unpack the archive and rename the directory to julia for easier reference. You may also  want to clean up by deleting the ```linux-arm``` archive.

```bash
tar -xvf linux-arm
mv julia-c71f205f93 julia
rm linux-arm
```

Whilst it is possible tu run julia using the complete path to the binary, it is much easier to add a soft link in ```/usr/local/bin```:

```bash
sudo ln -s /home/jns/julia/bin/julia /user/local/bin/julia
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
  | | |_| | | | (_| |  |  Version 0.6.0-dev.787 (2016-09-26 16:28 UTC)
 _/ |\__'_|_|_|\__'_|  |  Commit c71f205 (2 days old master)
|__/                   |  arm-linux-gnueabihf

julia> 
```


# Adding a Julia kernel to the Jupyter Notebook Server

Note that this step assumes that you followed along and set up a Jupyter Notebook Server as described in this repository:

First attempts to install IJulia failed with build errors for ZMQ. https://github.com/JuliaLang/ZMQ.jl/issues/103 holds the clue for a fix: Leave Julia, remove ```libstdc++.so.6``` and restart Julia.

```bash
mv julia/lib/julia/libstdc++.so.6 /home/jns/
```

If you do not undertstand why please do not raise an issue - I dom't undertsnd either.

```julia
julia> Pkg.add("IJulia")
```

Once installation is complete quit julia with ```quit()``` and start your notebook server:

```bash
jupyter notebook
```

You should now see ```Julia 0.6.0-dev``` in the dropdown.

# Want to remove Julia?

To un-install just run:

```bash
rm -rf /home/jns/julia
rm -rf /home/jns/.julia
rm -rf /home/jns/.local/share/jupyter/kernels/julia-0.6
```

The softlink created above might be obsolete as well.
