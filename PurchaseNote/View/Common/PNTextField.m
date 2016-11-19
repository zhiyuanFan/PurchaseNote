//
//  PNTextField.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/19.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PNTextField.h"

@implementation PNTextField

- (instancetype)initWithPlaceholderText:(NSString *)placeholder
{
    if (self = [super init]) {
        self.placeholder = placeholder;
    }
    return self;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //改变placeholder文字的padding left 为 15
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, self.frame.size.height)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 20;
    }
    return self;
}

@end
