#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([netinet/in.h stdlib.h sys/socket.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL

# Checks for library functions.
AC_CHECK_FUNCS([socket])

AC_ARG_WITH(mptcp,
	[AS_HELP_STRING([--without-mptcp],[Disable Multipath TCP support])],
	[enable_mptcp=no],
	[enable_mptcp=yes]
)

MPTCP=
AS_IF([test "x$enable_mptcp" != xno],
[AC_RUN_IFELSE( [AC_LANG_PROGRAM([[
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>	
#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif
int x=0;
]],
[[
int s= socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
if(s!=-1)
{
  close(s);
  return(0);
}
else
{
  return(-1);
}
]]
) ],
[AC_DEFINE([ENABLE_MPTCP], [1],
                     [Multipath TCP is enabled on this system])],
     [ AC_MSG_NOTICE([Multipath TCP is not enabled. On Linux, you need a kernel >= 5.15 and ensure that sysctl.net.mptcp_enabled is set to 1]) ],
)
])

     
		     
AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
