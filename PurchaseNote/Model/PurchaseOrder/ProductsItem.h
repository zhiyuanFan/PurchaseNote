//
//  ProductsItem.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProductsItem : NSObject

/** 商品Id */
@property (nonatomic , assign) NSInteger productId;

/** 分类Id */
@property (nonatomic , assign) NSInteger categoryId;

/** 商品单价 */
@property (nonatomic , assign) CGFloat price;

/** 进货数量 */
@property (nonatomic , assign) NSInteger amount;

/** 商品名称 */
@property (nonatomic , strong) NSString *productName;

/** 图片地址 */
@property (nonatomic , strong) NSString *imageUrl;



@end
