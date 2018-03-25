//
//  RJBShowPictureViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/1/2.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBShowPictureViewController.h"
#import "RJBTopicModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <DALabeledCircularProgressView.h>

@interface RJBShowPictureViewController ()

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progeressView;

/**
 图片
 */
@property (strong, nonatomic)  UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;  //返回按钮
@property (weak, nonatomic) IBOutlet UIButton *saveButton;  //保存按钮
@property (weak, nonatomic) IBOutlet UIButton *transmitButtom;  //转发按钮

@end

@implementation RJBShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pictureImageView = [UIImageView new];
    [self.scrollView addSubview:self.pictureImageView];
    
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.transmitButtom addTarget:self action:@selector(transmitButtomClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //计算要显示的图片的高度
    CGFloat pictureW = [UIScreen mainScreen].bounds.size.width;
    CGFloat pictureH = pictureW * self.model.height / self.model.width;
    
    //如果已经超出了屏幕的尺寸
    if (pictureH > [UIScreen mainScreen].bounds.size.height) {
        //需要滚动查看
        self.pictureImageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = self.pictureImageView.frame.size;
    }else {
        //居中显示
        self.pictureImageView.size = CGSizeMake(pictureW, pictureH);
        self.pictureImageView.center = self.scrollView.center;
    }
    
    //这两句代码 是为了防止cell重用的时候 网速慢  下载图片有问题
    [self.progeressView setProgress:self.model.currentProgress ];
    self.progeressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.model.currentProgress  * 100];
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.model.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progeressView.hidden = NO;
            //接受到的东西 除以期望得到的东西
            self.model.currentProgress = 1.0 * receivedSize/expectedSize;
            [self.progeressView setProgress:self.model.currentProgress ];
            self.progeressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.model.currentProgress  * 100];
            
        });
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progeressView.hidden = YES;
        
    }];
}


#pragma mark - 按钮的点击事件
- (void)saveButtonClick:(UIButton *)btn {
    
    NSLog(@"保存按钮的点击");
    
    if (!self.pictureImageView.image) {
        
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完成"];
        return;
    }
    
    
//    [ALAssetsLibrary authorizationStatus];
    PHAuthorizationStatus authorization =  [PHPhotoLibrary authorizationStatus];
    
    if (authorization == PHAuthorizationStatusDenied) {
        //解决
//        [SVProgressHUD showWithStatus:@"相机拒绝访问"];
        [SVProgressHUD showInfoWithStatus:@"相机拒绝访问"];
        [SVProgressHUD dismissWithDelay:2];
       
    }else if (authorization == PHAuthorizationStatusNotDetermined) {
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//
//            if (status == PHAuthorizationStatusAuthorized) {
//                UIImageWriteToSavedPhotosAlbum(self.pictureImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//            }else {
//                [SVProgressHUD showInfoWithStatus:@"相机拒绝访问"];
//                [SVProgressHUD dismissWithDelay:2];
//            }
//
//        }];
          UIImageWriteToSavedPhotosAlbum(self.pictureImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }else {
       
        UIImageWriteToSavedPhotosAlbum(self.pictureImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    
}

- (void)backButtonClick:(UIButton *)btn {
    NSLog(@"返回按钮的点击");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)transmitButtomClick:(UIButton *)btn {
    NSLog(@"转发按钮的点击");
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@",error.description);
    
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    [SVProgressHUD dismissWithDelay:2];
}


@end
