//
//  FITNetClient.h
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FITNetTarget.h"
#import "FITNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FITNetClient : AFHTTPSessionManager

@property (nonatomic, strong, readonly) FITNetTarget *target;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTarget:(FITNetTarget *)target;

- (void)startRequest:(FITNetRequest *)request success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock;


@end

NS_ASSUME_NONNULL_END
