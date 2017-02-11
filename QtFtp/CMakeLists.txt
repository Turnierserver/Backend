set(qtftp_HEADERS
	qftp.h
	qurlinfo.h
)
set(qtftp_SOURCES
	qftp.cpp
	qurlinfo.cpp
)

add_library(QtFtp SHARED ${qtftp_HEADERS} ${qtftp_SOURCES})
target_link_libraries(QtFtp Qt5::Core Qt5::Network)
set_target_properties(QtFtp PROPERTIES SOVERSION 5 VERSION 5.0.0)
install(TARGETS QtFtp LIBRARY DESTINATION lib)
