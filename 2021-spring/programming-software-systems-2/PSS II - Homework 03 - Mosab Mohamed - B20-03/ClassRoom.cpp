//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "ClassRoom.h"
#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;


int ClassRoom::getNumber() {
    return number;
}

int ClassRoom::getFloor() {
    return number;
}

string ClassRoom::getLevel() {
    return level;
}

ClassRoom::ClassRoom(int number, string level, int floor) : RoomType(number, level,floor) {}
