/*
 * Name : Mosab Fathy Ramadan Mohamed
 * Group : B20-03
 * Program : Database for a university and interaction with the users
 * Date of access : 03/07/2021
 */
#include <bits/stdc++.h>
#include "Student.h"
#include "Professor.h"
#include "LabEmployee.h"
#include "Director.h"
#include "Admin.h"
#include "Usertype.h"
#include "RoomType.h"
#include "LectureHall.h"
#include "ClassRoom.h"
#include "Cabinet.h"
#include "DirectorCabinet.h"
#include "ConferenceRoom.h"


using namespace std;
/**
 * this functions handles lower and uppercase problems in the names
 * @param in
 * @return the appropriate name
 */
string appropriateNaming(string in) {
    for (int i = 0; i < in.size(); i++) {
        in[i] = tolower(in[i]);
        if (i == 0) {
            in[i] = toupper(in[i]);
        } else if (in[i - 1] == ' ') {
            in[i] = toupper(in[i]);
        }
    }
    return in;
}

/**
 * this functions generates a unique ID for each user
 * @param occupation
 * @return the id
 */
string generateId(string occupation) {
    static map<string, int> numberOfUsers;
    string id = "";
    id += occupation[0];
    int num = numberOfUsers[id];
    numberOfUsers[id]++;
    stringstream ss;
    string temp;
    ss << num;
    ss >> temp;
    for (int i = temp.size(); i < 4; i++) {
        id += "0";
    }
    id += temp;
    return id;
}


