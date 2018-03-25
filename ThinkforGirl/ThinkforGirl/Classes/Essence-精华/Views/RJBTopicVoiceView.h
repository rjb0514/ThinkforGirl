//
//  RJBTopicVoiceView.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/1/22.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJBTopicModel;



@interface RJBTopicVoiceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *voiceLenthLabel;

@property (weak, nonatomic) IBOutlet UILabel *voiceVountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bjImageView;

@property (nonatomic, strong) RJBTopicModel *model;

+ (instancetype)voiceView;

@end
