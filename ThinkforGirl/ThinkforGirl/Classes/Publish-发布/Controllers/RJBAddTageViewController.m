//
//  RJBAddTageViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/25.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBAddTageViewController.h"
#import "RJBTagButton.h"
#import "RJBTagTextField.h"

@interface RJBAddTageViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) RJBTagTextField *textField;

/** 添加按钮 */
@property (nonatomic, strong) UIButton *addButton;

/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray<__kindof UIButton *> *tagButtons;

@end

@implementation RJBAddTageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加标签";
    [self setupNav];
    
    [self setupContentView];
    [self setupTextField];
    
}


- (void)setupContentView {
    UIView *bj = [[UIView alloc] init];
    bj.x = RJBTagMargin;
    //RJBTagMargin
    bj.width = self.view.width - 2 * bj.x;
    bj.y = 64 + RJBTagMargin;
    bj.height = RJBScreenH;
    
    self.contentView = bj;
    [self.view addSubview:self.contentView];
    
}
#pragma mark - textField
- (void)setupTextField {
    RJBTagTextField *textField = [RJBTagTextField new];
    textField.placeholder = @"多个标签用逗号或者换行";
    //    [textField sizeToFit];
    textField.width = self.contentView.width;
    __weak typeof(self) weakSelf = self;
    textField.deleteBlock = ^{
        
        if ([weakSelf.textField hasText]) {
            return ;
        }
        [weakSelf deleteBtn:weakSelf.tagButtons.lastObject];
    };
    textField.height = 20;
    textField.delegate = self;
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField becomeFirstResponder];
    [textField addTarget:self action:@selector(textfieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
    
}



//监听textField 的文字输入
- (void)textfieldDidChange {
    
    if (self.textField.hasText) {
        //更新textField的frame
        [self updateTextFieldFrame];
        //有文字
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + RJBTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        //获取最后一个字符 如果输入的是逗号的处理
        NSString *text = self.textField.text;
        NSUInteger len = self.textField.text.length;
        NSString *lastLetter = [self.textField.text substringFromIndex:len - 1];
        NSLog(@"%@",lastLetter);
        if (([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) && len > 1) {
            self.textField.text = [text substringToIndex:len - 1];
            
            
            [self addBtnClick];
        }
        
    }else {
        //没有文字
        self.addButton.hidden = YES;
    }
}


//监听最后下角的点击（换行 go  完成）
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    RJBFunc;
    //点击换行 添加标签
    if (self.textField.hasText) {
        [self addBtnClick];
    }
    
    return YES;
}


//更新textField的frame
- (void)updateTextFieldFrame {
    //如果是最后一个
    UIButton *btn = self.tagButtons.lastObject;
    CGFloat lefTextFieldtWith = self.contentView.width - CGRectGetMaxX(btn.frame) - RJBTagMargin;
    
    if (lefTextFieldtWith >= self.getTextFieldWith) {
        self.textField.x = CGRectGetMaxX(btn.frame) + RJBTagMargin;
        self.textField.y = btn.y;
    }else {
        //显示在下一行
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(btn.frame) + RJBTagMargin;
    }
}


#pragma 按钮的点击事件


- (void)addBtnClick {
    RJBFunc;
    RJBTagButton *btn = [RJBTagButton buttonWithType: UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [btn setTitle:self.textField.text forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.height = self.textField.height;
    [self.tagButtons addObject:btn];
    [self.contentView addSubview:btn];
    
    //清空文字
    self.textField.text = @"";
    self.addButton.hidden = !self.textField.hasText;
    //更新frame
    [self updateTageButtonFrame];
    //更新textFiled
    [self updateTextFieldFrame];
    
}

//标签删除按钮的点击
- (void)deleteBtn:(UIButton *)btn {
    
    [btn removeFromSuperview];
    [self.tagButtons removeObject:btn];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTageButtonFrame];
        [self updateTextFieldFrame];
    }];
    
}

//更新标签按钮的frame
- (void)updateTageButtonFrame {
    
    
    [self.tagButtons enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            btn.x = 0;
            btn.y = 0;
        }else {
            //获取到上一个按钮
            UIButton *lastButton = self.tagButtons[idx - 1];
            //剩余的宽度
            CGFloat leftWith = self.contentView.width - CGRectGetMaxX(lastButton.frame) - RJBTagMargin;
            if (leftWith >= btn.width) {//显示在当行
                btn.x = CGRectGetMaxX(lastButton.frame) + RJBTagMargin;
                btn.y = lastButton.y;
            }else {
                //显示在下一行
                btn.x = 0;
                btn.y = CGRectGetMaxY(lastButton.frame) + RJBTagMargin;
            }
        }
        
    }];
    
}


- (void)setupNav {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancel)];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(post)];
    
//    //appear设置的东西 刷新比较延迟
//    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
//    //强制刷新
//    [self.navigationController.navigationBar  layoutIfNeeded];
}


- (void)cancel {
    NSLog(@"取消");
    
    
}
- (void)post {
    NSLog(@"发表");
    RJBFunc;
}

#pragma mark - lazy
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType: UIButtonTypeCustom];
        _addButton.width = self.contentView.width;
        _addButton.height = 35;
        _addButton.backgroundColor = RJBRGBColor(74, 139, 209);
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _addButton.contentEdgeInsets = UIEdgeInsetsMake(0, RJBTagMargin, 0, RJBTagMargin);
        //让按钮内的图片或者文字 左边对齐
        _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}


- (NSMutableArray *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}


//获取textField的文字
- (CGFloat)getTextFieldWith {
    CGFloat temp = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    
    return MAX(100, temp);
}

@end
