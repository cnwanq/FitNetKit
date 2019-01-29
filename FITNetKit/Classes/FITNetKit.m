//
//  FITNetKit.m
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import "FITNetKit.h"

@interface FITNetKit ()

@property (nonatomic, strong) NSArray *targets;

@property (nonatomic, strong) NSMutableDictionary<NSString *, FITNetClient *> *targetClients;
@property (nonatomic, strong) FITNetClient *defaultClient;

@property (nonatomic, strong) AFNetworkReachabilityManager *networkReachManager;

@end

@implementation FITNetKit


static FITNetKit *_shareKit = nil;
+ (instancetype)shareKit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareKit = [[FITNetKit alloc] init];
        
        // 只要网络环境发生变化，就会调用此 block
        [_shareKit.networkReachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            /* 枚举里面的四个状态
             AFNetworkReachabilityStatusUnknown          = -1,  未知
             AFNetworkReachabilityStatusNotReachable     = 0,   不可用
             AFNetworkReachabilityStatusReachableViaWWAN = 1,   手机自带网络
             AFNetworkReachabilityStatusReachableViaWiFi = 2,   wifi
             */
            
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未知");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"不可用");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"手机自带网络");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"Wifi");
                    break;
                    
                default:
                    break;
            }
            
            if (_shareKit.reachabilityChange) {
                _shareKit.reachabilityChange(status);
            }
            
        }];
        
        // 开始监听
        [_shareKit.networkReachManager startMonitoring];
        
    });
    return _shareKit;
}

- (void)installTargets:(NSArray<FITNetTarget *> *)targets {
    self.targets = targets;
    for (FITNetTarget *target in targets) {
        FITNetClient *netClient = [[FITNetClient alloc] initWithTarget:target];
        [self.targetClients setValue:netClient forKey:target.baseUrl];
        [self.targetClients setValue:netClient forKey:NSStringFromClass([target class])];
    }
}

+ (FITNetClient *)netClientWithURL:(NSString *)url {
    return [[FITNetKit shareKit].targetClients valueForKey:url];
}

+ (FITNetClient *)netClientWithTarget:(FITNetTarget *)target {
    return [self netClientWithURL:target.baseUrl];
}

+ (void)request:(FITNetRequest *)request {
    
}

+ (void)target:(FITNetTarget *)target request:(FITNetRequest *)request {
    
}

#pragma mark - Getter

- (NSMutableDictionary *)targetClients
{
    if (!_targetClients) {
        _targetClients = [NSMutableDictionary dictionary];
    }
    return _targetClients;
}

- (FITNetClient *)defaultClient
{
    if (!_defaultClient) {
        _defaultClient = [FITNetKit netClientWithTarget:self.targets.firstObject];
    }
    return _defaultClient;
}

- (AFNetworkReachabilityManager *)networkReachManager {
    if (!_networkReachManager) {
        _networkReachManager = [AFNetworkReachabilityManager manager];
    }
    return _networkReachManager;
}


@end
