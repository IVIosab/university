//
// Created by Mosab Mohamed on 3/6/2021.
//

#include "Cabinet.h"

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

Cabinet::Cabinet(int number, string level, vector<string> owners) : RoomType(number, level),
                                                                    owners(owners) {}

int Cabinet::getNumber() {
    return number;
}

string Cabinet::getLevel() {
    return level;
}

vector<string> Cabinet::getOwners() {
    return owners;
}