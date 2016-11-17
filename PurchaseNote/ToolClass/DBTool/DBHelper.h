//
//  DBHelper.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@interface DBHelper : NSObject

+ (FMDatabase *)db;

@end
