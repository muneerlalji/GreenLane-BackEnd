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