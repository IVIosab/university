//
// Created by Mosab Mohamed on 4/14/2021.
//


#include "Business.h"
/**
 *
 * @param carType
 * @param color
 * @param model
 * @param currentCoordinates
 * @param number
 */
Business::Business(string carType, string color, string model, pair<int, int> currentCoordinates, int number) {
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
const string &Business::getCarType() const {
    return carType;
}
/**
 *
 * @return
 */
const string &Business::getColor() const {
    return color;
}
/**
 *
 * @return
 */
const pair<int, int> &Business::getCurrentCoordinates() {
    return currentCoordinates;
}
/**
 *
 * @return
 */
const string &Business::getModel() const {
    return model;
}
/**
 *
 * @return
 */
const int &Business::getNumber() {
    return number;
}
/**
 *
 * @return
 */
const bool Business::parkRightInFrontOfTheEntrance() {
    return park;
}

