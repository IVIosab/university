from pymongo import MongoClient
import pymongo

"""
you need to install pymongo

to install type in the terminal : 
pip install pymongo


"""


client = MongoClient("mongodb://localhost")
db = client['test']

def ex1_1():
    cursor = db.restaurants.find({"cuisine": "Indian"})
    for i in cursor:
        print(i)

def ex1_2():
    cursor = db.restaurants.find({"cuisine": {"$in": ["Indian", "Thai"]}})
    for i in cursor:
        print(i)

def ex1_3():
    cursor = db.restaurants.find({"address.building":"1115", "address.street":"Rogers Avenue", "address.zipcode":"11226"})
    for i in cursor:
        print(i)

def ex2():
    db.restaurants.insert_one({"address": {"building":"1480","coord":[-73.9557413, 40.7720266],"street":"2 Avenue","zipcode":"10075"}, "borough":"Manhattan","cuisine":"Italian","name":"Vella","grades":[{"date":"2014-10-01","grade":"A","score":"11"}],"restaurant_id":"41704620"})

def ex3_1():
    db.restaurants.delete_one({"borough":"Manhattan"})

def ex3_2():
    db.restaurants.delete_many({"cuisine":"Thai"})

def count_c_grades(grades):
    count = 0
    for i in grades:
        count += int(i["grade"]=="C")
    return count

def ex4():
    x = db.restaurants.find({"address.street": "Rogers Avenue"})
    arr = []
    for i in x:
        arr.append(i)
        if count_c_grades(i["grades"]) > 1 :
            db.restaurants.delete_one({"_id": i["_id"]})
        else:
            pass
    return arr
