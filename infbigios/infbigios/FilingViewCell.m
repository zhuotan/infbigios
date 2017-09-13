//
//  FilingViewCell.m
//  infbigios
//
//  Created by 谭卓 on 2017/9/7.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "FilingViewCell.h"

@implementation FilingViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
