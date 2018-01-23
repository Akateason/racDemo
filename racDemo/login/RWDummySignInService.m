//
//  RWDummySignInService.m
//  racDemo
//
//  Created by xtc on 2018/1/22.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "RWDummySignInService.h"
#import "ServerRequest.h"
#import <YYModel.h>

@implementation RWDummySignInService

- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(RWSignInResponse)completeBlock
{
    [ServerRequest zample2WithSuccess:^(id json) {
        NSLog(@"%@",json) ;
        if (completeBlock) {
            completeBlock([json yy_modelToJSONString].length > 0) ;
        }
    }
                                 fail:^{
                                     
                                 }] ;
}

@end
