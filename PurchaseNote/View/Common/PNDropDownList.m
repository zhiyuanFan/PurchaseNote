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

/** tableView */
@property (nonatomic , strong) UITableView *listTableView;


@end

@implementation PNDropDownList

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _listTableView;
}


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
    
    [self addSubview:_txtField];
}

#pragma mark - Text Field Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"begin editing");
    [_txtField resignFirstResponder];
    NSLog(@"view frame : %@",NSStringFromCGRect(self.frame));
    CGFloat tableViewX = self.frame.origin.x;
    CGFloat tableViewY = self.frame.origin.y  + self.frame.size.height;
    CGFloat tableViewWidth = self.frame.size.width;
    CGFloat tableViewHeight = 200;
    
    self.listTableView.frame = CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![window.subviews containsObject:self.listTableView]) {
        [window addSubview:self.listTableView];
    } else {
        [self.listTableView removeFromSuperview];
    }
}



@end
