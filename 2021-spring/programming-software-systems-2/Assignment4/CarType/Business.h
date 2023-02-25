//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_BUSINESS_H
#define ASSIGNMENT4_BUSINESS_H


#include "Car.h"

class Business : public Car {
public:
    bool park = true;

    Business(string carType, string color, string model, pair<int, int> currentCoordinates, int number);

    const string &getCarType() const override;

    const string &getColor() const override;

    const pair<int, int> &getCurrentCoordinates() override;

    const string &getModel() const override;

    const int &getNumber() override;

    const bool parkRightInFrontOfTheEntrance() override;

};


#endif //ASSIGNMENT4_BUSINESS_H
