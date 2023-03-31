from flask import Flask
from flaskext.mysql import MySQL

db = MySQL()

def create_app():
    app = Flask(__name__)
    return app