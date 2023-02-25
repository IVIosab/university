//
// Created by Mosab Mohamed on 3/28/2021.
//

#ifndef PSSII_HOMEWORK2_CABINET_H
#define PSSII_HOMEWORK2_CABINET_H


#include <bits/stdc++.h>
#include "RoomType.h"

using namespace std;

class Cabinet : public RoomType {
public:
    vector<string> owners;

    Cabinet(int number, string level, vector<string> owners,int floor);

    int getNumber();

    int getFloor();

    string getLevel();

    vector<string> getOwners();
};

#endif //PSSII_HOMEWORK2_CABINET_H
