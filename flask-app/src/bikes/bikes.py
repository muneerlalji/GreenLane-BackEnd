from flask import Blueprint, request, jsonify, make_response
import json
from src import db

bikes = Blueprint('bikes', __name__)

# Get all bikes from the DB
@bikes.route('/bikes', methods=['GET'])
def get_bikes():
    cursor = db.get_db().cursor()
    cursor.execute('select * from bikes')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#Add new bike
@users.route('/bikes', methods=['POST'])
def add_bike():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    b_type = req_data['type']
    b_location = req_data['location']

    insert_stmt = 'INSERT into stations (location, capacity) VALUES ('
    insert_stmt += b_type + ', ' + b_location + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

#Get bikes in a particular city
@bikes.route('/bikes/<city>', methods=['GET'])
def get_bike(city):
    cursor = db.get_db().cursor()
    cursor.execute('select * from bikes where city_id = {0}'.format(city)) #TODO fix query
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response