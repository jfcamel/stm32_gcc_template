
get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
project(${ProjectId})

include(${CMAKE_SOURCE_DIR}/cmake/toolchain.cmake)

set(SRC
  ${CMAKE_CURRENT_LIST_DIR}/src/main.c
)

set(CMAKE_C_FLAGS "-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -O1 -fmessage-length=0 -fsigned-char -fno-move-loop-invariants -gstrict-dwarf -ffunction-sections -fdata-sections")
# SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -DNDEBUG" )
# SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} -g3")
set(CMAKE_CXX_LINK_FLAGS "-T${CMAKE_CURRENT_LIST_DIR}/src/LinkerScript.ld -fno-exceptions -fno-rtti")
set(CMAKE_C_LINK_FLAGS "-T${CMAKE_CURRENT_LIST_DIR}/src/LinkerScript.ld -u _printf_float -Wl,--gc-sections")

add_executable(${ProjectId}
  ${SRC}
  ${SRC_LIBRARY}
  )

target_link_libraries(${ProjectId} -lm)
target_include_directories(${ProjectId} PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc>
  $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/inc>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/Libraries/CMSIS/Include>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/Libraries/CMSIS/Device/ST/STM32F4xx/Include>
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/Libraries/STM32F4xx_StdPeriph_Driver/inc>
)

target_compile_definitions(
  ${ProjectId}
  PRIVATE
  -DSTM32F40_41xxx
  -DUSE_STDPERIPH_DRIVER
)

add_custom_target(${ProjectId}.bin ALL COMMAND
  ${CMAKE_OBJCPY} -O binary ${CMAKE_CURRENT_BINARY_DIR}/${ProjectId} ${CMAKE_CURRENT_BINARY_DIR}/${ProjectId}.bin)

add_dependencies(${ProjectId}.bin ${ProjectId})

