//
// Created by Mosab Mohamed on 4/14/2021.
//
#include "OrderQuery.h"

OrderQuery::OrderQuery(const string &from, const string &to, const string &time, int priceInDollars) : from(from), to(to),
                                                                                                       time(time), priceInDollars(
                priceInDollars) {}

const string &OrderQuery::getFrom() const {
    return from;
}

const string &OrderQuery::getTo() const {
    return to;
}

const string &OrderQuery::getTime() const {
    return time;
}

int OrderQuery::getPriceInDollars() const {
    return priceInDollars;
}

OrderQuery::OrderQuery() {}
