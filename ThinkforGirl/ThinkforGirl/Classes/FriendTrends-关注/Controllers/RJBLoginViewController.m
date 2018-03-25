//
//  RJBLoginViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/17.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBLoginViewController.h"

@interface RJBLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moblieTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@end

@implementation RJBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //带有属性的文字 简称 富文本
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, placeholder.length)];
    
    
    self.moblieTextField.attributedPlaceholder = placeholder;
    
    
    
}
- (IBAction)LoginRightBtnClick:(id)sender {
    
    self.leftMarginConstraint.constant = - self.view.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
