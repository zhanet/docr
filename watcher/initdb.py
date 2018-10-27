#!/usr/bin/env python
#-*- coding: utf-8 -*-
import psycopg2
import yaml
import sys
import os

import importlib
importlib.reload(sys)
sys.setdefaultencoding('utf8')

try:
    dir_path = os.path.dirname(os.path.realpath(__file__))
    config = yaml.load(open(dir_path + '/config.yaml'))
except yaml.YAMLError as e:
    print(e)
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
    CREATE TABLE IF NOT EXISTS ocr_results (
        id serial, filename text, result text,
        created timestamp DEFAULT current_timestamp
    );""")
    cursor.execute("""INSERT INTO ocr_results (filename, result)
    VALUES ('docr', 'hello world!'), ('美食家', '舌尖上的中国');""")
    cursor.execute("""SELECT * from ocr_results""")
    rows = cursor.fetchall()
    print(rows)
except Exception as e:
    print(e)
    sys.exit(3)
