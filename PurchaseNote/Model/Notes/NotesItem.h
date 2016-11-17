//
//  NotesItem.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotesItem : NSObject

/** 备注Id */
@property (nonatomic , assign) NSInteger notesId;

/** 备注信息 */
@property (nonatomic , strong) NSString *message;

/** 创建日期 */
@property (nonatomic , strong) NSString *createDate;



@end
