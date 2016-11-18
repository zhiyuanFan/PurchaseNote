//
//  DBHelper.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define errorCategoryId 500

@class FMDatabase,CategoriesItem;
@interface DBHelper : NSObject

/**
 创建数据库
 */
+ (FMDatabase *)db;

/**
 判断是否存在商品分类
 */
+ (BOOL)doesExsistCategory;

/**
 获取商品分类最大Id
 */
+ (NSInteger)getMaxCategoryId;

/**
 新建商品分类
 */
+ (void)addCategoryWithCategoriesItem:(CategoriesItem *)categoriesItem;

/**
 获取商品分类
 */
+ (NSArray *)getCategoriesItemArray;

@end
