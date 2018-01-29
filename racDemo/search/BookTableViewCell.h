//
//  BookTableViewCell.h
//  racDemo
//
//  Created by xtc on 2018/1/29.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "RootTableCell.h"

@interface BookTableViewCell : RootTableCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitle;

@end
