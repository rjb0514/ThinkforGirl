//
//  RJBRecommendTagTableViewCell.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/12.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJBRecommendTagsModel;

@interface RJBRecommendTagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *namgeLabel;
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@property (nonatomic, strong) RJBRecommendTagsModel *model;

@end
