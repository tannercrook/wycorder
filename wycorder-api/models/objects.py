# coding: utf-8
from sqlalchemy import CheckConstraint, Column, DateTime, ForeignKey, Integer, SmallInteger, String, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

from flask_jsontools import JsonSerializableBase

Base = declarative_base(cls=JsonSerializableBase)
metadata = Base.metadata


class SystemUser(Base):
    __tablename__ = 'system_user'

    system_user_id = Column(Integer, primary_key=True)
    email = Column(String(80), unique=True)
    sis_id = Column(String(50), unique=True)
    token = Column(String(250))
    password = Column(String(250))
    active = Column(Integer, nullable=False, server_default=text("1"))
    created_at = Column(DateTime(True), server_default=text("CURRENT_TIMESTAMP"))


class Reading(Base):
    __tablename__ = 'reading'
    __table_args__ = (
        CheckConstraint("(status)::text = ANY ((ARRAY['Pass'::character varying, 'Fail'::character varying, 'Warn'::character varying])::text[])"),
    )

    reading_id = Column(Integer, primary_key=True)
    system_user_id = Column(ForeignKey('system_user.system_user_id'), nullable=False)
    time_taken = Column(DateTime(True), nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    status = Column(String(10))
    fever_chills = Column(SmallInteger)
    cough = Column(SmallInteger)
    sore_throat = Column(SmallInteger)
    short_breath = Column(SmallInteger)
    fatigue = Column(SmallInteger)
    aches = Column(SmallInteger)
    taste_loss = Column(SmallInteger)
    congestion = Column(SmallInteger)
    nausea_vomit_diarrhea = Column(SmallInteger)
    infectious_contact = Column(SmallInteger)
    temperature = Column(SmallInteger)

    system_user = relationship('SystemUser')
