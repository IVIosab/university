//
// Created by Mosab Mohamed on 3/6/2021.
//

#include "DirectorCabinet.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

DirectorCabinet::DirectorCabinet(int number, string level, string owner) : RoomType(number, level),
                                                                           owner(owner) {}

int DirectorCabinet::getNumber() {
    return number;
}

string DirectorCabinet::getLevel() {
    return level;
}

string DirectorCabinet::getOwner() {
    return owner;
}