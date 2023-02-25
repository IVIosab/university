//
// Created by Mosab Mohamed on 3/6/2021.
//

#ifndef PSSII_HOMEWORK2_CLASSROOM_H
#define PSSII_HOMEWORK2_CLASSROOM_H

#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

class ClassRoom : public RoomType {
public:
    ClassRoom(int number, string level);

    int getNumber();

    string getLevel();
};


#endif //PSSII_HOMEWORK2_CLASSROOM_H
