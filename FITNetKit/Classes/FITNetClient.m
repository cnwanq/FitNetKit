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
    if (!target || target.baseUrl.length == 0) {
        return nil;
    }
    self = [super initWithBaseURL:[NSURL URLWithString:target.baseUrl]];
    
    // support response content type `text/html`
    NSMutableSet *responseSerializerSet = [NSMutableSet set];
    responseSerializerSet.set = self.responseSerializer.acceptableContentTypes;
    [responseSerializerSet addObject:@"text/html"];
    self.responseSerializer.acceptableContentTypes = responseSerializerSet;
    
    [self updateTarget:target];
    return self;
}

- (void)updateTarget:(FITNetTarget *)target {
    _target = target;
}

- (void)updateSerializer:(FITNetRequest *)request {
    
    switch (request.requestSerializer) {
        case RequestSerializerHTTP:
        {
            AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
            requestSerializer.HTTPShouldHandleCookies = YES;
            self.requestSerializer = requestSerializer;
        }
            break;
        case RequestSerializerJSON:
        {
            AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
            requestSerializer.HTTPShouldHandleCookies = YES;
            self.requestSerializer = requestSerializer;
        }
    }
    switch (request.responseSerializer) {
        case ResponseSerializerXML:
        {
            self.responseSerializer = [AFJSONResponseSerializer serializer];
        }
            break;
        case ResponseSerializerHTTP:
        {
            self.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
            break;
        case ResponseSerializerJSON:
        {
            self.responseSerializer = [AFJSONResponseSerializer serializer];
        }
            break;
    }
}

- (void)updateRequestHeaderValues
{
    if (self.target && self.target.requestHeaderValues) {
        NSDictionary *headerValues = self.target.requestHeaderValues;
        for (NSString *header in headerValues.allKeys) {
            id value = [headerValues valueForKey:header];
            [self.requestSerializer.HTTPRequestHeaders setValue:value forKey:header];
        }
    }
}

- (void)startRequest:(FITNetRequest *)request success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock {
    
    [self updateSerializer:request];
    [self updateRequestHeaderValues];
    
    NSString *url = request.url;
    id parameters = request.parameters;
    
    __weak typeof(self) weakSelf = self;
    switch (request.method) {
        case RequestMethodGET:
        {
            [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [weakSelf handleRequest:request response:responseObject successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
        case RequestMethodPOST:
        {
            [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [weakSelf handleRequest:request response:responseObject successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
        case RequestMethodHEAD:
        {
            [self HEAD:url parameters:parameters success:^(NSURLSessionDataTask *task) {
                [weakSelf handleRequest:request response:nil successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
        case RequestMethodPUT:
        {
            [self PUT:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                [weakSelf handleRequest:request response:responseObject successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
        case RequestMethodDELETE:
        {
            [self DELETE:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                [weakSelf handleRequest:request response:responseObject successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
        case RequestMethodPATCH:
        {
            [self PATCH:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                [weakSelf handleRequest:request response:responseObject successBlock:successBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [weakSelf handleRequest:request error:error failureBlock:failureBlock];
            }];
        }
            break;
    }
}

- (void)handleRequest:(FITNetRequest *)request response:(id)response successBlock:(void (^)(id responseObject))successBlock {
    request.response = response;
    if (self.target && self.target.successBlock) {
        self.target.successBlock(response);
    }
    if (successBlock) {
        successBlock(response);
    }
    
}

- (void)handleRequest:(FITNetRequest *)request error:(NSError *)error failureBlock:(void (^)(NSError *error))failureBlock {
    if (self.target && self.target.failureBlock) {
        self.target.failureBlock(error);
    }
    if (failureBlock) {
        failureBlock(error);
    }
    
}


#pragma mark - Getter



@end
