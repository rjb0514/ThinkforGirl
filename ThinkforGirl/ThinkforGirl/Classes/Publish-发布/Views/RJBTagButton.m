//
//  RJBTageButton.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/25.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBTagButton.h"

@implementation RJBTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = RJBTagBtnBJ;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
     self.width += RJBTagMargin * 3;
}

- (void)layoutSubviews {
    [super layoutSubviews];
   
    self.titleLabel.x = RJBTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + RJBTagMargin ;
    
    
}

@end
