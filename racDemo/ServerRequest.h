//
//  ServerRequest.h
//  XTkit
//
//  Created by teason on 14-8-12.
//  Copyright (c) 2014年 teason. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XTReq.h"

@interface ServerRequest : NSObject

+ (void)searchWithString:(NSString *)str
                 success:(void (^)(id json))success
                    fail:(void (^)(void))fail ;

+ (void)getUserInfoSuccess:(void (^)(id json))success
                      fail:(void (^)(void))fail ;

+ (void)zample2WithSuccess:(void (^)(id json))success
                      fail:(void (^)(void))fail ;

+ (void)zample3_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                              success:(void (^)(id json))success
                                 fail:(void (^)(void))fail ;

//+ (void)zample6_GetMovieListWithStart:(NSInteger)start
//                                count:(NSInteger)count
//                           completion:(XTReqSaveJudgment (^)(id json))completion ;

+ (void)zample7_request:(int)bookID
                success:(void (^)(id json))success
                   fail:(void (^)(void))fail ;

@end





