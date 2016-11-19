//
//  PNTextField.h
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/19.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNTextField : UITextField

/** placeholderColor */
@property (nonatomic , strong) UIColor *placeholderColor;

- (instancetype)initWithPlaceholderText:(NSString *)placeholder;

@end
