#------------------------------------------------------------------------------
# CMake config file for lem package: top-level
#------------------------------------------------------------------------------


cmake_minimum_required(VERSION 3.1.11)


# require C++11-compliant compiler; only available for CMake v. 3.1 and up
set(CMAKE_CXX_STANDARD 11)


set(CPLUSPLUS_COMPILER_DEFAULT_FLAGS "-std=c++11 -Wall -fopenmp" CACHE STRING "g++ default compiler flags")
message("default g++ compiler flages set to ${GPLUSPLUS_DEFAULT_FLAGS}")

set(GPLUSPLUS_COMMAND_LINE_COMPILER_OPTIONS "" CACHE STRING "varibale to hold g++ options passed on the command line at configuration setup time")

set(GPLUSPLUS_TEST_COVERAGE_OPTIONS "-fprofile-arcs -ftest-coverage" 
    CACHE STRING "coverage test options for use with g++ compiler")

### clang compiler options
### message("attempting to set variables for clang compiler")
### set(CLANGPLUSPLUS_DEFAULT_FLAGS "-std=c++11 -Wall -fopenmp" 
###    CACHE STRING "clang++ default compiler flags")
### message("default g++ compiler flags for clang++ set to ${CLANGPLUSPLUS_DEFAULT_FLAGS}")


set(DEFAULT_INCLUDE_PATH "/usr/include /usr/local/include /opt/include" CACHE STRING "default search paths for header files")


message(STATUS "DEBUG CHECK")
set(DEFAULT_LIBRARY_PATH "/usr/lib64/ /usr/local/lib64/ /usr/lib/ /usr/local/lib /opt/lib /opt/local/lib" CACHE STRING "default search path for shared object library files")

### voro++ default locations
##set(VOROPLUSPLUS_DEFAULT_HEADER_PATH ${DEFAULT_INCLUDE_PATH} CACHE STRING "defult location for voro++ include files")
##message("default location for voro++ header files set to ${VOROPLUSPLUS_DEFAULT_INCLUDE_PATH}")

##set(VOROPLUSPLUS_DEFAULT_LIBRARY_PATH ${DEFAULT_LIBRARY_PATH} CACHE STRING "defult location for voro++ shared object \(.so\) library files")
##message("default location for voro++ shared object library files set to ${VOROPLUSPLUS_DEFAULT_LIBRARY_PATH}")

message(STATUS "DEBUG CHECK")
set(VOROPLUSPLUS_LD_FLAGS CACHE STRING "-lvoro++")
message("voro++ linker flags set to ${VOROPLUSPLUS_LD_FLAGS}")

message(STATUS "DEBUG CHECK")
set(PETSc_LD_FLAGS CACHE STRING "-lpetsc")
message("pestc linker flags set to ${PETSc_LD_FLAGS}")

### eigen default locations - Eigen is header only
set(EIGEN3_DEFAULT_HEADER_PATH "/usr/include/eigen3 /usr/include/eigen3/Eigen /usr/local/include/eigen3 /usr/local/include/eigen3/Eigen" CACHE STRING "default location for Eigen3 header files")
message("default location for eigen3 header files set to ${EIGEN3_DEFAULT_INCLUDE_PATH}")

message(STATUS "DEBUG CHECK: defining command line options")
option(VOROPLUSPLUS_HEADER_PATH     "path to voro++ header files, command line option"                           "")
option(VOROPLUSPLUS_LIBRARY_PATH    "path to voro++ library files, command line option"                          "")
option(PETSc_HEADER_PATH            "path to PETSc header files, command line option"                            "")
option(PETSc_LIBRARY_PATH           "path to PETSc library files, command line option"                           "")
option(PETSc_BINARY_PATH            "path to PETSc executable files, command line option"                        "")
option(EIGEN3_HEADER_PATH           "path to eigen3 header files, command line option"                           "")
option(GPLUSPLUS_COMPILER_FLAGS     "optional compiler flags used for building"                                  "")
option(GPLUSPLUS_LINKER_FLAGS       "optional linker/loader flags used for building with g++"                    "")
option(CLANGPLUSPLUS_COMPILER_FLAGS "set compiler flags used for building with clang++ on the command line"      "")
option(CLANGPLUSPLUS_LINKER_FLAGS   "set linker/loader flags used for building with clang++ on the command line" "")
message(STATUS "DEBUG CHECK: end defining command line options")

