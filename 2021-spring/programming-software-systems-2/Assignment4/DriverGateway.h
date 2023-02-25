//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_DRIVERGATEWAY_H
#define ASSIGNMENT4_DRIVERGATEWAY_H




#include "CarType/Car.h"
#include "OrderQuery.h"

class DriverGateway {

private:
    Car& driverCar;
    bool status = true;
    string id;
    int rating;
    vector<OrderQuery> orderHistory;
public:

    DriverGateway(Car &driverCar, const string &id, int rating);

public:
    Car &getDriverCar() const;

    const string &getUser() const;

    int getRating() const;

    const string &getId() const;

    vector<OrderQuery> &getOrderHistory() ;

public:

    void logIn(string user, string password);

    bool acceptRide();

    void getOrder(vector<string> orders);

    bool getStatus();

    void setStatus(bool status);
};


#endif //ASSIGNMENT4_DRIVERGATEWAY_H
