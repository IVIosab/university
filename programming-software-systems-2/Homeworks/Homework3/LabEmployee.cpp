//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "LabEmployee.h"
#include <bits/stdc++.h>

using namespace std;


int LabEmployee::getAge() {
    return age;
}

string LabEmployee::getName() {
    return name;
}

string LabEmployee::getOccupation() {
    return occupation;
}

string LabEmployee::getId() {
    return id;
}

string LabEmployee::getLevel() {
    return level;
}

vector<int> LabEmployee::getRooms() {
    return rooms;
}

void LabEmployee::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void LabEmployee::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

LabEmployee::LabEmployee(int age, string name, string occupation, string id, string level,
                         vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
