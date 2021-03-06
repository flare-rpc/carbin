################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################

include(carbin_print)
include(carbin_print_list)
include(carbin_color)
include(carbin_variable)
carbin_raw("--------------- summary ---------------------")
carbin_print_label("NameSpace" "${PROJECT_NAME}")
carbin_print_label("Version" "${PROJECT_VERSION}")
carbin_print_label("Install dir" "${CMAKE_INSTALL_PREFIX}")
carbin_print_label("Platform" "${HOST_SYSTEM_NAME}")
carbin_print_label("Package File" "${CARBIN_PACKAGE_FILE_NAME}")
carbin_print_list_label("Pckage Type" CARBIN_GENERATOR)
carbin_print_list_label("CMAKE_MODULE_PATH" CMAKE_MODULE_PATH)
carbin_print_list_label("CMAKE_PREFIX_PATH" CMAKE_PREFIX_PATH)
carbin_print_list_label("CARBIN_INCLUDE_DIRS" CARBIN_INCLUDE_DIRS)

carbin_raw("-------------------------")

if (ENABLE_SUMMARY_CXX_FLAG)
    carbin_print_list_label("CXX OPTS" CARBIN_DEFAULT_COPTS)
    carbin_print_list_label("CXX TEST OPTS" CARBIN_DEFAULT_COPTS)

    carbin_raw("------------------------------------")
endif ()