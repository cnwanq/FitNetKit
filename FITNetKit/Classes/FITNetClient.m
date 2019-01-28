//
//  FITNetClient.m
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import "FITNetClient.h"
#import "FITNetRequest.h"

@interface FITNetClient ()

@property (nonatomic, strong) FITNetTarget *target;

@end

@implementation FITNetClient

- (instancetype)initWithTarget:(FITNetTarget *)target {
    self = [super initWithBaseURL:[NSURL URLWithString:target.baseUrl]];
    [self updateTarget:target];
    return self;
}

- (void)updateTarget:(FITNetTarget *)target {
    _target = target;
}


- (void)startRequest:(FITNetRequest *)request success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock {
    
    switch (request.method) {
        case RequestMethodGET:
        {
            [self GET:request.url parameters:request.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            break;
        case RequestMethodPOST:
        {
            
        }
            break;
        case RequestMethodHEAD:
        {
            
        }
            break;
        case RequestMethodPUT:
        {
            
        }
            break;
        case RequestMethodDELETE:
        {
            
        }
            break;
        case RequestMethodPATCH:
        {
            
        }
            break;
    }
    
    
}


#pragma mark - Getter



@end
