//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_PASSENGERGATEWAY_H
#define ASSIGNMENT4_PASSENGERGATEWAY_H


#include <bits/stdc++.h>
#include "CarType/Car.h"
#include "DriverGateway.h"
#include "OrderQuery.h"

using namespace std;

class PassengerGateway {
private:
    vector<OrderQuery> orderHistory;
    string id;
    int rating;
public:
    int getRating() const;

    void setRating(int rating);

private:
    vector<string> pinnedAddresses, paymentMethods;
    string password;
    DriverGateway* yourCarDriver = nullptr;
    bool InRide = false;
public:
    DriverGateway *getYourCarDriver() const;

    void setYourCarDriver(DriverGateway *yourCarDriver);

    bool isInRide() const;

    void setInRide(bool inRide);

public:
    const string &getPassword() const;

    void setPassword(const string &password);


public:

    PassengerGateway(const string &id, const vector<string> &pinnedAddresses, const vector<string> &paymentMethods, int rating);

    vector<OrderQuery> &getOrderHistory();

    const vector<string> &getPinnedAddresses() const;

    const vector<string> &getPaymentMethods() const;

    const string &getId() const;

    void askCoordinates(Car *car);



};

#endif //ASSIGNMENT4_PASSENGERGATEWAY_H
