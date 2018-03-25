//
//  RJBTextView.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/20.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBTextView.h"

@interface RJBTextView ()

/**占位文字 label*/
@property (nonatomic, strong) UILabel *placeholderLabel;


@end


@implementation RJBTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //placeholderLabel
        //默认站位 文字颜色
        self.placeholderColor = [UIColor redColor];
        self.font = [UIFont systemFontOfSize:18];
        //默认垂直方向滚动
        self.alwaysBounceVertical = YES;
        //代码改 text 不会走通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}


- (void)textDidChange {
    //只要有文字就隐藏占位位子
    self.placeholderLabel.hidden = self.hasText;
    
}

/**
 更新占位文字的 尺寸
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(self.frame.size.width - 4, self.frame.size.height);
    
    CGSize tempSize = [self.placeholder boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:nil].size;
    //4 7 表示文字有点距离 要不就贴住父控件 很难看
    self.placeholderLabel.frame = CGRectMake(2, 7, tempSize.width, tempSize.height);
}


#pragma mark -防止随时改变文字颜色没效果
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    //更新占位文字高度
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    //更新占位文字高度
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    //为了安全起见 怕外界 直接调用设置文字 所以占位Lable还得判断
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];

    //为了安全起见 怕外界 直接调用设置文字 所以占位Lable还得判断
    [self textDidChange];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - lazy
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.numberOfLines = 0;
        [self addSubview:_placeholderLabel];
        //默认站位 文字大小
        _placeholderLabel.font = [UIFont systemFontOfSize:18];
    }
    return _placeholderLabel;
}


@end
