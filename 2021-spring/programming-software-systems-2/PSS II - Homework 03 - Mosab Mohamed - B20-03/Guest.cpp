//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Guest.h"
#include <bits/stdc++.h>

using namespace std;


int Guest::getAge() {
    return age;
}

string Guest::getName() {
    return name;
}

string Guest::getOccupation() {
    return occupation;
}

string Guest::getId() {
    return id;
}

string Guest::getLevel() {
    return level;
};

vector<int> Guest::getRooms() {
    return rooms;
}

void Guest::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void Guest::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

Guest::Guest(int age, string name, string occupation, string id, string level,
                 vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
