//
//  RJBTopicPictureView.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/27.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DALabeledCircularProgressView;
@class RJBTopicModel;


/**
 帖子里面的图片
 */
@interface RJBTopicPictureView : UIView


+ (instancetype)pictureView;


@property (nonatomic, strong) RJBTopicModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *bjImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;



@end
