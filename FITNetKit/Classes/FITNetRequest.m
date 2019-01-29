//
//  FITNetRequest.m
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import "FITNetRequest.h"

@interface FITNetRequest ()


@end

@implementation FITNetRequest

- (instancetype)init {
    self = [super init];
    [self configRequest];
    return self;
}

- (void)configRequest {
    _method = RequestMethodGET;
    _requestSerializer = RequestSerializerJSON;
    _responseSerializer = ResponseSerializerJSON;
    _timeoutInterval = 60;
}


- (void)requestWithSuccess:(void(^)(id responseData))successBlock Failure:(void(^)(id error))failureBlock {
    
}


@end
