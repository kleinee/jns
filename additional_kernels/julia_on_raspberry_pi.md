# Installation of Julia 0.5.1
Thanks to the awesome work of Simon Byrne, Viral Shah, Avik Sengupta and Mike Innes the simplest way to install Julia 0.5.1 is now:

```bash
sudo apt-get update
sudo apt-get install julia
```

# IJulia Kernel
Adding the IJulia kernel is simple as well:

```Julia
ENV["JUPYTER"]="/usr/local/bin/jupyter"
Pkg.add("IJulia")
```

That's it. Enjoy!
