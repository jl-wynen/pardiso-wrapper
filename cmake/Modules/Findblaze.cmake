# Find blaze and BLAS/LAPACK of specified vendor
#
#  blaze_FOUND         - True if blaze was found
#  blaze_INCLUDE_DIRS  - Include directories for blaze
#


### control variables
set(BLAZE "" CACHE STRING "Path to folder containing blaze headers. (Expects to find \$BLAZE/blaze/Blaze.h)")

### search for blaze itself ###
find_path(BLAZE_INCLUDE_DIR blaze/Blaze.h PATHS ${BLAZE} NO_DEFAULT_PATH)
find_path(BLAZE_INCLUDE_DIR blaze/Blaze.h)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(blaze DEFAULT_MSG BLAZE_INCLUDE_DIR)
mark_as_advanced(BLAZE_INCLUDE_DIR)

set(blaze_INCLUDE_DIRS ${BLAZE_INCLUDE_DIR})