## here you can set the clang-specific compiler options
## and pass them down the toolchain
if("${CMAKE_CXX_COMPILER_ID}" MATCHES ".*clang")
  set(CMAKE_CXX_COMPILER_CLANGXX 1)
  message("Using clang compiler as default")
  if(DEFINED CLANGPLUSPLUS_COMPILER_FLAGS)
    if(CLANGPLUSPLUS_COMPILER_FLAGS MATCHES "")
      message("no command line compiler options passed to ${CMAKE_CXX_COMPILER_ID}")
      message("setting ${CMAKE_CXX_COMPILER_ID} compiler flags to ${CPLUSPLUS_COMPILER_DEFAULT_FLAGS}")
      set(CMAKE_CXX_FLAGS ${CPLUSPLUS_COMPILER_DEFAULT_FLAGS})
    else(CLANGPLUSPLUS_COMPILER_FLAGS MATCHES "")
      message("setting ${CMAKE_CXX_COMPILER_ID} compiler flags to ${CLANGPLUSPLUS_COMPILER_FLAGS}")
      set(CMAKE_CXX_FLAGS "${CLANGPLUSPLUS_COMPILER_FLAGS}")
    endif(CLANGPLUSPLUS_COMPILER_FLAGS MATCHES "")
  endif (DEFINED CLANGPLUSPLUS_COMPILER_FLAGS)
elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
  message("Using ${CMAKE_CXX_COMPILER_ID} compiler as default")
  if(DEFINED GPLUSPLUS_COMPILER_FLAGS)
    if(GPLUSPLUS_COMPILER_FLAGS MATCHES "")
      message("no command line compiler options passed to ${CMAKE_CXX_COMPILER_ID}")
      message("setting ${CMAKE_CXX_COMPILER_ID} compiler flags to ${CPLUSPLUS_COMPILER_DEFAULT_FLAGS} ${GPLUSPLUS_TEST_COVERAGE_OPTIONS}")
      set(CMAKE_CXX_FLAGS "${CPLUSPLUS_COMPILER_DEFAULT_FLAGS} ${GPLUSPLUS_TEST_COVERAGE_OPTIONS}")
    else(GPLUSPLUS_COMPILER_FLAGS MATCHES "")
      message("setting ${CMAKE_CXX_COMPILER_ID} compiler flags to ${GPLUSPLUS_COMPILER_FLAGS}")
      set(CMAKE_CXX_FLAGS ${GPLUSPLUS_COMPILER_FLAGS})
    endif(GPLUSPLUS_COMPILER_FLAGS MATCHES "")
  endif (DEFINED GPLUSPLUS_COMPILER_FLAGS)  
elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "Intel")
  ## here you can tell the user the compiler is not supported and exit
  message("Using intel compiler as default")
  message(FATAL_ERROR "Intel compiler not supported for building")
elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
  ## here you can tell the user the compiler is not supported and exit
  message("Using Microsoft Visual C++ compiler as default")
  message(FATAL_ERROR "Microsoft Visual C++ compiler not supported for building")
endif()


include(CheckIncludeFileCXX)
# check for header files that are part of the standard library
message("checking for algorithm")
CHECK_INCLUDE_FILE_CXX(algorithm HAVE_ALGORITHM_H)
message("successfully found algorithm")
message("checking for cstdlib")
CHECK_INCLUDE_FILE_CXX(cstdlib HAVE_CSTDLIB_H)
message("checking for cassert")
CHECK_INCLUDE_FILE_CXX(cassert HAVE_CASSERT_H)
message("checking for memory")
CHECK_INCLUDE_FILE_CXX(memory  HAVE_MEMORY_H)
message("checking for string")
CHECK_INCLUDE_FILE_CXX(string  HAVE_STRING_H)
message("checking for vector")
CHECK_INCLUDE_FILE_CXX(vector  HAVE_VECTOR_H)

message(STATUS "DEBUG CHECK")
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)


# do not search for Eigen now
#message("attempting to find Eigen installation on local system")
#find_package(Eigen3 REQUIRED)
#if(${EIGEN3_FOUND})
#  message(STATUS "Found Eigen3 library and headers")
#else(${EIGEN3_FOUND})
#  message(FATAL_ERROR "Could not find Eigen3 header files. Please provide a valid path to the installation of Eigen3.")
#endif(${EIGEN3_FOUND})

message("attempting to find Voro++ installation on local system")
find_package(Voro++ REQUIRED)
if(${VOROPLUSPLUS_FOUND})
  message(STATUS "Found Voro++ library and headers")
else(${VOROPLUSPLUS_FOUND})
  message(FATAL_ERROR "Unable to find Voro++ library and headers. Please provide a valid path to the installation of Voro++")
endif(${VOROPLUSPLUS_FOUND})

## MPI is prerequisite for PETSc, although if you have built
## PETSc, chances are it found a valid MPI installation on the sytem
message("attempting to find MPI installation on local system")
find_package(MPI_REQUIRED)
if(${MPI_FOUND})
  message(STATUS "Found MPI library and headers")
else(${MPI_FOUND})
  message(FATAL ERROR "Unable to find MPI library and headers. Please provide a valid path to the installation of MPI")
endif(${MPI_FOUND})

message("attempting to find PETSc installation on local system")
find_package(PETSc REQUIRED)
if(${PETSc_FOUND})
  message(STATUS "Found PETSc library and headers")
else(${PETSc_FOUND})
  message(FATAL_ERROR "Unable to find PETSc library and header. Please provide a valid path to the installation of PETSc.")
endif(${PETSc_FOUND})


subdirs(src) 

message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
