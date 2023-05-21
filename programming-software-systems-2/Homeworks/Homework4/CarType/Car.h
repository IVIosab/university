//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_CAR_H
#define ASSIGNMENT4_CAR_H




#include <bits/stdc++.h>

using namespace std;

class Car {

protected:
    string model, carType, color;
    pair<int, int> currentCoordinates;
    int number;
    int FB = 0;

public:
    virtual int getNumberOfFreeBottles();

    virtual const bool isComfortPlus();

    virtual const string &getModel() const = 0;

    virtual const string &getCarType() const = 0;

    virtual const string &getColor() const = 0;

    virtual const pair<int, int> &getCurrentCoordinates() = 0;

    virtual const int &getNumber() = 0;

    virtual const bool parkRightInFrontOfTheEntrance();

    virtual const bool isComfort();

    virtual void setFreeBottles(int i);
};


#endif //ASSIGNMENT4_CAR_H
