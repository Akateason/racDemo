//
//  Book.m
//  racDemo
//
//  Created by xtc on 2018/1/29.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "Book.h"
//#import <YYModel.h>

@implementation Book

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"idBook" : @"id" ,
             } ;
}

@end