int main() {
    const string AdminPassword = "56&3AJ46#FdsLOL"; //admin password
    vector<RoomType *> Rooms; // database of rooms
    vector<Usertype *> Users; // database of users


    /*
     * Hardcoded Users and Rooms in the database
     */
    Users.push_back(new Student(18, "Mosab Mohamed", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(19, "Asem Abdelhadi", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(20, "Mohamed Hamdy", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(21, "Menna Ahmed", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(18, "Mariam Aboulftoh", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(19, "Sergey Golubev", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(20, "Adel Krylova", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(21, "Nodir Bobiev", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(18, "Sasha Golovin", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(19, "Robert Chen", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(20, "Zeiin Kanabekov", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(21, "Aleksandr Lobanov", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(18, "Daniil Okrug", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(19, "Roman Makarov", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(20, "Jaffar Totanji", "Student", generateId("Student"), "No_Level", {}));
    Users.push_back(new Student(21, "Rami Husami", "Student", generateId("Student"), "No_Level", {}));

    Users.push_back(
            new LabEmployee(23, "Shokhista Ergasheva", "Lab Employee", generateId("Lab Employee"), "Green", {506}));
    Users.push_back(new LabEmployee(27, "Imre Delgado", "Lab Employee", generateId("Lab Employee"), "Green", {506}));
    Users.push_back(
            new LabEmployee(24, "Zamira Kholmatova", "Lab Employee", generateId("Lab Employee"), "Green", {507}));
    Users.push_back(new LabEmployee(34, "Rasheed Bader", "Lab Employee", generateId("Lab Employee"), "Green", {507}));
    Users.push_back(
            new LabEmployee(28, "Timur Fayzrakhmanov", "Lab Employee", generateId("Lab Employee"), "Green", {508}));
    Users.push_back(new LabEmployee(35, "Pavel Khakimov", "Lab Employee", generateId("Lab Employee"), "Green", {508}));
    Users.push_back(new LabEmployee(26, "Mikhail Ivanov", "Lab Employee", generateId("Lab Employee"), "Green", {509}));
    Users.push_back(
            new LabEmployee(29, "Gerald B. Imbugwa", "Lab Employee", generateId("Lab Employee"), "Green", {509}));

    Users.push_back(new Professor(42, "Adil Khan", "Professor", generateId("Professor"), "Yellow", {502}));
    Users.push_back(new Professor(43, "Eugene Zouev", "Professor", generateId("Professor"), "Yellow", {503}));
    Users.push_back(new Professor(45, "Manuel Mazzara", "Professor", generateId("Professor"), "Yellow", {504}));
    Users.push_back(new Professor(38, "Ivan Konyukhov", "Professor", generateId("Professor"), "Yellow", {505}));

    Users.push_back(new Admin(34, "Michael Reeves", "Admin", generateId("Admin"), "Red", {}));
    Users.push_back(new Admin(37, "William Osman", "Admin", generateId("Admin"), "Red", {}));

    Users.push_back(new Director(52, "Giancarlo Succi", "Director", generateId("Director"), "Yellow", {501}));

    Rooms.push_back(new ClassRoom(301, "No_Level"));
    Rooms.push_back(new ClassRoom(302, "No_Level"));
    Rooms.push_back(new ClassRoom(303, "No_Level"));
    Rooms.push_back(new ClassRoom(304, "No_Level"));
    Rooms.push_back(new ClassRoom(305, "No_Level"));
    Rooms.push_back(new ClassRoom(306, "No_Level"));
    Rooms.push_back(new ClassRoom(307, "No_Level"));
    Rooms.push_back(new ClassRoom(308, "No_Level"));

    Rooms.push_back(new LectureHall(101, "No_Level"));
    Rooms.push_back(new LectureHall(102, "No_Level"));
    Rooms.push_back(new LectureHall(103, "No_Level"));
    Rooms.push_back(new LectureHall(104, "No_Level"));

    Rooms.push_back(new ConferenceRoom(401, "No_Level"));
    Rooms.push_back(new ConferenceRoom(402, "No_Level"));

    Rooms.push_back(new DirectorCabinet(501, "No_Level", "Giancarlo Succi"));

    Rooms.push_back(new Cabinet(502, "No_Level", {"Adil Khan"}));
    Rooms.push_back(new Cabinet(503, "No_Level", {"Eugene Zouev"}));
    Rooms.push_back(new Cabinet(504, "No_Level", {"Manuel Mazzara"}));
    Rooms.push_back(new Cabinet(505, "No_Level", {"Ivan Konyukhov"}));
    Rooms.push_back(new Cabinet(506, "No_Level", {"Shokhista Ergasheva", "Imre Delgado"}));
    Rooms.push_back(new Cabinet(507, "No_Level", {"Zamira Kholmatova", "Rasheed Bader"}));
    Rooms.push_back(new Cabinet(508, "No_Level", {"Timur Fayzrakhmanov", "Pavel Khakimov"}));
    Rooms.push_back(new Cabinet(509, "No_Level", {"Mikhail Ivanov", "Gerald B. Imbugwa"}));



    /*
     * interaction with the users
     */
    while (true) {
        for (int i = 0; i < Users.size(); i++) {
            cout << i + 1 << " - " << Users[i]->getName() << endl;
        }
        cout << "--------------------------------------" << endl;
        string input;
        cout << "Please enter your name, or 0 if you want to terminate the program" << endl;
        getline(cin, input);
        input = appropriateNaming(input);
        if (input == "0") {
            return 0;
        } else {
            int age;
            string level, name, occupation, id;
            vector<int> rooms;
            for (int i = 0; i < Users.size(); i++) {
                if (Users[i]->getName() == input) {
                    name = Users[i]->getName();
                    level = Users[i]->getLevel();
                    occupation = Users[i]->getOccupation();
                    id = Users[i]->getId();
                    age = Users[i]->getAge();
                    rooms = Users[i]->getRooms();
                    break;
                }
            }
            if (occupation == "Admin") {
                cout << "Please enter the password" << endl;
                string password;
                cin >> password;
                if (password != AdminPassword) {
                    cout << "Incorrect Password" << endl;
                    return 0;
                }
                cout << "Your info : " << endl;
                cout << "Name : " << name << endl;
                cout << "Age : " << age << endl;
                cout << "Occupation : " << occupation << endl;
                cout << "ID : " << id << endl;
                cout << "Level : " << level << endl;
                cout << "--------------------------------------" << endl;
                cout
                        << "Choose the action (write the word in parentheses) : \n 1 - Enter a room (Enter)\n 2 - Grant Access to a room for a user (Grant)\n 3 - Change the level of a person (Change)"
                        << endl;
                string in;
                cin >> in;
                if (in == "Enter") {
                    cout << "Enter the room number " << endl;
                    for (int i = 0; i < Rooms.size(); i++) {
                        cout << Rooms[i]->getNumber() << endl;
                    }
                    int rn;
                    cin >> rn;
                    cout << "Access Granted" << endl;
                } else if (in == "Grant") {
                    cout << "Enter the user name" << endl;
                    string un;
                    cin.ignore();
                    getline(cin, un);
                    cout << "Enter the room number" << endl;
                    int rn;
                    cin >> rn;
                    for (int i = 0; i < Users.size(); i++) {
                        if (Users[i]->getName() == un) {
                            Users[i]->addRoom(rn);
                        }
                    }
                    cout << "Done!" << endl;
                } else {
                    cout << "Enter the user name" << endl;
                    string un;
                    cin.ignore();
                    getline(cin, un);
                    cout << "Enter the new level" << endl;
                    string nl;
                    cin >> nl;
                    for (int i = 0; i < Users.size(); i++) {
                        if (Users[i]->getName() == un) {
                            Users[i]->changeLevel(nl);
                        }
                    }
                    cout << "Done!" << endl;
                }
            } else {
                cout << "--------------------------------------" << endl;
                cout << "Your info : " << endl;
                cout << "Name : " << name << endl;
                cout << "Age : " << age << endl;
                cout << "Occupation : " << occupation << endl;
                cout << "ID : " << id << endl;
                cout << "Level : " << level << endl;
                cout << "--------------------------------------" << endl;
                cout << "Choose the room you want to enter" << endl;
                for (int i = 0; i < Rooms.size(); i++) {
                    cout << Rooms[i]->getNumber() << endl;
                }
                int rn;
                cin >> rn;
                bool access = false;
                int drn;
                string lvl;
                for (int i = 0; i < Rooms.size(); i++) {
                    if (Rooms[i]->getNumber() == rn) {
                        drn = Rooms[i]->getNumber();
                        lvl = Rooms[i]->getLevel();
                        break;
                    }
                }
                if (lvl == "Red") {
                    if (level != "Red") {
                        for (int j = 0; j < rooms.size(); j++) {
                            if (rooms[j] == drn) {
                                access = true;
                            }
                        }
                    } else {
                        access = true;
                    }
                } else if (lvl == "Yellow") {
                    if (level != "Yellow" && level != "Red") {
                        for (int j = 0; j < rooms.size(); j++) {
                            if (rooms[j] == drn) {
                                access = true;
                            }
                        }
                    } else {
                        access = true;
                    }

                } else if (lvl == "Green") {
                    if (level == "No_Level") {
                        for (int j = 0; j < rooms.size(); j++) {
                            if (rooms[j] == drn) {
                                access = true;
                            }
                        }
                    } else {
                        access = true;
                    }
                } else {
                    access = true;
                }
                if (access) {
                    cout << "Access Granted" << endl;
                } else {
                    cout << "You can't access this room" << endl;
                }
            }
        }
        cin.ignore();
    }
}