//
//  RJBRecommendUserCell.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RJBRecommendUserModel;

@interface RJBRecommendUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) RJBRecommendUserModel *model;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@end
