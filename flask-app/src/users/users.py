from flask import Blueprint, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

#Get user with a particular email
@users.route('/users/<email>', methods=['GET'])
def get_user(email):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customers where email = {0}'.format(email)) #TODO fix query
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

