from flask import Blueprint, request, jsonify, make_response
import json
from src import db

bikes = Blueprint('bikes', __name__)

# Get all bikes from the DB
@bikes.route('/bikes', methods=['GET'])
def get_bikes():
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