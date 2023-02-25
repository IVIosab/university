//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "ConferenceRoom.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

ConferenceRoom::ConferenceRoom(int number, string level, int floor) : RoomType(number, level,floor) {}

int ConferenceRoom::getNumber() {
    return number;
}

int ConferenceRoom::getFloor() {
    return floor;
}

string ConferenceRoom::getLevel() {
    return level;
}