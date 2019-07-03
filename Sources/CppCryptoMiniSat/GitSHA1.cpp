/*
 * CryptoMiniSat
 *
 * Copyright (c) 2009-2014, Mate Soos. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation
 * version 2.0 of the License.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
*/

#include "GitSHA1.h"
const char* get_version_sha1()
{
    static const char myversion_sha1[] = "f2474a9970278beb06d224f968ea4f50075c5f86";
    return myversion_sha1;
}

const char* get_version_tag()
{
    static const char myversion_tag[] = "5.0.1";
    return myversion_tag;
}

const char* get_compilation_env()
{
    static const char compilation_env[] =
    "CMAKE_CXX_COMPILER = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ | "
    "CMAKE_CXX_FLAGS =  -fno-stack-protector -std=c++11 -g -pthread -Wall -Wextra -Wunused -pedantic -Wsign-compare -Wtype-limits -Wuninitialized -Wno-deprecated -Wstrict-aliasing -Wpointer-arith -Wheader-guard -Wpointer-arith -Wformat-nonliteral -Winit-self -Wparentheses -Wunreachable-code -ggdb3 -fPIC | "
    "COMPILE_DEFINES =  -DNDEBUG -D_FORTIFY_SOURCE=0 -DUSE_PTHREADS | "
    "STATICCOMPILE = OFF | "
    "ONLY_SIMPLE = ON | "
    "Boost_FOUND =  | "
    "TBB_FOUND =  | "
    "STATS = OFF | "
    "MYSQL_FOUND =  | "
    "SQLITE3_FOUND =  | "
    "ZLIB_FOUND =  | "
    "VALGRIND_FOUND = FALSE | "
    "ENABLE_TESTING = OFF | "
    "M4RI_FOUND =  | "
    "SLOW_DEBUG = OFF | "
    "ENABLE_ASSERTIONS = OFF | "
    "PYTHON_EXECUTABLE = /usr/bin/python2.7 | "
    "PYTHON_LIBRARY = /usr/lib/libpython2.7.dylib | "
    "PYTHON_INCLUDE_DIRS = /usr/include/python2.7 | "
    "MY_TARGETS =  | "
    "compilation date time = " __DATE__ " " __TIME__
    ""
    ;
    return compilation_env;
}
