//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "LectureHall.h"
#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

LectureHall::LectureHall(int number, string level, int floor) : RoomType(number, level, floor) {}

int LectureHall::getNumber() {
    return number;
}

int LectureHall::getFloor() {
    return floor;
}

string LectureHall::getLevel() {
    return level;
}