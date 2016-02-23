#
# FindPETSc
# ----------
#
# Try to find Petsc : (http://www.mcs.anl.gov/petsc)
#                     a suite of tools for serial and parallel
#                     solution of partial differential equations
#  
# 
# Once done this will define
# PETSc_HEADERS_FOUND - petsc headers
# PETSc_LIBS_FOUND    - pestc
# PETSc_CXX_FLAGS     - compile-time flags for the Petsc library
# PETSc_LD_FLAGS      - linker/loader flags for the Petsc library
# PETSc_FOUND         - value return to FIND call
#
#
# - by default first look in /usr/include , then look in /usr/local/include
#   for header files. 
# - for shared objct files under a unix-based system, look
#   in /usr/lib /usr/local/lib 

message(STATUS "in FindPETSc.cmake")

set(PETSc_HEADERS_FOUND FALSE)
set(PETSc_LIBS_FOUND    FALSE)
set(PETSc_FOUND         FALSE)

message(STATUS "DEBUG CHECK")

if(DEFINED PESTC_HEADER_PATH)
  if(PETSc_HEADER_PATH MATCHES "")
    find_path(PETSc_INCLUDE_DIR pestscvec.h 
              HINTS ${DEFAULT_INCLUDE_PATH})
    message("executing find_path(PETSc_HEADER_PATH) - blank string ")
  else(PETSc_HEADER_PATH MATCHES "")
    find_path(PETSc_INCLUDE_DIR pestcvec.h 
             HINTS ${PETSc_HEADER_PATH})
    message("executing find_path(PETSc_HEADER_PATH) - defined case ")
  endif(PETSc_HEADER_PATH MATCHES "")
else(DEFINED PESTSC_HEADER_PATH)
  message("PETSc_HEADER_PATH not found")
  find_path(PETSc_INCLUDE_DIR petscvec.h 
            HINTS ${DEFAULT_INCLUDE_PATH})
  message("executing find_path(PETSC_HEADER_PATH) - not defined ")
endif(DEFINED PETSc_HEADER_PATH)
message(STATUS "DEBUG CHECK")

if(PETSc_INCLUDE_DIR_FOUND)
  message("PETSc_INCLUDE_DIR_FOUND is true")
  set(PETSc_HEADERS_FOUND TRUE)
endif(PETSc_INCLUDE_DIR_FOUND)
  

## check that the path found for petscvec.h is a valid path 
## although this in principle should be done with find_path
if (NOT IS_DIRECTORY ${PETSc_INCLUDE_DIR})
  message(FATAL_ERROR "{PETSc_INCLUDE_DIR} is not a valid path" )
endif (NOT IS_DIRECTORY ${PETSc_INCLUDE_DIR})

###########################################################
#  check for shared object files
#
###########################################################
message(STATUS "DEBUG CHECK")
message(STATUS "searching for PETSc library files")
if(DEFINED PETSc_LIBRARY_PATH)
  if(PETSc_LIBRARY_PATH MATCHES "")
    find_library(PETSc_LIBRARY_FILE_TEST 
                 petsc libpetsc libpetsc.so 
                 HINTS ${DEFAULT_LIBRARY_PATH})
    message(STATUS "Undefined case (blank string): Searching 
            for librarary files for PETSc in ${DEFAULT_LIBRARY_PATH}")
  else(PETSc_LIBRARY_PATH MATCHES "")
    find_library(PETSc_LIBRARY_FILE_TEST 
                 petsc libpetsc libpetsc.so 
                 HINTS ${PETSc_LIBRARY_PATH})
    message(STATUS "Undefined case (command line option string): 
            Searching for librarary files for PETSc in ${PETSc_LIBRARY_PATH}")
  endif(PETSc_LIBRARY_PATH MATCHES "")
else(DEFINED PETSc_LIBRARY_PATH)
  find_library(PETSc_LIBRARY_FILE_TEST 
               petsc libpetsc libpetsc.so 
               HINTS ${DEFAULT_LIBRARY_PATH})
  message(STATUS "Defined case (command line option): 
          Searching for librarary files for PETSc in ${DEFAULT_LIBRARY_PATH}")
endif(DEFINED PETSc_LIBRARY_PATH)


message(STATUS "DEBUG CHECK: PETSc_LIBRARY_DIR ${PETSc_LIBRARY_FILE_TEST}")
if(IS_SYMLINK ${PETSc_LIBRARY_FILE_TEST})
  message(STATUS "${PETSc_LIBRARY_FILE_TEST} is a symbolic link")
  message(STATUS "PETSc_HEADER_PATH_TEST = ${PETSc_HEADER_PATH_TEST}")
endif(IS_SYMLINK ${PETSc_LIBRARY_FILE_TEST})
message(STATUS "DEBUG CHECK - done checking for libpestc.so")

if(EXISTS ${PETSc_LIBRARY_FILE_TEST})
  message(STATUS "${PETSc_LIBRARY_FILE_TEST} exists")
  set(PETSc_LIBS_FOUND TRUE) 
endif(EXISTS ${PETSc_LIBRARY_FILE_TEST})
message(STATUS "DEBUG CHECK - done checking for libpestsc.so")


if (PESTc_LIBS_FOUND AND PETSc_HEADERS_FOUND)
  set(PETSc_CXX_FLAGS "-I ${PETSc_INCLUDE_DIR}")
  set(PETSc_LD_FLAGS  "-L ${PETSc_LIBRARY_DIR} -lpetsc")
  set(PETSc_FOUND TRUE)
endif (PESTc_LIBS_FOUND AND PETSc_HEADERS_FOUND)


message(STATUS "end of FindPETSc.cmake")

