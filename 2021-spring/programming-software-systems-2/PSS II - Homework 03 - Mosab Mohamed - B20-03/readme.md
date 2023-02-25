Name : Mosab Fathy Ramadan Mohamed

Group : B20-03

Date : 03.28.2021

PSS II Third Homework : Addition to the second homework (Implement a simulation of a university database)

About the project : 
This project is a simulation of a university database.
it has users and rooms.

users have names, id, age...etc
rooms have room numbers, access level, floor

users can be : Admin, Student, Director, LabEmployee, Professor, Guest
rooms can be : ClassRoom, LectureHall, ConferenceRoom, Cabinet, DirectorCabinet

Each user have an access level which allowes him to go into specific rooms
the available access levels are : 
- Red (For admins which allowes him to enter any room)
- Yellow (For professors and Directors which allowes them to enter {ClassRooms,LectureHalls,ConferenceRooms}) 
- Green (For LabEmployees which allowes them to enter {ClassRooms,LectureHalls})
- Blue (For Guests which allowes them to enter{LectureHalls,1stFloorConferenceRooms})
- No_level (For Students which allowes them to enter {ClassRooms})

Special cases : 
Emeregency Declaration : 
	Anyone can call an emergency where all rooms will be opened for everyone.
	Only the admin can stop the emergency.

Example of using the program : 
first pick which user are you from the list 
then if you picked an admin you will have to enter a password otherwise you won't 
the program will display your information then will ask you what action do you want to do 
if you are an admin there is 4 actions 
1-access a room
2-grant access to a room for a user 
3-change the level access of user 
4-stop an emergency
if you are not an admin there is only 2 actions
1-access a room 
2-declare an emergency

if you try to access a room and your level isn't high enough for it the program will display : "you can't access this room"
other wise it'll display : "Access granted"

Dependencies:
-Clion (latest version)
-Cmake (latest version)
-C++17 (latest version)
-Windows (latest version)

Building: 
To build the program you need to open the program in clion IDE and click ctrl+F9

Running:
To run the program you need to open the program in clion IDE and click Shift+F10

Note : I changed the name of the file containing the source codes for "PSS II - Homework 02 - Mosab Mohamed - B20-03" to "PSS II - Homework 03 - Mosab Mohamed - B20-03" to match the naming criteria, I don't know if that will result in any problems with running the code or not
