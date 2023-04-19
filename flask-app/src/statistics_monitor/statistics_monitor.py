from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db

statistics_monitor = Blueprint('statistics_monitor', __name__)

#Get all users
@statistics_monitor.route('/users', methods=['GET'])
def get_all_users():
    cursor = db.get_db().cursor()
    cursor.execute('select * from users')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Get all docking stations
@statistics_monitor.route('/stations', methods=['GET'])
def get_all_stations():
    cursor = db.get_db().cursor()
    cursor.execute('select * from DockingStation')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Add new station
@statistics_monitor.route('/stations', methods=['POST'])
def add_station():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    docks = req_data['docks']
    location = req_data['location']
    num_bikes = 0
    city = req_data['city']

    insert_stmt = 'INSERT into DockingStation (docks, location, numBikes, C_cityID) VALUES ('
    insert_stmt += docks + ', ' + location + ", " + num_bikes + ", " + city + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

#Add new bike
@statistics_monitor.route('/bikes', methods=['POST'])
def add_bike():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    maintenance_status = 'false'
    ride_status = 'false'
    type = req_data['type']
    location = req_data['location']
    station = req_data['station']
    city = req_data['city']

    insert_stmt = 'INSERT into Bikes (maintenenceStatus, rideStatus, type, location, DS_stationID, C_cityID) VALUES ('
    insert_stmt += maintenance_status + ', ' + ride_status + ", " + type + ", " + location + ', ' + station + ', ' + city + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'