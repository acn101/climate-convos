//
//  CustomTableViewCell.m
//  
//
//  Created by Sandra Le on 4/26/18.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.size.height -= 2 * 5;
    [super setFrame:frame];
}

@end
