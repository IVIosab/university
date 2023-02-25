//
// Created by Mosab Mohamed on 3/28/2021.
//

#ifndef PSSII_HOMEWORK2_STUDENT_H
#define PSSII_HOMEWORK2_STUDENT_H

#include <bits/stdc++.h>
#include "Usertype.h"

using namespace std;

class Student : public Usertype {
public:
    Student(int age, string name, string occupation, string id, string level,
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


#endif //PSSII_HOMEWORK2_STUDENT_H
