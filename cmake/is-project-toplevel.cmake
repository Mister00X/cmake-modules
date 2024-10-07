# cmake/is-project-toplevel.cmake -*-cmake-*-
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

# check if we are the top level project
# and set the variable PROJECT_IS_TOPLEVEL accordingly.
# This is unnecessary if the cmake version is greater or equals 3.21 as CMake sets
# this variable automatically
if(CMAKE_VERSION VERSION_LESS "3.21")
  string(COMPARE EQUAL ${CMAKE_SOURCE_DIR} ${PROJECT_SOURCE_DIR}
         PROJECT_IS_TOP_LEVEL)
endif()
