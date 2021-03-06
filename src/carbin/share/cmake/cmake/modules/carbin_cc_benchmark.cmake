################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################


include(CMakeParseArguments)
include(carbin_config_cxx_opts)
include(carbin_install_dirs)
include(carbin_print_list)

function(carbin_cc_benchmark)
    set(options
            VERBOSE
            )
    set(args NAME
            WORKING_DIRECTORY
            )

    set(list_args
            PUBLIC_LINKED_TARGETS
            PRIVATE_LINKED_TARGETS
            SOURCES
            COMMAND
            PUBLIC_DEFINITIONS
            PRIVATE_DEFINITIONS
            PUBLIC_INCLUDE_PATHS
            PRIVATE_INCLUDE_PATHS
            PUBLIC_COMPILE_FEATURES
            PRIVATE_COMPILE_FEATURES
            PRIVATE_COMPILE_OPTIONS
            PUBLIC_COMPILE_OPTIONS
            )

    cmake_parse_arguments(
            PARSE_ARGV 0
            CARBIN_CC_BENCHMARK
            "${options}"
            "${args}"
            "${list_args}"
    )

    if (CARBIN_CC_BENCHMARK_VERBOSE)
        carbin_raw("-----------------------------------")
        carbin_print_label("Building Test" "${CARBIN_CC_BENCHMARK_NAME}")
        carbin_raw("-----------------------------------")
        carbin_print_label("Command to Execute" "${CARBIN_CC_BENCHMARK_COMMAND}")
        carbin_print_label("Working Directory" "${CARBIN_CC_BENCHMARK_WORKING_DIRECTORY}")
        carbin_print_list_label("Sources" CARBIN_CC_BENCHMARK_SOURCES)
        carbin_print_list_label("Public Linked Targest" CARBIN_CC_BENCHMARK_PUBLIC_LINKED_TARGETS)
        carbin_print_list_label("Private Linked Targest" CARBIN_CC_BENCHMARK_PRIVATE_LINKED_TARGETS)
        carbin_print_list_label("Public Include Paths" CARBIN_CC_BENCHMARK_PUBLIC_INCLUDE_PATHS)
        carbin_print_list_label("Private Include Paths" CARBIN_CC_BENCHMARK_PRIVATE_INCLUDE_PATHS)
        carbin_print_list_label("Public Compile Features" CARBIN_CC_BENCHMARK_PUBLIC_COMPILE_FEATURES)
        carbin_print_list_label("Private Compile Features" CARBIN_CC_BENCHMARK_PRIVATE_COMPILE_FEATURES)
        carbin_print_list_label("Public Definitions" CARBIN_CC_BENCHMARK_PUBLIC_DEFINITIONS)
        carbin_print_list_label("Private Definitions" CARBIN_CC_BENCHMARK_PRIVATE_DEFINITIONS)
        carbin_raw("-----------------------------------")
    endif ()

    set(testcase ${CARBIN_CC_BENCHMARK_NAME})

    add_executable(${testcase} ${CARBIN_CC_BENCHMARK_SOURCES})
    target_compile_definitions(${testcase} PRIVATE
            #CATCH_CONFIG_FAST_COMPILE
            $<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>
            ${CARBIN_CC_BENCHMARK_PRIVATE_DEFINITIONS}
            ${CARBIN_CC_BENCHMARK_PUBLIC_DEFINITIONS}
            )
    target_compile_options(${testcase} PRIVATE
            $<$<CXX_COMPILER_ID:MSVC>:/EHsc;$<$<CONFIG:Release>:/Od>>
            # $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wno-deprecated;-Wno-float-equal>
            $<$<CXX_COMPILER_ID:GNU>:-Wno-deprecated-declarations>
            ${CARBIN_CC_BENCHMARK_PUBLIC_COMPILE_FEATURES}
            ${CARBIN_CC_BENCHMARK_PRIVATE_COMPILE_FEATURES}
            )
    target_include_directories(${testcase} PRIVATE
            ${CARBIN_CC_BENCHMARK_PUBLIC_INCLUDE_PATHS}
            ${CARBIN_CC_BENCHMARK_PRIVATE_INCLUDE_PATHS}
            )

    target_compile_options(${CARBIN_CC_BENCHMARK_NAME} PUBLIC ${CARBIN_CC_BENCHMARK_PUBLIC_COMPILE_OPTIONS} )
    target_compile_options(${CARBIN_CC_BENCHMARK_NAME} PRIVATE ${CARBIN_CC_BENCHMARK_PRIVATE_COMPILE_OPTIONS} )


    target_link_libraries(${testcase} ${CARBIN_CC_BENCHMARK_PUBLIC_LINKED_TARGETS} ${CARBIN_CC_BENCHMARK_PRIVATE_LINKED_TARGETS})
    #target_link_libraries(${testcase} --coverage -g -O0 -fprofile-arcs -ftest-coverage)
    #target_compile_options(${testcase} PRIVATE --coverage -g -O0 -fprofile-arcs -ftest-coverage)

    #MESSAGE("         Adding link libraries for ${testcase}: ${GNL_LIBS}  ${GNL_COVERAGE_FLAGS} ")

    if (NOT CARBIN_CC_BENCHMARK_COMMAND)
        set(CARBIN_CC_BENCHMARK_COMMAND ${testcase})
    endif ()

    add_test(NAME ${testcase}
           COMMAND ${CARBIN_CC_BENCHMARK_COMMAND}
          WORKING_DIRECTORY ${CARBIN_CC_BENCHMARK_WORKING_DIRECTORY})

endfunction()
