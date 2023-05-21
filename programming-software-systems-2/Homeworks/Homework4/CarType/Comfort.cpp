//
// Created by Mosab Mohamed on 4/14/2021.
//


#include "Comfort.h"
/**
 *
 * @return
 */
const string &Comfort::getCarType() const {
    return carType;
}
/**
 *
 * @return
 */
const string &Comfort::getColor() const {
    return color;
}
/**
 *
 * @return
 */
const pair<int, int> &Comfort::getCurrentCoordinates() {
    return currentCoordinates;
}
/**
 *
 * @return
 */
const string &Comfort::getModel() const {
    return model;
}
/**
 *
 * @return
 */
const int &Comfort::getNumber() {
    return number;
}

/**
 *
 * @param carType
 * @param color
 * @param model
 * @param currentCoordinates
 * @param number
 */
Comfort::Comfort(string carType, string color, string model, pair<int, int> currentCoordinates, int number) {

    this->carType = carType;
    this->color = color;
    this->model = model;
    this->number = number;
    this->currentCoordinates = currentCoordinates;
}

/**
 *
 * @return
 */
const bool Comfort::takeNap() {
    return false;
}

const bool Comfort::isComfort() {
    return true;
}


int  Comfort::getNumberOfFreeBottles() {
    return freeBottleOfWater;
}

const bool Comfort::isComfortPlus() {
    return false;
}

void Comfort::setFreeBottles(int i) {
    this->freeBottleOfWater = i;
}

