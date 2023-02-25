//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_CONTROLLER_H
#define ASSIGNMENT4_CONTROLLER_H

using namespace std;
#include <bits/stdc++.h>
#include "OrderQuery.h"
#include "PassengerGateway.h"

class Controller {
private:
    Controller();

    static inline Controller *instance;
    unordered_map<string, vector<OrderQuery>> passengersOrderHistory;
public:
    void setPassengersOrderHistory(const unordered_map<string, vector<OrderQuery>> &passengersOrderHistory);

private:
    unordered_map<string, vector<OrderQuery>> driversOrderHistory;
public:
    void setDriversOrderHistory(const unordered_map<string, vector<OrderQuery>> &driversOrderHistory);

private:
    vector<PassengerGateway*> passengers;
    vector<DriverGateway*> drivers;

public:


    static Controller *getInstance();

    void operator=(Controller const &) = delete;

    Controller(Controller const &) = delete;

    PassengerGateway* passengerLogIn(string userName, string password);

    bool driversLogIn(string userName, string password);

    void setPassengerPassword(string s, PassengerGateway* passenger);

    void orderRide(string carType, string carModel, string from, string to, string time, int price, PassengerGateway* passenger);

    void addPassenger(PassengerGateway* passenger);

    void addDriver(DriverGateway* driver);

    void changeDriverStatus(DriverGateway* driver);

    pair<int,int> askForCoordinates(PassengerGateway* passenger);

    vector<OrderQuery> getPassengerHistory(PassengerGateway* passenger);

};
#endif //ASSIGNMENT4_CONTROLLER_H
