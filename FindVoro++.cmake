#
# FindVoro++
# ----------
#
# FindVoro++
# Try to find Voro (http://math.lbl.gov/voro++)
# 
# Once done this will define
# VOROPLUSPLUS_FOUND - System has voro++
# 
#
#
# first look in /usr/include , then look in /usr/local/include

message(STATUS "in FindVoro++.cmake")

set(VOROPLUSPLUS_FOUND FALSE)

message(STATUS "DEBUG CHECK")
# for shared objects and static libraries, first look in
#if(EXISTS ${VOROPP_INCLUDE_PATH})
if(DEFINED VOROPLUSPLUS_HEADER_PATH)
  if(VOROPLUSPLUS_HEADER_PATH MATCHES "")
    find_path(VOROPLUSPLUS_INCLUDE_DIR voro++.hh HINTS ${DEFAULT_INCLUDE_PATH})
    message("executing find_path(VOROPP_INCLUDE_PATH) - blank string ")
  else(VOROPLUSPLUS_HEADER_PATH MATCHES "")
    find_path(VOROPLUSPLUS_INCLUDE_DIR voro++.hh HINTS ${VOROPLUSPLUS_HEADER_PATH})
    message("executing find_path(VOROPLUSPLUS_HEADER_PATH) - defined case ")
  endif(VOROPLUSPLUS_HEADER_PATH MATCHES "")
else(DEFINED VOROPP_HEADER_PATH)
  message("VOROPLUSPLUS_HEADER_PATH not found")
  find_path(VOROPLUSPLUS_INCLUDE_DIR voro++.hh HINTS ${DEFAULT_INCLUDE_PATH})
  message("executing find_path(VOROPP_INCLUDE_PATH) - not defined ")
endif(DEFINED VOROPLUSPLUS_HEADER_PATH)
message(STATUS "DEBUG CHECK")


## check that the path found for voro++.hh is a valid path 
## although this in principle should be done with find_path
if (NOT IS_DIRECTORY ${VOROPLUSPLUS_INCLUDE_DIR})
  message(FATAL_ERROR "{LIBVOROPP_INCLUDE_DIR} is not a valid path" )
endif (NOT IS_DIRECTORY ${VOROPLUSPLUS_INCLUDE_DIR})

message(STATUS "DEBUG CHECK")
message(STATUS "searching for VORO++ library files")
if(DEFINED VOROPLUSPLUS_LIBRARY_PATH)
  if(VOROPLUSPLUS_LIBRARY_PATH MATCHES "")
    find_library(VOROPLUSPLUS_LIBRARY_FILE_TEST voro++ libvoro++ HINTS ${DEFAULT_LIBRARY_PATH})
    find_path(VOROPLUSPLUS_HEADER_PATH_TEST libvoro++.so libvoro++.so.0 HINTS ${DEFAULT_LIBRARY_PATH})
    message(STATUS "Undefined case (blank string): Searching for librarary files for voro++ in ${DEFAULT_LIBRARY_PATH}")
  else(VOROPLUSPLUS_LIBRARY_PATH MATCHES "")
    find_library(VOROPLUSPLUS_LIBRARY_FILE_TEST voro++ libvoro++ HINTS ${VOROPLUSPLUS_LIBRARY_PATH})
    find_path(VOROPLUSPLUS_HEADER_PATH_TEST libvoro++.so libvoro++.so.0 HINTS ${VOROPLUSPLUS_LIBRARY_PATH})
    message(STATUS "Undefined case (command line option string): Searching for librarary files for voro++ in ${VOROPLUSPLUS_LIBRARY_PATH}")
  endif(VOROPLUSPLUS_LIBRARY_PATH MATCHES "")
else(DEFINED VOROPLUSPLUS_LIBRARY_PATH)
  find_library(VOROPLUSPLUS_LIBRARY_FILE_TEST voro++ libvoro++ HINTS ${DEFAULT_LIBRARY_PATH})
  find_path(VOROPLUSPLUS_HEADER_PATH_TEST libvoro++.so libvoro++.so.0 HINTS ${DEFAULT_LIBRARY_PATH})
  message(STATUS "Defined case (command line option): Searching for librarary files for voro++ in ${DEFAULT_LIBRARY_PATH}")
endif(DEFINED VOROPLUSPLUS_LIBRARY_PATH)


#set(VOROPLUSPLUS_LIBRARY_FILE "${VOROPLUSPLUS_LIBRARY_DIR}")
message(STATUS "DEBUG CHECK: VOROPLUSPLUS_LIBRARY_DIR ${VOROPLUSPLUS_LIBRARY_FILE_TEST}")
if(IS_SYMLINK ${VOROPLUSPLUS_LIBRARY_FILE_TEST})
  message(STATUS "${VOROPLUSPLUS_LIBRARY_FILE_TEST} is a symbolic link")
  message(STATUS "VOROPLUSPLUS_HEADER_PATH_TEST = ${VOROPLUSPLUS_HEADER_PATH_TEST}")
endif(IS_SYMLINK ${VOROPLUSPLUS_LIBRARY_FILE_TEST})
message(STATUS "DEBUG CHECK - done checking for libvoro++.so")

if(EXISTS ${VOROPLUSPLUS_LIBRARY_FILE_TEST})
  message(STATUS "${VOROPLUSPLUS_LIBRARY_FILE_TEST} exists")
endif(EXISTS ${VOROPLUSPLUS_LIBRARY_FILE_TEST})
message(STATUS "DEBUG CHECK - done checking for libvoro++.so")

set(VOROPLUSPLUS_CXX_FLAGS "-I ${VOROPLUSPLUS_INCLUDE_DIR}")
set(VOROPLUSPLUS_LD_FLAGS  "-L ${VOROPLUSPLUS_LIBRARY_DIR} -lvoro++")

set(VOROPLUSPLUS_FOUND TRUE)
