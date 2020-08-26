from flask import Flask 
from flask import render_template 
from flask_sqlalchemy import SQLAlchemy
from models.DB import db_session

from models.objects import SystemUser

app = Flask(__name__)
#TODO- Generate new key ie: print(os.urandom(24))
app.config['SECRET_KEY'] = '\xf2K\xed\xa3\x80r\x03\xd0\xbbv\xbc\x86)7\xbc[#\xf1\xcbT;b\xd6\x82'

db = SQLAlchemy(app)

# API Blueprints 
from api.v1.reading import apiReading
app.register_blueprint(apiReading)
from api.v1.system_user import apiSystemUser
app.register_blueprint(apiSystemUser)

@app.route('/test')
def test():
    return '<h1>You are live pardner!</h1>'


@app.route('/testDB')
def testDB():
    user = db_session.query(SystemUser).filter(SystemUser.system_user_id == 1).one()
    if(user.system_user_id != None):
        return '<h1>DB Connected</h1>'
    else:
        return '<h2>Uh Oh</h2>'

    
