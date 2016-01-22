//
//  MODbType.h
//  Mobi ORM
//
//  Database types supported by Mobi ORM.
//

#import <Foundation/Foundation.h>

typedef enum {
    INT,
    SMALLINT,
    BIGINT,
    DECIMAL,
    FLOAT,
    DOUBLE,
    VARCHAR,
    CHAR,
    DATE,
    TIME,
    TIMESTAMP,
    TEXT,
    BYTEA,
    BOOLEAN
}
MODbType;