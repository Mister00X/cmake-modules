# CMakeLists.txt -*-cmake-*-
#
# SPDX-License-Identifier: MIT
#
# Copyright (c) 2024 Marcel Ilg
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

cmake_minimum_required(VERSION 3.15)

project(Mister00XCMakeModules
        VERSION 0.1.0
        DESCRIPTION "Collection of somewhat useful/convenient CMake modules"
        LANGUAGES NONE)


# check if this is the top level cmake file, if it isn't this file is
# unnecessary, so stop processing it.

include(cmake/is-project-toplevel.cmake)

if(NOT PROJECT_IS_TOP_LEVEL)
  message(AUTHOR_WARNING
          "${PROJECT_NAME} is not intended to be included as a subproject.\n"
          "The rest of this file (${CMAKE_CURRENT_LIST_FILE}) will not be processed.\n")
  return()
endif()

# Now that we are sure that we are the top level project, we can start working.

# We set a variable here, holding the name of the find_package module name
set(CONFIG_PACKAGE_NAME ${PROJECT_NAME})

# first import needed modules
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# set several variables for install locations needed by the project
# Where to install the modules themselves
set(USR_SHARE_INSTALL_DIR ${CMAKE_INSTALL_DATADIR}/Mister00XCMakeModules)
set(MODULES_INSTALL_DIR ${USR_SHARE_INSTALL_DIR}/modules)
# Where to install the config package
set(CONFIG_PACKAGE_INSTALL_DIR ${USR_SHARE_INSTALL_DIR}/cmake)
# Documentation directory
set(DOC_INSTALL_DIR ${CMAKE_INSTALL_DOCDIR}/)
# manual page directory
# NOTE: It is still necessary to put those files into directories starting with
# the manpage section!
set(MAN_INSTALL_DIR ${CMAKE_INSTALL_MANDIR})

# add the cmake directory
add_subdirectory(cmake)


# list of all CMake modules defined sofar
list(APPEND modules_list
     FindAndLog.cmake)

# list of all files that can be somewhat considered documentation excluding
# stuff like manual pages
list(APPEND doc_files
     CHANGELOG.org
     LICENSE
     README.org)


# install commands for the cmake modules
install(FILES ${modules_list}
        DESTINATION ${MODULES_INSTALL_DIR})

# install "documentation"
install(FILES ${doc_files}
        DESTINATION ${DOC_INSTALL_DIR})
