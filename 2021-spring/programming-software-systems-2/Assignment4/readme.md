Name : Mosab Fathy Ramadan Mohamed

Group : B20-03

Date : 04.14.2021

PSS II Fourth Homework : Implement a Backend for the wendex.taxi 

About the project : 

the program has 2 gateways :
one for drivers and the other for passengers 

each passenger has : 
-Name
-Rating
-Order History
-Payment Methods
-Pinned Addresses 

and each passenger can : 
-Login, See order history, See and update payment methods, See and update pinned addresses
-Order a ride
-Ask for the current coordinates
-See the ride in the order history after it ends

and each Driver has : 
-Name 
-Rating
-Order history
-One car (has model,carType,Current Coordinates,color,number)
-Status(status(is working or not,
in ride or not)

there is 4 car types : 
-Economy
-Comfort (Has water bottles)
-ComfortPlus (somehow the same as Comfort with little modifications)
-Business (Parks infront of the interance)

we also have 2 files acting as Databases : 
-PassengerDatabase : contains the history of each passenger and their name (because that's all we need)
-DriverDatabase : contains the history of each driver and their name (because that's all we need)


Dependencies:
-Clion (latest version)
-Cmake (latest version)
-C++17 (latest version)
-Windows (latest version)

Building: 
To build the program you need to open the program in clion IDE and click ctrl+F9

Running:
To run the program you need to open the program in clion IDE and click Shift+F10

Note : the code does not run, it displays an undfined reference error, i spent most of the last day trying to debug it but there was no use, and it was too late to show the functionality of the rest of the code due to this problem.
please consider grading based on the code and the methods implemented rather than just if the code runs or not.
