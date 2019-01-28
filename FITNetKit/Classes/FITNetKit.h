//
//  FITNetKit.h
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITNetTarget.h"
#import "FITNetClient.h"
#import "FITNetRequest.h"


/*
 一个 iOS Objective-C 网络工具
 简单的接入，方便调用，快速开发
 
 需要实现的功能：
 * 支持RESTFul请求 ✔️
 * 支持上传下载
 * 方便维护请求参数 ✔️
 * 支持多 BaseUrl ✔️
 * 支持多请求依赖，合并，并发处理
 * 切面式设置plugin
 */

NS_ASSUME_NONNULL_BEGIN

@class FITNetTarget;

@interface FITNetKit : NSObject

@property (nonatomic, strong, readonly) NSDictionary<NSString *, FITNetClient *> *netTargets;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)shareKit;

+ (void)installTargets:(NSArray<FITNetTarget *> *)targets;

+ (FITNetClient *)netClientWithURL:(NSString *)url;
+ (FITNetClient *)netClientWithTarget:(FITNetTarget *)target;

@end

NS_ASSUME_NONNULL_END
