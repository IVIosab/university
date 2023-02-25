//
// Created by Mosab Mohamed on 3/28/2021.
//

#ifndef PSSII_HOMEWORK2_DIRECTORCABINET_H
#define PSSII_HOMEWORK2_DIRECTORCABINET_H

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

class DirectorCabinet : public RoomType {
public:
    string owner;

    DirectorCabinet(int number, string level, string owner, int floor);

    int getNumber();

    int getFloor();

    string getLevel();

    string getOwner();
};

#endif //PSSII_HOMEWORK2_DIRECTORCABINET_H
