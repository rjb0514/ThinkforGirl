//
//  RJBRecommendTagCell.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBRecommendTagCell.h"
#import "RJBRecommendTagModel.h"





@implementation RJBRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RJBRGBColor(244, 244, 244);
    
    self.textLabel.textColor =RJBRGBColor(78, 78, 78);
    
    self.textLabel.highlightedTextColor = [UIColor redColor];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.leftRedView.hidden = !selected;
    self.textLabel.highlighted = selected;
}



- (void)setModel:(RJBRecommendTagModel *)model {
    _model = model;
    
    self.textLabel.text = model.name;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.height = self.contentView.height - 2;
}



@end
