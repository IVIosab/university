//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_COMFORTPLUS_H
#define ASSIGNMENT4_COMFORTPLUS_H


#include "Comfort.h"

class ComfortPlus: Comfort {
public:
    ComfortPlus(const string &carType, const string &color, const string &model,
                const pair<int, int> &currentCoordinates, int number);

    const bool isComfortPlus() override;
    const bool takeNap() override;
};



#endif //ASSIGNMENT4_COMFORTPLUS_H
