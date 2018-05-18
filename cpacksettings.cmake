
if(MSVC)
set(CPACK_GENERATOR "NSIS64")
else()
set(CPACK_GENERATOR "DEB;RPM")
endif(MSVC)


SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "RCOIN-QT")
SET(CPACK_PACKAGE_VENDOR "rcoin")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "17")
SET(CPACK_PACKAGE_VERSION_PATCH "3")
if(WIN32)
	SET(CPACK_PACKAGE_INSTALL_DIRECTORY "rcoin")
else()
	SET(CPACK_PACKAGE_INSTALL_DIRECTORY "/")
endif()

IF(WIN32 AND NOT UNIX)
  # There is a bug in NSI that does not handle full unix paths properly. Make
  # sure there is at least one set of four (4) backlasshes.
  SET(CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_SOURCE_DIR}/src/qt/res/icons/bitcoin.ico")
  SET(CPACK_NSIS_INSTALLED_ICON_NAME "rcoin-qt.exe")
  SET(CPACK_NSIS_DISPLAY_NAME "RCOIN-QT")
  SET(CPACK_NSIS_HELP_LINK "https://www.coinyee.io")
  SET(CPACK_NSIS_URL_INFO_ABOUT "https://www.coinyee.io")
  SET(CPACK_NSIS_CONTACT "microcaicai@gmail.com")
  SET(CPACK_NSIS_MODIFY_PATH ON)
ELSE(WIN32 AND NOT UNIX)
  SET(CPACK_STRIP_FILES "rcoin")
  SET(CPACK_SOURCE_STRIP_FILES "")
ENDIF(WIN32 AND NOT UNIX)
SET(CPACK_PACKAGE_EXECUTABLES "rcoin-qt" "rcoin-qt")

SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "mosir") #required

SET(CPACK_SOURCE_IGNORE_FILES "${CPACK_SOURCE_IGNORE_FILES};${CMAKE_CURRENT_BINARY_DIR};\\\\.git;\\\\.kdev.*;\\\\.travis\\\\.yml")

set(CPACK_NSIS_MUI_FINISHPAGE_RUN "rcoin-qt.exe")
set(CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP "${CMAKE_CURRENT_SOURCE_DIR}\\\\src\\\\qt\\\\res\\\\setup_wellcomepage.bmp")
