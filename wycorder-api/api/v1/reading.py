# reading.py

# Will hold the API for the reading object


from flask import Flask, Blueprint, render_template, abort, Response, request 
from sqlalchemy.orm import sessionmaker, scoped_session, query, session 
from sqlalchemy.sql.functions import func 
import json

from models.objects import SystemUser, Reading 
from models.DB import db_session 


# Define the blueprint 
apiReading = Blueprint('apiReading', __name__, url_prefix='/api/v1/reading')

@apiReading.route('/', methods=['GET'])
def get():
    user = db_session.query(SystemUser).filter(SystemUser.token == request.headers.get('token')).one()
    if (user.system_user_id != None):
        # Token matches

        # Get the 20 most recent readings
        result = db_session.query(Reading).filter(Reading.system_user_id == user.system_user_id).order_by(Reading.time_taken.desc()).limit(20)
        
        resultJson = []
        db_session.close()

        for item in result:
            resultJson.append(item.__json__()) 

        return json.dumps(resultJson, indent=4, sort_keys=True, default=str), 200, {'content-type': 'application/json', 'Access-Control-Allow-Origin':'*'}
        
    else:
        db_session.close()
        abort(403)

@apiReading.route('/', methods=['PUT'])
def post():
    user = db_session.query(SystemUser).filter(SystemUser.token == request.headers.get('token')).one()
    if (user.system_user_id != None):
        # Token matches
        data = request.form
        reading = Reading()
        reading.system_user_id = user.system_user_id 
        reading.time_taken = data['time_taken']
        status = data['status']
        reading.fever_chills = data['fever_chills']
        reading.cough = data['cough']
        reading.sore_throat = data['sore_throat']
        reading.short_breath = data['short_breath']
        reading.fatigue = data['fatigue']
        reading.aches = data['aches']
        reading.taste_loss = data['taste_loss']
        reading.congestion = data['congestion']
        reading.nausea_vomit_diarrhea = data['nausea_vomit_diarrhea']
        reading.infectious_contact = data['infectious_contact']
        reading.temperature = data['temperature']

        db_session.add(reading)
        db_session.commit()
        db_session.close()

        return json.dumps({'status':data['status']}, indent=4, sort_keys=True, default=str), 200, {'content-type': 'application/json', 'Access-Control-Allow-Origin':'*'}
        
    else:
        db_session.close()
        abort(403)

