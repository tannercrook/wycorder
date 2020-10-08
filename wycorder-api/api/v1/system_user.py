# system_user.py

# Will hold the API for the System_User object

from flask import Flask, Blueprint, render_template, abort, Response, request 
from sqlalchemy.orm import sessionmaker, scoped_session, query, session 
from sqlalchemy.sql.functions import func 
from sqlalchemy import or_
from werkzeug.security import generate_password_hash, check_password_hash
import json
import secrets

from models.objects import SystemUser
from models.DB import db_session 

# Define the blueprint 
apiSystemUser = Blueprint('apiSystemUser', __name__, url_prefix='/api/v1/system_user')

@apiSystemUser.route('/', methods=['GET'])
def get():
    user = db_session.query(SystemUser).filter(SystemUser.token == request.headers.get('token')).first()
    if (user != None):
        # Token matches
        
        db_session.close()

        resultJson = user.__json__()

        return json.dumps(resultJson, indent=4, sort_keys=True, default=str), 200, {'content-type': 'application/json'}
        
    else:
        db_session.close()
        abort(403)



@apiSystemUser.route('/auth', methods=['GET','POST'])
def auth():
    user = db_session.query(SystemUser).filter(or_(SystemUser.sis_id == str(request.form['username']).lower(), SystemUser.email == str(request.form['username']).lower())).first()
    if (user != None):
        # Check to see if password matches
        if (check_password_hash(user.password, request.form['password'])):
        
            if (user.token == None):
                # User does not have token, create one
                user.token = secrets.token_urlsafe(32)
                db_session.commit()

            resultJson = user.__json__()
            db_session.close()

            return json.dumps(resultJson, indent=4, sort_keys=True, default=str), 200, {'content-type': 'application/json', 'Access-Control-Allow-Origin':'*'}
        else:
            db_session.close()
            abort(403)
        
    else:
        db_session.close()
        abort(403)
