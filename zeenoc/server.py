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

@app.route('/user/<data>', methods = ["POST"])
def create_user(data): # creating a user in the users collection
    data = data
    db.collection("users").add(data)


@app.route('/property/<data>', methods = ["POST"])
def create_property(data): # creating a property in the properties collection
    data = data
    db.collection("properties").add(data)

@app.route('/property/<data>', methods = ["POST"])
def add_property_to_landlord(data): # creating a property in the properties collection
    #data = data
    #db.collection("properties").add(data)

    db.collection("users").document(data["uid"]).collection("properties").add(data["property_data"])

@app.route('/property/<data>', methods = ["POST"])
def assign_tenant_to_property(data): # creating a property in the properties collection
    #data = data
    #db.collection("properties").add(data)
    db.collection("users").document(data["uid"]).add({"propertyID": data["propertyID"]})

@app.route('/user/<data>', methods = ["POST"])
def approve_tenant_to_property(data): #

@app.route('/user/<data>', methods = ["POST"])
def remove_tenant_from_property(data): # removing a tenant from assigned property
    db.collection("users").document(data["uid"]).collection("properties").delete()


@app.route('/payments/<data>', methods = ["POST"])
def add_payment(data): # assigning payments to payments collection 
    db.collection("users").document(ta["uid"]).collection("payments").add(data)

@app.route('/payments/<data>', methods = ["POST"])
def remove_payment(data): # removing payment
    db.collection("users").document(data["uid"]).collection("payments").delete()


@app.route('/tenant_info/<data>', methods = ["POST"]) #?????
def request_tenant_info(data): # removing payment
     db.collection("users").document(uid!).collection("requests").add(data)
   

if __name__ == '__main__':
    app.run()