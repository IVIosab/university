//
// Created by Mosab Mohamed on 4/14/2021.
//


#include "Controller.h"
#include "CarType/Comfort.h"
/**
 *
 * @param carType
 * @param carModel
 * @param from
 * @param to
 * @param time
 * @param price
 * @param passenger
 */
void Controller::orderRide(string carType, string carModel, string from, string to, string time, int price, PassengerGateway* passenger) {

    for(auto* driver : drivers){
        if(driver->getStatus()&& driver->getDriverCar().getModel() == carModel&& driver->getDriverCar().getCarType() == carType){
            if(driver->getDriverCar().isComfort()){
                cout<<"You are in a comfort car enjoy the water you have !!!!"<<endl;
                int numberOfBottles = driver->getDriverCar().getNumberOfFreeBottles();
                numberOfBottles--;
                driver->getDriverCar().setFreeBottles(numberOfBottles);
                driver->setStatus(false);
                OrderQuery om(from, to, time, 5);
                driver->getOrderHistory().push_back(om);
                driversOrderHistory[driver->getId()] = driver->getOrderHistory();
                passenger->getOrderHistory().push_back(om);
                passengersOrderHistory[passenger->getId()] = passenger->getOrderHistory();
                passenger->setInRide(true);
                passenger->setYourCarDriver(driver);
                return;

            }

            else if(driver->getDriverCar().parkRightInFrontOfTheEntrance()){
                cout<<"You are in a business car, the car will park in front of the address entrance !!!!"<<endl;
                int numberOfBottles = driver->getDriverCar().getNumberOfFreeBottles();
                numberOfBottles--;
                driver->getDriverCar().setFreeBottles(numberOfBottles);
                driver->setStatus(false);
                OrderQuery om(from, to, time, 5);
                driver->getOrderHistory().push_back(om);
                driversOrderHistory[driver->getId()] = driver->getOrderHistory();
                passenger->getOrderHistory().push_back(om);
                passengersOrderHistory[passenger->getId()] = passenger->getOrderHistory();
                passenger->setInRide(true);
                passenger->setYourCarDriver(driver);
                return;
            }

            else if(driver->getDriverCar().isComfortPlus()){
                cout<<"You are in a ComfortPlus car, enjoy the free water and you can take a nap until you reach destination !!!!"<<endl;
                int numberOfBottles = driver->getDriverCar().getNumberOfFreeBottles();
                numberOfBottles--;
                driver->getDriverCar().setFreeBottles(numberOfBottles);
                driver->setStatus(false);
                OrderQuery om(from, to, time, 5);
                driver->getOrderHistory().push_back(om);
                driversOrderHistory[driver->getId()] = driver->getOrderHistory();
                passenger->getOrderHistory().push_back(om);
                passengersOrderHistory[passenger->getId()] = passenger->getOrderHistory();
                passenger->setInRide(true);
                passenger->setYourCarDriver(driver);
                return;
            }
            cout<<"driver is free and with the same conditions you ordered"<<endl;
            driver->setStatus(false);
            OrderQuery om(from, to, time, 5);
            driver->getOrderHistory().push_back(om);
            driversOrderHistory[driver->getId()] = driver->getOrderHistory();
            passenger->getOrderHistory().push_back(om);
            passengersOrderHistory[passenger->getId()] = passenger->getOrderHistory();
            passenger->setInRide(true);
            passenger->setYourCarDriver(driver);
            return;
        }

    }

    cout<<"there is no driver available or with the conditions you agree on"<<endl;

}
/**
 *
 * @param passenger
 */
void Controller::addPassenger(PassengerGateway *passenger) {
    passengersOrderHistory[passenger->getId()] = passenger->getOrderHistory();
    passengers.push_back(passenger);

}
/**
 *
 * @param driver
 */
void Controller::addDriver(DriverGateway *driver) {
    driversOrderHistory[driver->getId()] = driver->getOrderHistory();
    drivers.push_back(driver);
}

Controller::Controller() = default;

/**
 * Singleton design pattern for the controller
 * @return
 */
Controller *Controller::getInstance() {
    if (instance == nullptr) {
        instance = new Controller;
        return instance;

    } else return instance;
}
/**
 *
 * @param driver
 */
void Controller::changeDriverStatus(DriverGateway *driver) {
    driver->setStatus(!driver->getStatus());
}
/**
 *
 * @param s
 * @param passenger
 */
void Controller::setPassengerPassword(string s, PassengerGateway *passenger) {
    passenger->setPassword(s);
}
/**
 *
 * @param userName
 * @param password
 * @return
 */
PassengerGateway* Controller::passengerLogIn(string userName, string password) {
    for(auto* passenger: passengers ){
        if(passenger->getId() == userName&& passenger->getPassword() == password) return passenger;
    }

    return nullptr;

}
/**
 *
 * @param passenger
 * @return
 */
pair<int, int> Controller::askForCoordinates(PassengerGateway *passenger) {
    pair<int,int> currentCoordinates;
    if(passenger->isInRide()){
        currentCoordinates.first = passenger->getYourCarDriver()->getDriverCar().getCurrentCoordinates().first+ 5 *7 -6;
        currentCoordinates.second = passenger->getYourCarDriver()->getDriverCar().getCurrentCoordinates().second + 8*4 -3;
        return currentCoordinates;
    }
    currentCoordinates.first = 0;
    currentCoordinates.second = 0;
    return currentCoordinates;
}
/**
 *
 * @param passenger
 * @return
 */
vector<OrderQuery> Controller::getPassengerHistory(PassengerGateway* passenger) {
    return passengersOrderHistory[passenger->getId()];
}
/**
 *
 * @param driversOrderHistory
 */
void Controller::setDriversOrderHistory(const unordered_map<string, vector<OrderQuery>> &driversOrderHistory) {
    Controller::driversOrderHistory = driversOrderHistory;
}
