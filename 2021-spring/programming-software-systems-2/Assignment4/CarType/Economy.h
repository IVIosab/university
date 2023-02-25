//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_ECONOMY_H
#define ASSIGNMENT4_ECONOMY_H




#include "Car.h"

class Economy: public Car {

    const string &getCarType() const override;

    const string &getColor() const override;

    const pair<int, int> &getCurrentCoordinates() override;

    const string &getModel() const override;

    const int &getNumber() override;

    const bool parkRightInFrontOfTheEntrance() override;

public:
    Economy(string carType, string color, string model, pair<int, int> currentCoordinates, int number);
};

#endif //ASSIGNMENT4_ECONOMY_H
