//
//  RJBRecommendUserCell.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBRecommendUserCell.h"
#import "RJBRecommendUserModel.h"
#import <UIImageView+WebCache.h>

@implementation RJBRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RJBRecommendUserModel *)model {
    _model = model;
    self.nameLabel.text = model.screen_name;
    self.fansLabel.text = model.fans_count;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
}

@end
