#!/usr/bin/env python
#-*- coding: utf-8 -*-
import psycopg2
import yaml

try:
    config = yaml.load(file(os.getcwd() + '/config.yaml', 'r'))
except yaml.YAMLError, e:
    print "Error in configuration file: ", e
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
    cursor.execute("""CREATE TABLE ocr_results (name char(40));""")
    cursor.execute("""SELECT * from ocr_results""")
    rows = cursor.fetchall()
    print(rows)
except Exception as e:
    print(e)