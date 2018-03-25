//
//  RJBTopVideoView.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/2/28.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBTopVideoView.h"
#import "RJBTopicModel.h"
#import "RJBShowPictureViewController.h"
#import <UIImageView+WebCache.h>



@implementation RJBTopVideoView


+ (instancetype)videoView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0].lastObject;
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



- (void)setModel:(RJBTopicModel *)model {
    _model = model;
    
    self.voiceVountLabel.text = [NSString stringWithFormat:@"%zd播放",model.playcount];
    
    //时长
    NSInteger minute = model.videotime / 60;
    NSInteger second = model.videotime  % 60;
    
    self.voiceLenthLabel.text = [NSString stringWithFormat:@"%2zd:%2zd",minute,second];
    [self.bjImageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
}



@end
