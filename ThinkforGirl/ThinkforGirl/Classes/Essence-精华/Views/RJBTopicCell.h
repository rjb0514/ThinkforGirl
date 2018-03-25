//
//  RJBTopicCell.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/21.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJBTopicModel;

@interface RJBTopicCell : UITableViewCell

@property (nonatomic, strong) RJBTopicModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@end
