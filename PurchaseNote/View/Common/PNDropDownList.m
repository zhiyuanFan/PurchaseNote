//
//  PNDropDownList.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/19.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PNDropDownList.h"

@interface PNDropDownList()<UITextFieldDelegate>
{
    UITextField *_txtField;
}

@end

@implementation PNDropDownList

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _txtField = [[UITextField alloc] initWithFrame:self.bounds];
    _txtField.delegate = self;
    _txtField.placeholder = @"--请选择--";
    _txtField.backgroundColor = [UIColor clearColor];
    
    UIView *paddingLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _txtField.leftView = paddingLeftView;
    _txtField.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:@"downArrow"];
    [paddingRightView addSubview:imageView];
    _txtField.rightView = paddingRightView;
    _txtField.rightViewMode = UITextFieldViewModeAlways;
    
    _txtField.layer.borderColor = [UIColor blackColor].CGColor;
    _txtField.layer.borderWidth = 1;
    _txtField.layer.cornerRadius = 20;
    
    [self addSubview:_txtField];
}

#pragma mark - Text Field Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"begin editing");
    [_txtField resignFirstResponder];
}

@end
