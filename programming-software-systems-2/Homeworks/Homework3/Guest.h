//
// Created by Mosab Mohamed on 3/28/2021.
//

#ifndef MAIN_CPP_GUEST_H
#define MAIN_CPP_GUEST_H
#include <bits/stdc++.h>
#include "Usertype.h"

using namespace std;

class Guest : public Usertype {
public:
    Guest(int age, string name, string occupation, string id, string level,
            vector<int> rooms);

public:
    int getAge();

    string getName();

    string getOccupation();

    string getId();

    string getLevel();

    vector<int> getRooms();

    void addRoom(int room);

    void changeLevel(string newLevel);
};



#endif //MAIN_CPP_GUEST_H
