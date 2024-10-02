# FindAndLog.cmake -*-cmake-*-
#
# SPDX-License-Identifier: MIT
#
#  Copyright (c) 2024 Marcel Ilg
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
# CMake macros for finding and logging packages, programs, etc.

#[==============================================================================[
 This macro searches for certain programs of the system while also logging this
 information.

 NOTE: A special variable may be set before invoking the macro, called
 LOG_FIND_PROGRAM_MESSAGE, this variable WILL BE UNSET at the end of the
 macro.
 ]==============================================================================]

macro(log_find_program variable progname)
  message(DEBUG "Macro log_find_program invoked with arguments \"${ARGV}\"")
  # parse the arguments to find out which program we search
  # this is done because there are two different signatures for find program
  set(LOG_FIND_PROGRAM_OPTIONS
      "NAMES_PER_DIR"
      "NO_CACHE"
      "NO_DEFAULT_PATH"
      "NO_PACKAGE_ROOT_PATH"
      "NO_CMAKE_PATH"
      "NO_CMAKE_ENVIRONMENT_PATH"
      "NO_SYSTEM_ENVIRONMENT_PATH"
      "NO_CMAKE_SYSTEM_PATH"
      "NO_CMAKE_INSTALL_PREFIX"
      "CMAKE_FIND_ROOT_PATH_BOTH"
      "ONLY_CMAKE_FIND_ROOT_PATH"
      "NO_CMAKE_FIND_ROOT_PATH")

  set(LOG_FIND_PROGRAM_ONE_VAL_KEYWORDS
      "VALIDATOR"
      "DOC"
      "REGISTRY_VIEW")

  set(LOG_FIND_PROGRAM_MULTI_VAL_KEYWORDS
      "NAMES"
      "HINTS"
      "PATHS"
      "PATH_SUFFIXES")

  cmake_parse_arguments(LFP "${LOG_FIND_PROGRAM_OPTIONS}"
                        "${LOG_FIND_PROGRAM_ONE_VAL_KEYWORDS}"
                        "${LOG_FIND_PROGRAM_MULTI_VAL_KEYWORDS}"
                        ${ARGV})

  # check if a message has been set before invoking the macro
  if(NOT LOG_FIND_PROGRAM_MESSAGE)
    # otherwise set a default message
    if(LFP_NAMES)
      set(LOG_FIND_PROGRAM_MESSAGE "Searching for ${LFP_NAMES}")
    else()
      set(LOG_FIND_PROGRAM_MESSAGE "Searching for ${progname}")
    endif()
  endif()

  # Write out the message
  message(CHECK_START "${LOG_FIND_PROGRAM_MESSAGE}")

  # Pass the options to find_program
  find_program(${ARGV})

  # print the success or failure message
  if(${variable})
    message(CHECK_PASS "found")
  else()
    message(CHECK_FAIL "not found")
  endif()
  # unset variables used inside this macro to not interfere with invocations
  # in the future

  unset(LOG_FIND_PROGRAM_OPTIONS)
  unset(LOG_FIND_PROGRAM_ONE_VAL_KEYWORDS)
  unset(LOG_FIND_PROGRAM_MULTI_VAL_KEYWORDS)
  unset(LOG_FIND_PROGRAM_MESSAGE)
endmacro()


#[==============================================================================[
 This macro searches for certain CMake packages while also logging this
 information.

 NOTE: The special variable "LOG_FIND_PACKAGE_MESSAGE" may be set before invoking
 the macro, its value will be used for the CHECK_START message.
 At the end of the macro THIS VARIABLE WILL BE unset!
 ]==============================================================================]
macro(log_find_package PackageName)
  message(DEBUG "Macro log_find_package invoked with arguments \"${ARGV}\"")

  # check if the message variable has been set before invoking the macro
  if(NOT LOG_FIND_PACKAGE_MESSAGE)
    set(LOG_FIND_PACKAGE_MESSAGE "Searching for ${PackageName}")
  endif()
  # issue the CHECK_START message
  message(CHECK_START "${LOG_FIND_PACKAGE_MESSAGE}")

  # call find_package forwarding all arguments of the macro to find_package
  find_package(${ARGV})

  # Print messages about success of failure
  if(${PackageName}_FOUND)
    message(CHECK_PASS "found")
  else()
    message(CHECK_FAIL "not found")
  endif()

  # unset variable used for message
  unset(LOG_FIND_PACKAGE_MESSAGE)
endmacro()
