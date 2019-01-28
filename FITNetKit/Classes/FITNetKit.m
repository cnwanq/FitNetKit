//
//  FITNetKit.m
//  FitNetKit_Example
//
//  Created by wanqijian on 2019/1/15.
//  Copyright © 2019 wanqijian. All rights reserved.
//

#import "FITNetKit.h"

@interface FITNetKit ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, FITNetClient *> *netTargets;
@property (nonatomic, strong) FITNetClient *defaultClient;

@end

@implementation FITNetKit


static FITNetKit *_shareKit = nil;
static NSArray *_targets = nil;
+ (instancetype)shareKit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareKit = [[self alloc] init];
    });
    return _shareKit;
}

+ (void)installTargets:(NSArray<FITNetTarget *> *)targets {
    _targets = _targets;
    for (FITNetTarget *target in targets) {
        FITNetClient *netClient = [[FITNetClient alloc] initWithTarget:target];
        [[FITNetKit shareKit].netTargets setValue:netClient forKey:target.baseUrl];
        [[FITNetKit shareKit].netTargets setValue:netClient forKey:NSStringFromClass([target class])];
    }
}

+ (FITNetClient *)netClientWithURL:(NSString *)url {
    return [[FITNetKit shareKit].netTargets valueForKey:url];
}

+ (FITNetClient *)netClientWithTarget:(FITNetTarget *)target {
    return [self netClientWithURL:target.baseUrl];
}

#pragma mark - Getter

- (NSMutableDictionary *)netTargets
{
    if (!_netTargets) {
        _netTargets = [NSMutableDictionary dictionary];
    }
    return _netTargets;
}

- (FITNetClient *)defaultClient
{
    if (!_defaultClient) {
        _defaultClient = [FITNetKit netClientWithTarget:_targets.firstObject];
    }
    return _defaultClient;
}

@end
