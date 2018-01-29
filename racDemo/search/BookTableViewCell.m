//
//  BookTableViewCell.m
//  racDemo
//
//  Created by xtc on 2018/1/29.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "BookTableViewCell.h"
#import "Book.h"

@implementation BookTableViewCell

- (void)prepare {
    self.backgroundColor = [UIColor whiteColor] ;
}

+ (CGFloat)cellHeight {
    return 70 ;
}

- (void)configure:(Book *)book {
    self.lbTitle.text = book.title ;
    self.lbSubTitle.text = book.publisher ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
