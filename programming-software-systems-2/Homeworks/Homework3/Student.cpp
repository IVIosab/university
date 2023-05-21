//
// Created by Mosab Mohamed on 3/28/2021.
//

#include "Student.h"
#include <bits/stdc++.h>

using namespace std;


int Student::getAge() {
    return age;
}

string Student::getName() {
    return name;
}

string Student::getOccupation() {
    return occupation;
}

string Student::getId() {
    return id;
}

string Student::getLevel() {
    return level;
};

vector<int> Student::getRooms() {
    return rooms;
}

void Student::addRoom(int room) {
    rooms.push_back(room);
    return;
}

void Student::changeLevel(string newLevel) {
    level = newLevel;
    return;
}

Student::Student(int age, string name, string occupation, string id, string level,
                 vector<int> rooms) : Usertype(age, name, occupation, id, level, rooms) {}
