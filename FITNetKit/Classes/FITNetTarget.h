//
//  FITNetTarget.h
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FITNetTarget : NSObject

@property (nonatomic, strong) NSString *baseUrl;

@property (nonatomic, strong) NSMutableDictionary *requestHeaderValues;
@property (nonatomic, strong) void(^successBlock)(id);
@property (nonatomic, strong) void(^failBlock)(NSError *);

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

@end

NS_ASSUME_NONNULL_END
