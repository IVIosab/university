//
// Created by Mosab Mohamed on 3/6/2021.
//

#include "LectureHall.h"
#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

LectureHall::LectureHall(int number, string level) : RoomType(number, level) {}

int LectureHall::getNumber() {
    return number;
}

string LectureHall::getLevel() {
    return level;
}