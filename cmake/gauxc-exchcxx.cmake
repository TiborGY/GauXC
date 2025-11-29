# Check if we should try to find system packages first
if( NOT GAUXC_PREFER_FETCHCONTENT_DEPS )
  find_package( ExchCXX QUIET )
  if( ExchCXX_FOUND )
    message( STATUS "Found system ExchCXX" )
    
    # Validate GPU compatibility for system package
    if( ${GAUXC_HAS_CUDA} AND NOT ${EXCHCXX_ENABLE_CUDA} )
      message( FATAL_ERROR "GauXC CUDA BINDINGS REQUIRE ExchCXX CUDA Bindings" )
    endif()
    if( ${GAUXC_HAS_HIP} AND NOT ${EXCHCXX_ENABLE_HIP} )
      message( FATAL_ERROR "GauXC HIP BINDINGS REQUIRE ExchCXX HIP Bindings" )
    endif()

    return() # Use system package - early return
  endif()
endif()

# System package not found or user prefers FetchContent
# Build ExchCXX via FetchContent
  include( gauxc-dep-versions )

  message( STATUS "Could not find ExchCXX... Building via FetchContent" )
  message( STATUS "EXCHCXX REPO = ${GAUXC_EXCHCXX_REPOSITORY}" )
  message( STATUS "EXCHCXX REV  = ${GAUXC_EXCHCXX_REVISION}"   )

  set( EXCHCXX_ENABLE_CUDA  ${GAUXC_HAS_CUDA} CACHE BOOL "" )
  set( EXCHCXX_ENABLE_HIP   ${GAUXC_HAS_HIP}  CACHE BOOL "" )
  set( EXCHCXX_ENABLE_TESTS OFF               CACHE BOOL "" )

  FetchContent_Declare(
    exchcxx
    GIT_REPOSITORY ${GAUXC_EXCHCXX_REPOSITORY} 
    GIT_TAG        ${GAUXC_EXCHCXX_REVISION} 
  )
  FetchContent_MakeAvailable( exchcxx )

  # Validate GPU compatibility for FetchContent package
  if( ${GAUXC_HAS_CUDA} AND NOT ${EXCHCXX_ENABLE_CUDA} )
    message( FATAL_ERROR "GauXC CUDA BINDINGS REQUIRE ExchCXX CUDA Bindings" )
  endif()
  if( ${GAUXC_HAS_HIP} AND NOT ${EXCHCXX_ENABLE_HIP} )
    message( FATAL_ERROR "GauXC HIP BINDINGS REQUIRE ExchCXX HIP Bindings" )
  endif()

