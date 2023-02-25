//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "DirectorCabinet.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

DirectorCabinet::DirectorCabinet(int number, string level, string owner, int floor) : RoomType(number, level, floor),
                                                                           owner(owner) {}

int DirectorCabinet::getNumber() {
    return number;
}

int DirectorCabinet::getFloor() {
    return floor;
}

string DirectorCabinet::getLevel() {
    return level;
}

string DirectorCabinet::getOwner() {
    return owner;
}