# Installation of Julia 0.6.0
Thanks to the  continued work of Simon Byrne, Viral B Shah, Avik Sengupta and Mike Innes and everyone involved in rolling out Raspbian Stretch we now can install ```Julia 0.6.0```:

```bash
sudo apt update
sudo apt install julia
```

# IJulia Kernel
Adding the ```IJulia kernel``` is simple as well:

```Julia
ENV["JUPYTER"]="/usr/local/bin/jupyter"
Pkg.add("IJulia")
```

That's it. Enjoy!
