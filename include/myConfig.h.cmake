/****************************************************************************
 *
 * Description:
 * Project configuration file.
 *
 * Authors:
 * Fabien Spindler
 *
 *****************************************************************************/

#ifndef myConfig_h
#define myConfig_h

// Library is either compiled static or shared
// Used to set declspec(import, export) in headers if required under Windows
#cmakedefine BUILD_SHARED_LIBS

// Handle portable symbol export.
// Defining manually which symbol should be exported is required
// under Windows whether MinGW or MSVC is used.
//
// The headers then have to be able to work in two different modes:
// - dllexport when one is building the library,
// - dllimport for clients using the library.
//
// On Linux, set the visibility accordingly. If C++ symbol visibility
// is handled by the compiler, see: http://gcc.gnu.org/wiki/Visibility
# if defined _WIN32 || defined __CYGWIN__
// On Microsoft Windows, use dllimport and dllexport to tag symbols.
#  define DLLIMPORT __declspec(dllimport)
#  define DLLEXPORT __declspec(dllexport)
#  define DLLLOCAL
# else
// On Linux, for GCC >= 4, tag symbols using GCC extension.
#  if __GNUC__ >= 4
#   define DLLIMPORT __attribute__ ((visibility("default")))
#   define DLLEXPORT __attribute__ ((visibility("default")))
#   define DLLLOCAL  __attribute__ ((visibility("hidden")))
#  else
// Otherwise (GCC < 4 or another compiler is used), export everything.
#   define DLLIMPORT
#   define DLLEXPORT
#   define DLLLOCAL
#  endif // __GNUC__ >= 4
# endif // defined _WIN32 || defined __CYGWIN__

// Under Windows, for shared libraries (DLL) we need to define export on
// compilation or import on use (like a third party project).
// We exploit here the fact that cmake auto set xxx_EXPORTS (with S) on 
// compilation.
#if defined(BUILD_SHARED_LIBS)
// Depending on whether one is building or using the
// library define VISP_EXPORT to import or export.
#  ifdef visp_started_EXPORTS
#    define EXPORT DLLEXPORT
#  else  
#    define EXPORT DLLIMPORT
#  endif 
#  define LOCAL DLLLOCAL
#else
// If one is using the library statically, get rid of
// extra information.
#  define EXPORT
#  define LOCAL
#endif

// Add the material to produce a warning when deprecated functions are used
#ifndef vp_deprecated
#  if defined (UNIX)
#    define vp_deprecated __attribute__((deprecated))
#  else
#    define vp_deprecated __declspec(deprecated)
#  endif
#endif

#endif


