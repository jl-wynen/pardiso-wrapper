# pardiso-wrapper
This is a simple, thin wrapper around the sparse linear solver package [PARDISO](https://www.pardiso-project.org/).
It provides a high level, resource managed interface for PARDISO's low level FORTRAN routines.
Only the basic solver is handled with minimal support for extra options.

The interface can handle both the standalone version as well as the older version included in Intel's
[MKL](https://software.intel.com/en-us/mkl).
For the core operations, it abstracts away the differences between the two versions.
This comes at the cost that most newer features that go beyond the MKL are not supported.

# Requirements
- **PARDISO** - This is just an interface wrapper and you need an implementation of PARDISO in order to use it.
- **blaze** - The highest level routines of the wrapper use vectors and matrices from
         [blaze](https://bitbucket.org/blaze-lib/blaze/src/master/) to simplify usage.
         This is not strictly required however and all functions that use blaze can simply be removed without
         affecting the rest of the wrapper.

# Installation
The wrapper is header only.
Simply copy pardiso.hpp into you project and include it.

# Testing
There are no proper unit tests, sorry!
There is however a small test program in the tests directory.
This can be compiled and run using 
```
mkdir build
cd build
cmake ..
make
pardiso_test
```

# Usage
All interfacing with PARDISO happens through instances of `Pardiso::State` and its call operators.
The state objects handle all internal memory allocations and clean up automatically.
Memory for the output might still need to be allocated by the user, read the documentation!

The class `Pardiso::Matrix` can assist with constructing matrices in the compressed row storage (CRS) format
requried by PARDISO.

You can find more information in the source code documentation.
The documentation can be parsed by Doxygen.
