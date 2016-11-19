//
//  DBHelper.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
#import "CategoriesItem.h"
#import "ProductsItem.h"
#import "NotesItem.h"

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

+ (BOOL)doesExsistCategory {
    NSString *selectSql = @"SELECT count(*) AS CategoryCount FROM t_categories";
    FMResultSet *rs = [_db executeQuery:selectSql];
    if ([rs next]) {
        NSInteger categoryCount = [rs intForColumn:@"CategoryCount"];
        return categoryCount > 0 ? YES : NO;
    } else {
        return NO;
    }
}

+ (NSInteger)getMaxCategoryId {
    NSInteger minId = 1;
    if (![self doesExsistCategory]) {
        return minId;
    } else {
        NSString *selectSql = @"SELECT max(CategoryId) AS MaxId ,CategoryName FROM t_categories";
        FMResultSet *rs = [_db executeQuery:selectSql];
        if ([rs next]) {
            NSInteger maxId = [rs intForColumn:@"MaxId"];
            return maxId + 1;
        } else {
            return errorCategoryId;
        }
    }
}

+ (void)addCategoryWithCategoriesItem:(CategoriesItem *)categoriesItem {
    NSNumber *categoryId = [NSNumber numberWithInteger:categoriesItem.categoryId];
    NSString *categoryName = categoriesItem.categoryName;
    if (categoryId && categoryName) {
        NSString *insertSql = @"INSERT INTO t_categories (CategoryId, CategoryName) VALUES (?,?)";
        BOOL result = [_db executeUpdate:insertSql,categoryId,categoryName];
        if (result) {
            NSLog(@"添加成功:商品分类");
        } else {
            NSLog(@"添加失败:商品分类");
        }
    } else {
        NSLog(@"添加失败:缺少参数:商品分类");
        return;
    }
}

+ (NSArray *)getCategoriesItemArray {
    NSMutableArray *itemArray = [NSMutableArray array];
    if ([self doesExsistCategory]) {
        NSString *selectSql = @"SELECT CategoryId ,CategoryName FROM t_categories";
        FMResultSet *rs = [_db executeQuery:selectSql];
        while ([rs next]) {
            CategoriesItem *cItem = [[CategoriesItem alloc] init];
            cItem.categoryId = [rs intForColumn:@"CategoryId"];
            cItem.categoryName = [rs stringForColumn:@"CategoryName"];
            [itemArray addObject:cItem];
        }
    } else {
        NSLog(@"数据获取失败:无数据");
    }
    return itemArray;
}

@end
