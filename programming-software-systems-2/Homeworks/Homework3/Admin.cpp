//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Admin.h"
#include <bits/stdc++.h>

using namespace std;


int Admin::getAge() {
    return age;
}

string Admin::getName() {
    return name;
}

string Admin::getOccupation() {
    return occupation;
}

string Admin::getId() {
    return id;
}

string Admin::getLevel() {
    return level;
}

vector<int> Admin::getRooms() {
    return rooms;
}

void Admin::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void Admin::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

Admin::Admin(int age, string name, string occupation, string id, string level,
             vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
