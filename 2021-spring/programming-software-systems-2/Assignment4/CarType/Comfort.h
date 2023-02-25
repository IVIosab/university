//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_COMFORT_H
#define ASSIGNMENT4_COMFORT_H


#include "Car.h"

class Comfort : public Car {
public:

    int freeBottleOfWater = 6;

    int  getNumberOfFreeBottles() override;

    Comfort(string carType, string color, string model, pair<int, int> currentCoordinates, int number);

    const string &getCarType() const override;

    const string &getColor() const override;

    const pair<int, int> &getCurrentCoordinates() override;

    const string &getModel() const override;

    const int &getNumber() override;

    const bool isComfort() override;

    const bool isComfortPlus() override;

    virtual const bool takeNap();

    void setFreeBottles(int i) override;

};

#endif //ASSIGNMENT4_COMFORT_H
