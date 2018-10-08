cmake_minimum_required(VERSION 3.9.0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# do not allow any compiler specific c++ extensions
set(CMAKE_CXX_EXTENSIONS OFF)

# set linker flags for a target
function (target_link_options target flags)
  if (flags)
    string(REPLACE ";" " " str_flags "${flags}")
    get_target_property(old ${target} LINK_FLAGS)
    if ("${old}" MATCHES "^.*-NOTFOUND")
      set_target_properties(${target} PROPERTIES LINK_FLAGS "${str_flags}")
    else ()
      set_target_properties(${target} PROPERTIES LINK_FLAGS "${old} ${str_flags}")
    endif ()
  endif ()
endfunction ()


project(pardiso CXX)

set(SOURCE
  test/pardiso_test.cpp)

add_executable(pardiso_test ${SOURCE})
set_target_properties(pardiso_test PROPERTIES CXX_STANDARD 14
  CXX_STANDARD_REQUIRED ON)

target_compile_options(pardiso_test PUBLIC -Wall -Wextra)
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  target_compile_options(pardiso_test PUBLIC -Wno-c++98-compat)
endif()

# enable sanitizer
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  target_compile_options(pardiso_test PUBLIC -fsanitize=undefined)
  target_link_options(pardiso_test -fsanitize=undefined)
endif ()

target_include_directories(pardiso_test SYSTEM PUBLIC ${CMAKE_SOURCE_DIR})

# blaze
find_package(blaze REQUIRED)
target_include_directories(pardiso_test SYSTEM PUBLIC ${blaze_INCLUDE_DIRS})

# PARDISO
find_package(PARDISO REQUIRED)
target_compile_options(pardiso_test PUBLIC ${PARDISO_CXX_FLAGS})
target_link_libraries(pardiso_test ${PARDISO_LIBRARIES})

# BLAS
find_package(BLAS REQUIRED)
target_link_options(pardiso_test "${BLAS_LINKER_FLAGS}")
target_link_libraries(pardiso_test ${BLAS_LIBRARIES})

# LAPACK
find_package(LAPACK REQUIRED)
target_link_options(pardiso_test "${LAPACK_LINKER_FLAGS}")
target_link_libraries(pardiso_test ${LAPACK_LIBRARIES})
