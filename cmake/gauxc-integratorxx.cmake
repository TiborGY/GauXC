# Check if we should try to find system packages first
if( NOT GAUXC_PREFER_FETCHCONTENT_DEPS )
  find_package( IntegratorXX QUIET )
  if( IntegratorXX_FOUND )
    message( STATUS "Found system package for IntegratorXX" )
    # Use system package - early return
    return()
  endif()
endif()

# System package not found or user prefers FetchContent
# Build IntegratorXX via FetchContent
  include( gauxc-dep-versions )

  message( STATUS "Could not find IntegratorXX... Building via FetchContent" )
  message( STATUS "INTEGRATORXX REPO = ${GAUXC_INTEGRATORXX_REPOSITORY}" )
  message( STATUS "INTEGRATORXX REV  = ${GAUXC_INTEGRATORXX_REVISION}"   )

  set( INTEGRATORXX_ENABLE_TESTS OFF CACHE BOOL "" )
  FetchContent_Declare(
    integratorxx
    GIT_REPOSITORY ${GAUXC_INTEGRATORXX_REPOSITORY} 
    GIT_TAG        ${GAUXC_INTEGRATORXX_REVISION} 
  )
  FetchContent_MakeAvailable( integratorxx )

