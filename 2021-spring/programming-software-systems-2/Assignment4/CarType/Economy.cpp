//
// Created by Mosab Mohamed on 4/14/2021.
//

#include "Economy.h"
/**
 *
 * @param carType
 * @param color
 * @param model
 * @param currentCoordinates
 * @param number
 */
Economy::Economy(string carType, string color, string model, pair<int, int> currentCoordinates, int number) {
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
const string &Economy::getCarType() const {
    return carType;
}
/**
 *
 * @return
 */
const string &Economy::getColor() const {
    return color;
}
/**
 *
 * @return
 */
const pair<int, int> &Economy::getCurrentCoordinates() {
    return currentCoordinates;
}
/**
 *
 * @return
 */
const string &Economy::getModel() const {
    return model;
}
/**
 *
 * @return
 */
const int &Economy::getNumber() {
    return number;
}
/**
 *
 * @return
 */
const bool Economy::parkRightInFrontOfTheEntrance() {
    return false;
}
