//
// Created by Mosab Mohamed on 3/28/2021.
//

#ifndef PSSII_HOMEWORK2_LECTUREHALL_H
#define PSSII_HOMEWORK2_LECTUREHALL_H


#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

class LectureHall : public RoomType {
public:

    LectureHall(int number, string level,int floor);

    int getNumber();

    int getFloor();

    string getLevel();
};


#endif //PSSII_HOMEWORK2_LECTUREHALL_H
