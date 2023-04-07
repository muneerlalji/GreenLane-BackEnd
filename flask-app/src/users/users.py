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

#Add new user
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

    insert_stmt = 'INSERT into users (first_name, last_name, email, dob, address) VALUES ('
    insert_stmt += u_first + ', ' + u_last + ", " + u_email + ", " + u_dob + ", " + u_address + ')'

    current_app.logger.info(insert_stmt)

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success'

    
