################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################

include(carbin_variable)

MACRO(carbin_include_list result)
    foreach(arg IN LISTS ${result})
        list(APPEND CARBIN_INCLUDE_DIRS ${arg})
        carbin_print(${CARBIN_INCLUDE_DIRS})
        include_directories(${arg})
    endforeach()
ENDMACRO()

MACRO(carbin_include arg1)
    include_directories(${arg1})
    list(APPEND CARBIN_INCLUDE_DIRS ${arg1})
    foreach(arg ${ARGN})
        list(APPEND CARBIN_INCLUDE_DIRS ${arg})
        include_directories(${arg})
    endforeach()
    carbin_print(${CARBIN_INCLUDE_DIRS})
ENDMACRO()