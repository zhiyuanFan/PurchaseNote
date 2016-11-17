//
//  CategoriesItem.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesItem : NSObject

/** 分类Id */
@property (nonatomic , assign) NSInteger categoryId;

/** 分类名称 */
@property (nonatomic , strong) NSString *categoryName;


@end
