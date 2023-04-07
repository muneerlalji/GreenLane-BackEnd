from flask import Blueprint, request, jsonify, make_response
import json
from src import db

cities = Blueprint('cities', __name__)