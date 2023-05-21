//
// Created by Mosab Mohamed on 4/14/2021.
//
#include "DriverGateway.h"
/**
 *
 * @return
 */
Car &DriverGateway::getDriverCar() const {
    return driverCar;
}

/**
 *
 * @return
 */
int DriverGateway::getRating() const {
    return rating;
}

/**
 *
 * @return
 */
vector<OrderQuery> &DriverGateway::getOrderHistory()  {
    return orderHistory;
}
/**
 *
 * @return
 */
bool DriverGateway::getStatus() {
    return status;
}
/**
 *
 * @param status
 */
void DriverGateway::setStatus(bool status) {
    DriverGateway::status = status;
}
/**
 *
 * @param driverCar
 * @param id
 * @param rating
 */
DriverGateway::DriverGateway(Car &driverCar, const string &id, int rating) : driverCar(driverCar), id(id), rating(rating) {}
/**
 *
 * @return
 */
const string &DriverGateway::getId() const {
    return id;
}

