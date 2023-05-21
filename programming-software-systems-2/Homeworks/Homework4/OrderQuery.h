//
// Created by Mosab Mohamed on 4/14/2021.
//

#ifndef ASSIGNMENT4_ORDERQUERY_H
#define ASSIGNMENT4_ORDERQUERY_H

#include <bits/stdc++.h>
using namespace std;
class OrderQuery {
public:
    OrderQuery();

    string from, to, time;
    int priceInDollars,orderID;

    const string &getFrom() const;

    const string &getTo() const;

    const string &getTime() const;

    int getPriceInDollars() const;

    OrderQuery(const string &from, const string &to, const string &time, int priceInDollars);


};

#endif //ASSIGNMENT4_ORDERQUERY_H
