//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Professor.h"
#include <bits/stdc++.h>

using namespace std;


int Professor::getAge() {
    return age;
}

string Professor::getName() {
    return name;
}

string Professor::getOccupation() {
    return occupation;
}

string Professor::getId() {
    return id;
}

string Professor::getLevel() {
    return level;
}

void Professor::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void Professor::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

vector<int> Professor::getRooms() {
    return rooms;
}

Professor::Professor(int age, string name, string occupation, string id, string level,
                     vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
