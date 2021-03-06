set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTOUIC ON)

cmake_policy(SET CMP0020 NEW)
add_definitions(-DQT_NO_KEYWORDS)
add_definitions(-DENABLE_WALLET -DUSE_QRCODE)

add_definitions(-DCOPYRIGHT_HOLDERS="ecoin.com")

file(GLOB SRCS *.cpp *.h widgets/*.cpp widgets/*.h)

list(FILTER SRCS EXCLUDE REGEX "moc_.*.cpp")
list(FILTER SRCS EXCLUDE REGEX "qrc_.*.cpp")
list(FILTER SRCS EXCLUDE REGEX ".*pb.h")

if (APPLE)
list(APPEND SRCS macdockiconhandler.mm macnotificationhandler.mm)
else()
list(FILTER SRCS EXCLUDE REGEX macdockiconhandler.h)
endif()

#file(GLOB UIS forms/*.ui)

add_subdirectory(forms)
add_subdirectory(locale)

PROTOBUF_GENERATE_CPP(PROTO_PAYMENT_REQUEST_SRC PROTO_PAYMENT_REQUEST_HEADER paymentrequest.proto)

configure_file(bitcoin_locale.qrc bitcoin_locale.qrc COPYONLY)

#qt5_wrap_ui(UI_SRCS ${UIS})
include_directories(${CMAKE_CURRENT_BINARY_DIR})
qt5_add_resources(RC_SRCS bitcoin.qrc  ${CMAKE_CURRENT_BINARY_DIR}/bitcoin_locale.qrc)

set_property(SOURCE ${PROTO_PAYMENT_REQUEST_SRC} ${PROTO_PAYMENT_REQUEST_HEADER} ${RC_SRCS} PROPERTY SKIP_AUTOMOC ON)

set(SRCS ${SRCS} ${UI_SRCS} ${PROTO_PAYMENT_REQUEST_SRC} ${PROTO_PAYMENT_REQUEST_HEADER})

add_executable(ecoin-qt WIN32 ${SRCS} ${RC_SRCS} res/bitcoin-qt-res.rc)

if(MSVC AND ENABLE_QT_STATIC)
add_definitions(-DQT_STATICPLUGIN)
endif()

if(APPLE)
	add_definitions(-DQ_OS_MAC)
endif()

target_include_directories(ecoin-qt PUBLIC ${Boost_INCLUDE_DIRS} ${PROTOBUF_INCLUDE_DIR})


target_link_libraries(ecoin-qt ecoin-qt-uis bitcoin_crypto bitcoin_crypto bitcoin_common bitcoin_consensus bitcoin_server bitcoin_util wallet)
target_link_libraries(ecoin-qt Qt5::Widgets Qt5::Gui Qt5::Core Qt5::Network Qt5::Svg ${QT_EXTRA_LIBS})
target_link_libraries(ecoin-qt ${DB_LIBRARY} ${OPENSSL_LIBRARIES} ${PROTOBUF_LIBRARY} univalue leveldb qrencode)
target_link_libraries(ecoin-qt ${Boost_LIBRARIES} )

target_link_libraries(ecoin-qt ecoin-qt-locale)

if(MSVC AND ENABLE_QT_STATIC)
target_link_libraries(ecoin-qt Qt5::QWindowsIntegrationPlugin Qt5::QGifPlugin Qt5::QJpegPlugin Qt5::QTiffPlugin Qt5::QSvgPlugin Qt5::QSvgIconPlugin Qt5::QICOPlugin Qt5::QWindowsVistaStylePlugin)
endif()

if(WIN32)
target_link_libraries(ecoin-qt Qt5::WinExtras Crypt32.lib Iphlpapi.lib Netapi32.lib version.lib Userenv.lib Winmm.lib Imm32.lib Dwmapi.lib UxTheme.lib)
endif()

if(APPLE)
	target_link_libraries(ecoin-qt "-framework CoreFoundation")
endif()

# target_link_libraries(tianya OPENS)

if(WIN32 AND MSVC AND ENABLE_QT_STATIC)
	target_link_libraries(ecoin-qt ${Qt5StaticExtra})
endif()

install(TARGETS ecoin-qt RUNTIME DESTINATION bin)

