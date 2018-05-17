SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)

if ("$ENV{TOOLCHAIN_HOME}" STREQUAL "")
    message(WARNING "TOOLCHAIN_HOME is not set. You can switch toolchains by setting env TOOLCHAIN_HOME")
 
    SET(CMAKE_C_COMPILER /usr/bin/arm-none-eabi-gcc)
    SET(CMAKE_CXX_COMPILER /usr/bin/arm-none-eabi-g++)
    SET(CMAKE_OBJCPY /usr/bin/arm-none-eabi-objcopy)
else()
    SET(TOOLCHAIN_TARGET_ARCH arm-none-eabi)
    
    SET(CMAKE_C_COMPILER $ENV{TOOLCHAIN_HOME}/bin/${TOOLCHAIN_TARGET_ARCH}-gcc)
    SET(CMAKE_CXX_COMPILER $ENV{TOOLCHAIN_HOME}/bin/${TOOLCHAIN_TARGET_ARCH}-g++)
    #SET(CMAKE_C_LINK_EXECUTABLE $ENV{TOOLCHAIN_HOME}/${TOOLCHAIN_TARGET_ARCH}/bin/ld)
    SET(CMAKE_OBJCPY $ENV{TOOLCHAIN_HOME}/${TOOLCHAIN_TARGET_ARCH}/bin/objcopy)
    
    SET(CMAKE_FIND_ROOT_PATH $ENV{TOOLCHAIN_HOME}/${TOOLCHAIN_TARGET_ARCH}/lib/)
    
    # search for programs in the build host directories
    SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    
    # for libraries and headers in the target directories
    SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()
