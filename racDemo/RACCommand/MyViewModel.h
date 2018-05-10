//
//  MyViewModel.h
//  racDemo
//
//  Created by teason23 on 2018/5/10.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACCommand  ;


@interface MyViewModel : NSObject
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, strong, readonly) RACCommand   *loginCommand;
@end
