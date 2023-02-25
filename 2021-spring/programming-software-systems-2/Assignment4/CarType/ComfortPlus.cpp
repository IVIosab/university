//
// Created by Mosab Mohamed on 4/14/2021.
//

#include "ComfortPlus.h"

/**
 *
 * @return
 */
const bool ComfortPlus::takeNap() {
    return true;
}
/**
 *
 * @return
 */
const bool ComfortPlus::isComfortPlus() {
    return true;
}
/**
 *
 * @param carType
 * @param color
 * @param model
 * @param currentCoordinates
 * @param number
 */
ComfortPlus::ComfortPlus(const string &carType, const string &color, const string &model,
                         const pair<int, int> &currentCoordinates, int number) : Comfort(carType, color, model,
                                                                                         currentCoordinates,
                                                                                         number) {}
