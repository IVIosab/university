cmake_minimum_required(VERSION 3.17)
project(Assignment4)

set(CMAKE_CXX_STANDARD 14)

add_executable(Assignment4 main.cpp CarType/Comfort.cpp CarType/Comfort.h CarType/ComfortPlus.cpp CarType/ComfortPlus.h CarType/Economy.cpp CarType/Economy.h CarType/Car.cpp CarType/Car.h CarType/Business.cpp CarType/Business.h DriverGateway.cpp DriverGateway.h OrderQuery.cpp OrderQuery.h PassengerGateway.cpp PassengerGateway.h Controller.cpp Controller.h)