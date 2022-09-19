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

AC_ARG_ENABLE([mptcp],
	AS_HELP_STRING([--disable-mptcp], [Disable Multipath TCP support]))
AM_CONDITIONAL([MPTCP], [test "x$enable_mptcp" != "xno"])

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
