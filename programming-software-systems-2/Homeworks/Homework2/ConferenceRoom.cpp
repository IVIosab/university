//
// Created by Mosab Mohamed on 3/6/2021.
//

#include "ConferenceRoom.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

ConferenceRoom::ConferenceRoom(int number, string level) : RoomType(number, level) {}

int ConferenceRoom::getNumber() {
    return number;
}

string ConferenceRoom::getLevel() {
    return level;
}