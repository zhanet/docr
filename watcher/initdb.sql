
SET timezone='Asia/Shanghai';
ALTER USER postgres SET timezone='Asia/Shanghai';

DROP TABLE IF EXISTS docr;
CREATE TABLE docr (
    id serial,
    cid integer,
    fname text,
    ocr text,
    docr text,
    edit text,
    editor text,
    created timestamp DEFAULT current_timestamp,
    updated timestamp DEFAULT current_timestamp,
    PRIMARY KEY (id)
);

-- INSERT INTO docr (cid, fname, ocr) VALUES (0, 'dOCR', '使用Docker封装的OCR服务');
