from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

# Get user with a particular ID


@users.route('/users/<userID>', methods=['GET'])
def get_user(userID):
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from Users where userID = {userID}')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Add new user
# TODO Find a way to get the next userID number to insert a new user into db.


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

    insert_stmt = f'INSERT INTO Users (userID, lName, fName, email, dob, address) VALUES (102, \'{u_last}\', \'{u_first}\', \'{u_email}\', \'{u_dob}\', \'{u_address}\');'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

# Insert Bike into Docking Station


@users.route('/bikes/<bikeID>/<stationID>', methods=['PUT'])
def insert_bike(bikeID, stationID):
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    num_bikes = f'SELECT numBikes FROM DockingStation WHERE stationID = {stationID}'

    cursor = db.get_db().cursor()
    cursor.execute(num_bikes)
    theData = cursor.fetchall()

    update_stmt1 = 'UPDATE Bikes SET rideStatus = false WHERE bikeID = ' + bikeID + ';'
    update_stmt2 = f'UPDATE DokcingStation SET numBikes = {str(theData[0] + 1)} WHERE bikeID = ' + \
        bikeID + ';'

    current_app.logger.info(update_stmt1)
    current_app.logger.info(update_stmt2)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt1)
    cursor.execute(update_stmt2)
    db.get_db().commit()
    return 'Success'

# Remove Bike from DockingStation


@users.route('/bikes/<bikeID>/<stationID>', methods=['PUT'])
def remove_bike(bikeID, stationID):
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    num_bikes = f'SELECT numBikes FROM DockingStation WHERE stationID = {stationID}'

    cursor = db.get_db().cursor()
    cursor.execute(num_bikes)
    theData = cursor.fetchall()

    update_stmt1 = 'UPDATE Bikes SET rideStatus = true WHERE bikeID = ' + bikeID + ';'
    update_stmt2 = f'UPDATE DokcingStation SET numBikes = {str(theData[0] - 1)} WHERE bikeID = ' + \
        bikeID + ';'

    current_app.logger.info(update_stmt1)
    current_app.logger.info(update_stmt2)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt1)
    cursor.execute(update_stmt2)
    db.get_db().commit()
    return 'Success'

# Get all bikes in a particular city


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

# Get all stations in a particular city


@users.route('/stations/<city>', methods=['GET'])
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

# Delete User account


@users.route('/users/<userID>', methods=['DELETE'])
def delete_account(userID):
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)

    delete_stmt = f'DELETE FROM Users WHERE userID = {userID}'
    current_app.logger.info(delete_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Success'

# Get all Cities


@users.route('cities', methods=['GET'])
def get_all_cities():
    cursor = db.get_db().cursor()
    cursor.execute('Select * From City')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
