#!/usr/bin/env python
#-*- coding: utf-8 -*-
import psycopg2
import yaml

try:
    config = yaml.load(open('config.yml'))
except yaml.YAMLError as exc:
    print(exc)
    sys.exit(1)

try:
    conn = psycopg2.connect(
        user=config['postgres']['user'],
        password=config['postgres']['password'],
        dbname=config['postgres']['dbname'],
        host=config['postgres']['host'],
        port="5432"
    )
    cursor = conn.cursor()
    cursor.execute("""
    CREATE TABLE ocr_results (
        id serial, filename text, result text,
        created timestamp DEFAULT current_timestamp
    );""")
    cursor.execute("""SELECT * from ocr_results""")
    rows = cursor.fetchall()
    print(rows)
except Exception as e:
    print(e)