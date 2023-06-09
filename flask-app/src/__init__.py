# Some set up for the application

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()


def create_app():
    app = Flask(__name__)

    # secret key that will be used for securely signing the session
    # cookie and can be used for any other security related needs by
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL.
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = 'greenlanerox'
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    # Change this to your DB name
    app.config['MYSQL_DATABASE_DB'] = 'green_lane'

    # Initialize the database object with the settings above.
    db.init_app(app)

    # Add a default route
    @app.route("/")
    def welcome():
        return "<h1>Welcome to GreenLane</h1>"

    # Import the various routes
    from src.views import views
    from src.users.users import users
    from src.statistics_monitor.statistics_monitor import statistics_monitor

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(users,       url_prefix='/u')
    app.register_blueprint(statistics_monitor,       url_prefix='/s')

    return app
