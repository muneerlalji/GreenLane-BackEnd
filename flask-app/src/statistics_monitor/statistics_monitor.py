from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db

statistics_monitor = Blueprint('statistics_monitor', __name__)

#Get all users
@statistics_monitor.route('/users', methods=['GET'])
def get_all_users():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Users')
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
    
    docks = str(req_data['docks'])
    num_bikes = str(0)
    city = str(req_data['city'])

    insert_stmt = f'INSERT INTO DockingStation (docks, cityID, numBikes) VALUES ({docks}, {city}, {num_bikes})'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

# Add new bike
@statistics_monitor.route('/bikes', methods=['POST'])
def add_bike():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    maintenance_status = 'false'
    ride_status = 'false'
    station = req_data['station']
    city = req_data['city']

    num_bikes = f'SELECT numBikes FROM DockingStation WHERE stationID = {station};'

    cursor = db.get_db().cursor()
    cursor.execute(num_bikes)
    theData = cursor.fetchall()

    insert_stmt = 'INSERT into Bikes (maintenanceStatus, rideStatus, DS_stationID, C_cityID) VALUES ('
    insert_stmt += maintenance_status + ', ' + ride_status + ', ' + str(station) + ', ' + str(city) + ');'
    update_stmt = f'UPDATE DockingStation SET numBikes = {theData[0][0] + 1} WHERE stationID = {station};'

    current_app.logger.info(insert_stmt)
    current_app.logger.info(update_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    cursor.execute(update_stmt)
    db.get_db().commit()
    return 'Success'

# Delete Docking Station
@statistics_monitor.route('/stations/<stationID>', methods=['DELETE'])
def delete_station(stationID):
    current_app.logger.info('processing form data')

    delete_stmt = f'DELETE FROM DockingStation WHERE stationID = {stationID}'
    current_app.logger.info(delete_stmt)

    update_stmt = f'UPDATE Bikes SET DS_stationID = null WHERE DS_stationID = {stationID}'
    current_app.logger.info(update_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt)
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Success'

#Get all stations in a particular city
@statistics_monitor.route('/stations/<city>', methods=['GET'])
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

#Change storage capacity
@statistics_monitor.route('/stations/<stationID>', methods=['PUT'])
def change_storage_capacity(stationID):
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    docks = req_data['docks']

    update_stmt = 'UPDATE DockingStation SET docks = '
    update_stmt += str(docks) + ' WHERE stationID = ' + str(stationID) + ';'

    current_app.logger.info(update_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt)
    db.get_db().commit()
    return 'Success'

#Get all cities
@statistics_monitor.route('/cities', methods=['GET'])
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