from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

#Get user with a particular email
@users.route('/users/<email>', methods=['GET'])
def get_user(email):
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from Users where email = {email}')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Add new user
@users.route('/users', methods=['POST'])
def add_user():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    u_first = req_data['first_name']
    u_last = req_data['last_name']
    u_email = req_data['email']
    u_dob = req_data['dob']
    u_address = req_data['address']

    insert_stmt = 'INSERT into Users (first_name, last_name, email, dob, address) VALUES ('
    insert_stmt += u_first + ', ' + u_last + ", " + u_email + ", " + u_dob + ", " + u_address + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

#Change bike usage status
@users.route('/bikes/<bikeID>', methods=['PUT'])
def change_bike_status(bikeID):
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    new_status = req_data['status']

    update_stmt = 'UPDATE Bikes SET rideStatus '
    update_stmt += new_status + ' WHERE bikeID = ' + bikeID + ';'

    current_app.logger.info(update_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt)
    db.get_db().commit()
    return 'Success'

#Get all bikes in a particular city
@users.route('/bikes/<city>', methods=['GET'])
def get_bike_city(city):
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from Bikes where C_cityID = {city}')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Get all stations in a particular city
@users.route('/city/<city>', methods=['GET'])
def get_station_city(city):
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from DockingStation where C_cityID = {city}')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
