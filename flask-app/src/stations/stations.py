from flask import Blueprint, request, jsonify, make_response
import json
from src import db

stations = Blueprint('stations', __name__)

# Get all stations from the DB
@stations.route('/stations', methods=['GET'])
def get_stations():
    cursor = db.get_db().cursor()
    cursor.execute('select stationId, location,\
        numBikes from stations')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

