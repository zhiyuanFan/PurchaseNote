//
//  DBHelper.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"

@implementation DBHelper

FMDatabase *_db;
static FMDatabaseQueue *_dbQueue;

+ (FMDatabase *)db {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbName = [path stringByAppendingPathComponent:@"purchase_note.sqlite"];
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbName];
    //取出数据库，这里的db就是数据库，在数据库中创建表
    [_dbQueue inDatabase:^(FMDatabase *db) {
        _db = db;
        if ([_db open]) {
            
            BOOL result1 = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_categories (Id integer PRIMARY KEY AUTOINCREMENT, CategoryId integer, CategoryName text);"];
            
            BOOL result2 = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_products (Id integer PRIMARY KEY AUTOINCREMENT, ProductId integer , CategoryId integer , ProductName text, Price float , Amount integer, ImageUrl text );"];
            
            BOOL result3 = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_notes (Id integer PRIMARY KEY AUTOINCREMENT, NoteId integer , Message text , CreateDate text );"];
            
            if (result1 && result2 && result3) {
                NSLog(@"创表成功");
            } else {
                NSLog(@"创表失败");
            }
        }
    }];
    return _db;
}

@end
