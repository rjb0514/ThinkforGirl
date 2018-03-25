//
//  RJBTopicPictureView.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/27.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "RJBTopicModel.h"
#import "RJBShowPictureViewController.h"

@implementation RJBTopicPictureView

+ (instancetype)pictureView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0].lastObject;
}


- (void)setModel:(RJBTopicModel *)model {
    _model = model;
    
    //设置图片
    [self.bjImageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.hidden = NO;
            //接受到的东西 除以期望得到的东西
            CGFloat temp = 1.0 * receivedSize/expectedSize;
            [self.progressView setProgress:temp];
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",temp * 100];
            
        });
        
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
        
        //不过不是大图就需要处理
        if (!model.isBigPicture) return;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(model.pictureFrame.size, YES, 0.0);
        //要画的框的 宽度和高度
        CGFloat tempW = model.pictureFrame.size.width;
        CGFloat tempH = image.size.height *tempW/image.size.width;
        [image drawInRect:CGRectMake(0, 0, tempW, tempH)];
        //获取图片
         self.bjImageView.image =  UIGraphicsGetImageFromCurrentImageContext();
        //结束上下文
        UIGraphicsEndImageContext();
        
    }];
    
    /*
     在不知道图片的扩展名的情况下 取出图片的第一个字节 就可以判断出图片的类型
     */
    
    //获取后缀
    NSString *extension = model.large_image.pathExtension;
    if ([extension.lowercaseString isEqualToString:@"gif"]) {
        self.gifImageView.hidden = NO;
    }else {
        self.gifImageView.hidden = YES;
    }
    
    
    //判断是否显示 点击显示大图按钮
    if (model.bigPicure) {
        self.nextButton.hidden = NO;
        self.bjImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else {
        self.nextButton.hidden = YES;
        self.bjImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}


//图片的点击数事件
- (void)tapClick:(UITapGestureRecognizer *)tap {
    NSLog(@"图片的点击");
    [self showPicture];
}

//展示图片
- (void)showPicture {
    RJBShowPictureViewController *VC = [RJBShowPictureViewController new];
    VC.model = self.model;
    [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:VC animated:YES completion:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.bjImageView.userInteractionEnabled = YES;
    [self.bjImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
}

@end
