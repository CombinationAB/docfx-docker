# docfx-docker

Simple Docker wrapper for DocFX.

We need it since DocFX is still not ported to .NET Core and mono is quite a heavy dependency to pull into the build containers.

This repository now has a new home on GitHub packages (built using GitHub Actions).

**The old home at combination/docfx will continue to exist, as GitHub packages does not support unauthenticated pulls!**

The image repository path is `docker.pkg.github.com/combinationab/docfx-docker/docfx:<VERSION>`
