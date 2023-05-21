//
// Created by Mosab Mohamed on 3/6/2021.
//

#include "ClassRoom.h"
#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;


int ClassRoom::getNumber() {
    return number;
}

string ClassRoom::getLevel() {
    return level;
}

ClassRoom::ClassRoom(int number, string level) : RoomType(number, level) {}
