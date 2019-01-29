//
//  FITNetRequest.h
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FITNetRequestMethod) {
    RequestMethodGET = 0,
    RequestMethodPOST,
    RequestMethodHEAD,
    RequestMethodPUT,
    RequestMethodDELETE,
    RequestMethodPATCH,
};

typedef NS_ENUM(NSInteger, FITNetRequestSerializer) {
    RequestSerializerHTTP = 0,
    RequestSerializerJSON,
};

typedef NS_ENUM(NSInteger, FITNetResponseSerializer) {
    ResponseSerializerHTTP = 0,
    ResponseSerializerJSON,
    ResponseSerializerXML,
};


@interface FITNetRequest : NSObject

@property (nonatomic, copy, readonly) NSString *baseUrl;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) FITNetRequestMethod method;
@property (nonatomic, assign) NSInteger timeoutInterval;

@property (nonatomic, assign) FITNetRequestSerializer requestSerializer;
@property (nonatomic, assign) FITNetResponseSerializer responseSerializer;

@property (nonatomic, strong) id parameters;
@property (nonatomic, strong) id response;


- (void)requestWithSuccess:(void(^)(id responseData))successBlock Failure:(void(^)(id error))failureBlock;


@end

NS_ASSUME_NONNULL_END
