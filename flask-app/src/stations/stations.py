from flask import Blueprint, request, jsonify, make_response
import json
from src import db

stations = Blueprint('stations', __name__)

# Get all stations from the DB
@stations.route('/stations', methods=['GET'])
def get_stations():
    cursor = db.get_db().cursor()
    cursor.execute('select * from stations')
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
@users.route('/stations', methods=['POST'])
def add_station():
    current_app.logger.info('processing form data')
    req_data = request.get_json()
    current_app.logger.info(req_data)
    
    s_location = req_data['location']
    s_capacity = req_data['capacity']

    insert_stmt = 'INSERT into stations (location, capacity) VALUES ('
    insert_stmt += s_location + ', ' + str(s_capacity) + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

