#include <bits/stdc++.h>
#include "OrderQuery.h"
#include "PassengerGateway.h"
#include "CarType/Economy.h"
#include "CarType/Comfort.h"
#include "CarType/ComfortPlus.h"
#include "CarType/Business.h"
#include "Controller.h"


using namespace std;


int main() {
    /*
     * initialize cars :
     *      initialize car;
     *
     * initialize drivers :
     *      initialize driver;
     *      get their history from the database;
     *      put it into the system;
     *
     * initialize passengers :
     *      initialize passenger;
     *      get their history from the database;
     *      put it into the system;
     */
    Economy economyCar1("Economy", "silver", "2018", {0, 0}, 1583);
    Comfort comfortCar1("Comfort", "black", "2019", {0, 0}, 1229);
    ComfortPlus comfortPlusCar1("ComfortPlus", "red", "2020", {0, 0}, 1234);
    Business businessCar1("Business", "white", "2021", {0, 0}, 6969);

    DriverGateway driver1(economyCar1, "driver1", 3);
    DriverGateway driver2(comfortCar1, "driver2", 4);
    DriverGateway driver4(businessCar1, "driver4", 5);


    PassengerGateway passenger1("passenger1", {"ad1", "ad2", "ad3", "ad4"}, {"visa", "cash"}, 4);
    PassengerGateway passenger2("passenger2", {"ad1", "ad2", "ad3", "ad4"}, {"visa", "cash"}, 1);
    PassengerGateway passenger3("passenger3", {"ad1", "ad2", "ad3", "ad4"}, {"visa", "cash"}, 5);
    PassengerGateway passenger4("passenger4", {"ad1", "ad2", "ad3", "ad4"}, {"visa", "cash"}, 3);

    Controller *system = Controller::getInstance();
    system->addDriver(&driver1);
    system->addDriver(&driver2);
    system->addDriver(&driver4);
    system->addPassenger(&passenger1);
    system->addPassenger(&passenger2);
    system->addPassenger(&passenger3);
    system->addPassenger(&passenger4);

    unordered_map<string, vector<OrderQuery>> PassHist, DrivHist;

    vector<vector<string>> DriversHistory(10000), PassengersHistory(10000);
    vector<string> DriverNames, PassengersNames;
    string in;
    bool brac;
    int ind;

    ifstream Drivers("DriverDatabase.txt");
    if (Drivers.is_open()) {
        brac = false;
        ind = 0;
        while (getline(Drivers, in)) {
            cout << in << endl;
            if (in.empty()) {
                break;
            } else if (in == "{") {
                brac = true;
            } else if (in == "}") {
                brac = false;
                ind++;
            } else {
                if (!brac) {
                    DriverNames.push_back(in);
                } else {
                    DriversHistory[ind].push_back(in);
                }
            }
        }

        for (int i = 0; i < DriverNames.size(); i++) {
            vector<OrderQuery> orders;
            for (int j = 0; j < DriversHistory[i].size(); j++) {
                string order[4];
                int x = 0;
                for (int k = 0; k < DriversHistory[i][j].size(); k++) {
                    if (DriversHistory[i][j][k] == ' ') {
                        x++;
                    } else {
                        order[x] += DriversHistory[i][j][k];
                    }
                }
                int price = 0;
                stringstream ss;
                ss << order[3];
                ss >> price;
                cout << DriverNames[i] << " : " << order[0] << " " << order[1] << " " << order[2] << " " << price
                     << endl;
                OrderQuery ord(order[0], order[1], order[2], price);
                orders.push_back(ord);
            }
            DrivHist[DriverNames[i]] = orders;
        }
    }
    Drivers.close();
    ifstream Passengers("PassengerDatabase.txt");
    if (Passengers.is_open()) {
        brac = false;
        ind = 0;
        while (getline(Passengers, in)) {
            cout << in << endl;
            if (in.empty()) {
                break;
            } else if (in == "{") {
                brac = true;
            } else if (in == "}") {
                brac = false;
                ind++;
            } else {
                if (!brac) {
                    PassengersNames.push_back(in);
                } else {
                    PassengersHistory[ind].push_back(in);
                }
            }
        }

        for (int i = 0; i < PassengersNames.size(); i++) {
            vector<OrderQuery> orders;
            for (int j = 0; j < PassengersHistory[i].size(); j++) {
                string order[4];
                int x = 0;
                for (int k = 0; k < PassengersHistory[i][j].size(); k++) {
                    if (PassengersHistory[i][j][k] == ' ') {
                        x++;
                    } else {
                        order[x] += PassengersHistory[i][j][k];
                    }
                }
                int price = 0;
                stringstream ss;
                ss << order[3];
                ss >> price;
                cout << PassengersNames[i] << " : " << order[0] << " " << order[1] << " " << order[2] << " " << price
                     << endl;
                OrderQuery ord(order[0], order[1], order[2], price);
                orders.push_back(ord);
            }
            PassHist[PassengersNames[i]] = orders;
        }
    }
    Passengers.close();
    Controller *system1 = Controller::getInstance();
    system1->setPassengersOrderHistory(PassHist);
    system1->setDriversOrderHistory(DrivHist);
    system1->orderRide("Economy", "2018", "ad1", "ad2", "18:20", 8, &passenger1);
    for (int i = 0; i < PassengersNames.size(); i++) {
        if (PassengersNames[i] == passenger1.getId()) {
            PassengersHistory[i].push_back("ad1 ad2 18:20 8");
            break;
        }
    }
    system1->orderRide("Comfort", "2019", "ad1", "ad2", "12:30", 25, &passenger2);
    for (int i = 0; i < PassengersNames.size(); i++) {
        if (PassengersNames[i] == passenger2.getId()) {
            PassengersHistory[i].push_back("ad1 ad2 12:30 25");
            break;
        }
    }
    system1->orderRide("Business", "2021", "ad1", "ad2", "08:20", 50, &passenger3);
    for (int i = 0; i < PassengersNames.size(); i++) {
        if (PassengersNames[i] == passenger3.getId()) {
            PassengersHistory[i].push_back("ad1 ad2 08:20 50");
            break;
        }
    }
    system1->orderRide("Economy", "2018", "ad1", "ad2", "22:20", 12, &passenger4);
    for (int i = 0; i < PassengersNames.size(); i++) {
        if (PassengersNames[i] == passenger4.getId()) {
            PassengersHistory[i].push_back("ad1 ad2 22:20 12");
            break;
        }
    }


    ofstream dri("DriverDatabase.txt");
    if (dri.is_open()) {
        for (int i = 0; i < DriverNames.size(); i++) {
            dri << DriverNames[i] << endl << "{" << endl;
            for (int j = 0; j < DriversHistory[i].size(); j++) {
                dri << DriversHistory[i][j] << endl;
            }
            dri << "}" << endl;
        }
    }
    dri.close();
    ofstream pass("PassengerDatabase.txt");
    if (pass.is_open()) {
        for (int i = 0; i < PassengersNames.size(); i++) {
            pass << PassengersNames[i] << endl << "{" << endl;
            for (int j = 0; j < PassengersHistory[i].size(); j++) {
                pass << PassengersHistory[i][j] << endl;
            }
            pass << "}" << endl;
        }
    }
    dri.close();


    return 0;
}
