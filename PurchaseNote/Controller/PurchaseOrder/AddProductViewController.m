//
//  AddProductViewController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "AddProductViewController.h"
#import "Masonry.h"
#import "ProductsItem.h"
#import "DBHelper.h"
#import "PNTextField.h"
#import "PNDropDownList.h"

@interface AddProductViewController ()
{
    UIImageView *_productImageView;
    UILabel *_lblTips;
    UILabel *_lblCategoryName;
    PNDropDownList *_categoryList;
    UITextField *_txtProductName;
    UITextField *_txtPrice;
    UIButton *_submitBtn;
    UIButton *_cancelBtn;
    CGFloat _keyboardHeight;
    
}
@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加商品信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - init

- (void)setupSubviews {
    _productImageView = [[UIImageView alloc] init];
    _productImageView.image = [UIImage imageNamed:@"plus"];
    [self.view addSubview:_productImageView];
    
    _lblTips = [[UILabel alloc] init];
    _lblTips.textAlignment = NSTextAlignmentCenter;
    _lblTips.text = @"添加商品图片";
    [self.view addSubview:_lblTips];
    
    _lblCategoryName = [[UILabel alloc] init];
    _lblCategoryName.textAlignment = NSTextAlignmentCenter;
    _lblCategoryName.text = [NSString stringWithFormat:@"商品类别: "];
    [self.view addSubview:_lblCategoryName];
    
    _categoryList = [[PNDropDownList alloc] initWithFrame:CGRectMake(0, 0, 170, 40)];
    [self.view addSubview:_categoryList];
    
    _txtProductName = [[PNTextField alloc] initWithPlaceholderText:@"请输入商品名称"];
    [self.view addSubview:_txtProductName];
    
    _txtPrice = [[PNTextField alloc] initWithPlaceholderText:@"请输入商品单价"];
    [self.view addSubview:_txtPrice];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitBtn setBackgroundColor:[UIColor orangeColor]];
    _submitBtn.layer.cornerRadius = 20;
    _submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_submitBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundColor:[UIColor orangeColor]];
    _cancelBtn.layer.cornerRadius = 20;
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    [self setupUI];
}


- (void)setupUI {
    
    CGFloat margin = 20;
    CGFloat btnWidth = (self.view.bounds.size.width - 3 * margin) / 2;
    CGFloat btnHeight = 40;

    
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [_lblTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_productImageView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];

    
    [_lblCategoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lblTips.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(margin);
        make.height.mas_equalTo(40);
    }];
    
    [_categoryList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lblTips.mas_bottom).mas_offset(20);
//        make.right.mas_equalTo(-margin);
        make.width.mas_equalTo(170);
        make.left.mas_equalTo(_lblCategoryName.mas_right).mas_offset(0);
        make.height.mas_equalTo(40);
    }];

    [_txtProductName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lblCategoryName.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];

    [_txtPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtProductName.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.left.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];

    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(-margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];

}



#pragma mark - Events

- (void)submitBtnOnClick {
    
    [self dismissVC];
}

- (void)dismissVC {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.view]) {
        [self.view endEditing:YES];
    }
}


#pragma mark - 根据键盘的显示和隐藏修改按钮的约束
- (void)keyboardWillShow:(NSNotification *)note {
    CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardBounds.size.height;
    [self updateSubmitBtnConstraints];
}

- (void)keyboardWillHide:(NSNotification *)note {
    _keyboardHeight = 0;
    [self updateSubmitBtnConstraints];
}

- (void)updateSubmitBtnConstraints {
    CGFloat margin = 20;
    CGFloat btnWidth = (self.view.bounds.size.width - 3 * margin) / 2;
    CGFloat btnHeight = 40;
    
    [_submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-_keyboardHeight - 20);
        make.left.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
    [_cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-_keyboardHeight - 20);
        make.right.mas_equalTo(-margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
    
    [self.view setNeedsUpdateConstraints];
    [UIView animateKeyframesWithDuration:0.25
                                   delay:0
                                 options:7<<16
                              animations:^{
                                  [self.view layoutIfNeeded];
                              }
                              completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
