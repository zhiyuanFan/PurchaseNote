//
//  EmptyView.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "EmptyView.h"
#import "Masonry.h"

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self addSubview:emptyImageView];
    
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.text = @"还没有商品分类,快去添加一个吧";
    [self addSubview:emptyLabel];
    
    [self setupUI];
}

- (void)setupUI {
    
}

@end
