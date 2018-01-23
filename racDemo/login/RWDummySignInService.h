//
//  RWDummySignInService.h
//  racDemo
//
//  Created by xtc on 2018/1/22.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWSignInResponse)(BOOL);

@interface RWDummySignInService : NSObject

- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(RWSignInResponse)completeBlock ;

@end
