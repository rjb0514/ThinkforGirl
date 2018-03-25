//
//  RJBPushWordViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/20.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBPushWordViewController.h"
#import "RJBAddTagToolBar.h"
#import "RJBTextView.h"

@interface RJBPushWordViewController ()<UITextViewDelegate>

@property (nonatomic, strong) RJBAddTagToolBar *toolBar;

@end

@implementation RJBPushWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布文字";
    [self setupNav];
    [self setupTextView];
    [self setupToolBar];

    
}

- (void)setupToolBar {
    _toolBar = [RJBAddTagToolBar viewFromXib];
    _toolBar.width = self.view.width;
    _toolBar.y = self.view.height - _toolBar.height;
    [self.view addSubview:_toolBar];
    
    //监听Frame的改变
    [RJBNoteCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//键盘的高度
- (void)keyBoardWillChangeFrame:(NSNotification *)note {
    NSLog(@"%@",note);
    //键盘的最终frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.toolBar.transform = CGAffineTransformMakeTranslation(0, RJBScreenH - keyboardF.origin.y);
    
    
}

- (void)setupTextView {
    
    RJBTextView *textView = [[RJBTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片经发局放得开龙角散了发动机萨洛克飞机都是垃圾反倒是垃圾";
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
}

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancel)];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:(UIBarButtonItemStyleDone) target:self action:@selector(post)];
    
    //appear设置的东西 刷新比较延迟
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
    //强制刷新
    [self.navigationController.navigationBar  layoutIfNeeded];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
}

- (void)cancel {
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)post {
    NSLog(@"发表");
}


#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}




@end
