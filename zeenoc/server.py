# https://www.youtube.com/watch?v=N0j6Fe2vAK4

# TO DO - ASK HELAL HOW TO GET THE UID BUT FOR PROPERTIES
# Write the update functions
# have helal show us the firebase codes in the swift app

import firebase_admin

import json

from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("./serviceAccountKey1.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# read data
result = db.collection("users").get()
for doc in result:
    print(doc.to_dict())
#print(result)

from flask import Flask
app = Flask(__name__)

@app.route('/users')
def get_users():
    dic = {}
    result = db.collection("users").get()
    for doc in result:
        res = doc.to_dict()
        uid = doc.id
        dic[uid] = res
    return dic

@app.route('/properties')
def get_properties():
    dic = {}
    result = db.collection("properties").get()
    for doc in result:
        res = doc.to_dict()
        pid = doc.id
        dic[pid] = res
    return dic

@app.route('/user/', methods = ["POST"])
def create_user():
    data = {"firstname" : "hi", "lastname" : "hi","email": "hi@gmail.com", "accountType": "user", "uid": "abcdefg", "paired": "false"}
    #print(username)
    #print(type(username))
    db.collection("users").add(data)


if __name__ == '__main__':
    app.run()