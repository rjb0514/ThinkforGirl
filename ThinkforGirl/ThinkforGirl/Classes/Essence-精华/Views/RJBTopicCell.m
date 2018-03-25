//
//  RJBTopicCell.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/21.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBTopicCell.h"
#import "RJBTopicModel.h"
#import <UIImageView+WebCache.h>
#import "NSDate+RJBExtension.h"
#import "RJBTopicPictureView.h"
#import "RJBTopicVoiceView.h"
#import "RJBTopVideoView.h"

@interface RJBTopicCell ()

//图片贴子
@property (nonatomic, strong) RJBTopicPictureView *pictureView;

//声音帖子
@property (nonatomic, strong) RJBTopicVoiceView *voiceView;

/** 视频帖子中间的内容 */
@property (nonatomic, strong) RJBTopVideoView *videoView;

@end


@implementation RJBTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    self.selectionStyle = 0;
}

- (void)setModel:(RJBTopicModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.iconImageView.image = [image circleImage];
    }];
    
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.create_time;
    self.myTextLabel.text = model.text;
    
    
    if (model.type == RJBTopictypePicture) {
        [self addSubview:self.pictureView];
        //图片帖子
        self.pictureView.model = model;
        self.pictureView.frame = model.pictureFrame;

        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;

    }else if (model.type == RJBTopictypeSound) {
        //声音帖子
        [self addSubview:self.voiceView];
        self.voiceView.frame = model.voiceFrame;
        self.voiceView.model = model;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
    }else if (model.type == RJBTopictypeVideo) {
        //视频帖子
        [self addSubview:self.videoView];
        self.videoView.frame = model.videoFrame;
        self.videoView.model = model;
        
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else {
        //段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
}



- (void)testDate:(NSString *)creatTime {
    //当前时间
//    NSDate *nowDate = [NSDate date];
//    //初始化返回的时间
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *creatDate = [fmt dateFromString:creatTime];
//
//    //计算分钟数
//    NSTimeInterval timeInter = [nowDate timeIntervalSinceDate:creatDate];
//
//    NSLog(@"%@   %f",creatTime,timeInter);
//
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //年
//    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
//
//    //月
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:[NSDate date]];
//    //日
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:[NSDate date]];
//
    
    NSDateComponents *componets = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSLog(@"%zd---%zd---%zd",componets.year,componets.month,componets.day);
    
}


- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 *margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    
    
    
    
    
    [super setFrame:frame];
}


#pragma mark - lazy
- (RJBTopicPictureView *)pictureView {
    if (!_pictureView) {
        _pictureView = [RJBTopicPictureView pictureView];
    }
    return _pictureView;
}

- (RJBTopicVoiceView *)voiceView {
    if (!_voiceView) {
        _voiceView = [RJBTopicVoiceView voiceView];
    }
    return _voiceView;
}

- (RJBTopVideoView *)videoView {
    if (!_videoView) {
        _videoView = [RJBTopVideoView videoView];
    }
    return _videoView;
}


@end
