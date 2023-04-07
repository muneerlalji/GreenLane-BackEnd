from flask import Blueprint, request, jsonify, make_response
import json
from src import db

current_ride = Blueprint('current_ride', __name__)