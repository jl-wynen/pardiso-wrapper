# Find PARDISO sparse system solver.
#
#  PARDISO_FOUND         - True if PARDISO was found
#  PARDISO_CXX_FLAGS     - Flags for CXX compiler
#  PARDISO_LIBRARIES     - Libraries to link against
#

set(PARDISO "NONE" CACHE STRING "Implementation of PARDISO")

if ("${PARDISO}" STREQUAL "NONE")
  message(FATAL_ERROR "No PARDISO implementation specified")

elseif ("${PARDISO}" STREQUAL "STANDALONE")
  set(PARDISO_CXX_FLAGS "-DPARDISO_STANDALONE")
  find_library(PARDISO_LIBRARIES pardiso)
  set(PARDISO_LIBRARIES "${PARDISO_LIBRARIES};-lgfortran")

elseif ("${PARDISO}" STREQUAL "MKL")
  if (NOT "${BLA_VENDOR}" MATCHES "^Intel.*")
    message(FATAL_ERROR "Cannot use MKL PARDISO when linking against non MKL BLAS")
  endif ()
  set(PARDISO_CXX_FLAGS "-DPARDISO_MKL")

  find_package(BLAS REQUIRED)
  set(PARDISO_LIBRARIES ${BLAS_LIBRARIES} -lmkl_avx2 -lmkl_def)

else ()
  message(FATAL_ERROR "Unknown PARDISO implementation: ${PARDISO}")
endif ()

if (PARDISO_LIBRARIES)
  set(PARDISO_FOUND TRUE)
  message(STATUS "Found PARDISO: ${PARDISO_LIBRARIES}")
else ()
  set(PARDISO_FOUND FALSE)
endif ()
