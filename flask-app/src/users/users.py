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

    insert_stmt = f'INSERT INTO Users (lName, fName, email, dob, address) VALUES (\'{u_last}\', \'{u_first}\', \'{u_email}\', \'{u_dob}\', \'{u_address}\');'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

# Insert Bike into Docking Station


@users.route('/bikes/return/<bikeID>/<stationID>', methods=['PUT'])
def insert_bike(bikeID, stationID):
    current_app.logger.info('processing form data')
    cursor = db.get_db().cursor()

    get_bikes = f'SELECT numBikes FROM DockingStation WHERE stationID = {stationID}'

    cursor.execute(get_bikes)
    numData = cursor.fetchall()
    num_bikes = numData[0][0]

    this_bike = f'SELECT * FROM Bikes WHERE bikeID = {bikeID}'
    cursor.execute(this_bike)
    bikeData = cursor.fetchall()
    bike = bikeData[0]
    bike_ride_status = bikeData[0][2]
    bike_docking_station = bikeData[0][4]
    current_app.logger.info(bike)
    current_app.logger.info(bike_ride_status)
    current_app.logger.info(bike_docking_station)

    update_stmt1 = 'UPDATE Bikes SET rideStatus = false WHERE bikeID = ' + bikeID + ';'
    update_stmt2 = 'UPDATE Bikes SET DS_stationID = ' + \
        stationID + ' WHERE bikeID =  ' + bikeID + ';'
    update_stmt3 = f'UPDATE DockingStation SET numBikes = {num_bikes + 1} WHERE stationID = ' + \
        stationID + ';'

    current_app.logger.info(update_stmt1)
    current_app.logger.info(update_stmt2)

    cursor.execute(update_stmt1)
    cursor.execute(update_stmt2)
    if bike_ride_status == True:
        cursor.execute(update_stmt3)
    db.get_db().commit()
    return 'Thank you for returning your GreenLane Bike!'

# Remove Bike from DockingStation


@users.route('/bikes/remove/<bikeID>/<stationID>', methods=['PUT'])
def remove_bike(bikeID, stationID):
    current_app.logger.info('processing form data')
    cursor = db.get_db().cursor()

    get_bikes = f'SELECT numBikes FROM DockingStation WHERE stationID = {stationID}'

    cursor.execute(get_bikes)
    numData = cursor.fetchall()
    num_bikes = numData[0][0]

    this_bike = f'SELECT * FROM Bikes WHERE bikeID = {bikeID}'
    cursor.execute(this_bike)
    bikeData = cursor.fetchall()
    bike = bikeData[0]
    bike_ride_status = bikeData[0][2]
    bike_docking_station = bikeData[0][4]
    current_app.logger.info(bike)
    current_app.logger.info(bike_ride_status)
    current_app.logger.info(bike_docking_station)

    update_stmt1 = 'UPDATE Bikes SET rideStatus = false WHERE bikeID = ' + bikeID + ';'
    update_stmt2 = 'UPDATE Bikes SET DS_stationID = null WHERE bikeID =  ' + bikeID + ';'
    update_stmt3 = f'UPDATE DockingStation SET numBikes = {num_bikes - 1} WHERE stationID = ' + \
        stationID + ';'

    current_app.logger.info(update_stmt1)
    current_app.logger.info(update_stmt2)

    cursor.execute(update_stmt1)
    cursor.execute(update_stmt2)
    if bike_ride_status == True:
        cursor.execute(update_stmt3)
    db.get_db().commit()
    return 'Enjoy your ride with GreenLane!'

# Get all bikes in a particular city


@users.route('/bikes/<cityID>', methods=['GET'])
def get_bike_city(cityID):
    cursor = db.get_db().cursor()
    cursor.execute(f'select * from Bikes where C_cityID = {cityID}')
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
    cursor.execute(f'select * from DockingStation where cityID = {city}')
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

    delete_stmt = f'DELETE FROM Users WHERE userID = {userID}'
    current_app.logger.info(delete_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Successfully removed user!'

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
