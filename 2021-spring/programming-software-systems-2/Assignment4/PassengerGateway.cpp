//
// Created by Mosab Mohamed on 4/14/2021.
//

#include "PassengerGateway.h"

/**
 *
 * @param car
 */
void PassengerGateway::askCoordinates(Car *car) {

}
/**
 *
 * @return
 */
vector<OrderQuery> &PassengerGateway::getOrderHistory() {
    return orderHistory;
}

/**
 *
 * @return
 */
const vector<string> &PassengerGateway::getPinnedAddresses() const {
    return pinnedAddresses;
}
/**
 *
 * @return
 */
const vector<string> &PassengerGateway::getPaymentMethods() const {
    return paymentMethods;
}


PassengerGateway::PassengerGateway(const string &id, const vector<string> &pinnedAddresses, const vector<string> &paymentMethods, int rating)
        : id(id),
          pinnedAddresses(
                  pinnedAddresses),
          paymentMethods(
                  paymentMethods), rating(rating) {

}

const string &PassengerGateway::getId() const {
    return id;
}

const string &PassengerGateway::getPassword() const {
    return password;
}

void PassengerGateway::setPassword(const string &password) {
    PassengerGateway::password = password;
}

bool PassengerGateway::isInRide() const {
    return InRide;
}

void PassengerGateway::setInRide(bool inRide) {
    InRide = inRide;
}

DriverGateway *PassengerGateway::getYourCarDriver() const {
    return yourCarDriver;
}

void PassengerGateway::setYourCarDriver(DriverGateway *yourCarDriver) {
    PassengerGateway::yourCarDriver = yourCarDriver;
}

int PassengerGateway::getRating() const {
    return rating;
}

void PassengerGateway::setRating(int rating) {
    PassengerGateway::rating = rating;
}

