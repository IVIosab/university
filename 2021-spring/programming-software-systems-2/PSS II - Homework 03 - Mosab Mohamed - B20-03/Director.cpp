//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Director.h"
#include <bits/stdc++.h>

using namespace std;


int Director::getAge() {
    return age;
}

string Director::getName() {
    return name;
}

string Director::getOccupation() {
    return occupation;
}

string Director::getId() {
    return id;
}

string Director::getLevel() {
    return level;
}

vector<int> Director::getRooms() {
    return rooms;
}

void Director::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void Director::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

Director::Director(int age, string name, string occupation, string id, string level,
                   vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
