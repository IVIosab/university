//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Cabinet.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

Cabinet::Cabinet(int number, string level, vector<string> owners,int floor) : RoomType(number, level,floor),
                                                                    owners(owners) {}

int Cabinet::getNumber() {
    return number;
}

int Cabinet::getFloor() {
    return floor;
}

string Cabinet::getLevel() {
    return level;
}

vector<string> Cabinet::getOwners() {
    return owners;
}