set(backend_SOURCES
	main.cpp
)
add_executable(backend ${backend_SOURCES})
target_link_libraries(backend Qt5::Core Qt5::Network)
install(TARGETS backend RUNTIME DESTINATION bin)
