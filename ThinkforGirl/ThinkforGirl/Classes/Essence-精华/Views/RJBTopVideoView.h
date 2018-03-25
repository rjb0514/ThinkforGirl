//
//  RJBTopVideoView.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/2/28.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJBTopicModel;

@interface RJBTopVideoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bjImageView;


@property (weak, nonatomic) IBOutlet UILabel *voiceLenthLabel;

@property (weak, nonatomic) IBOutlet UILabel *voiceVountLabel;


@property (nonatomic, strong) RJBTopicModel *model;

+ (instancetype)videoView;

@end
