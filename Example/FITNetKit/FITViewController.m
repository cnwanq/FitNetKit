//
//  FITViewController.m
//  FITNetKit
//
//  Created by wanqijian on 01/28/2019.
//  Copyright (c) 2019 wanqijian. All rights reserved.
//

#import "FITViewController.h"
#import "FITNetKit.h"

@interface FITViewController ()

@end

@implementation FITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRequest];
}


- (void)loadRequest
{
    FITNetTarget *target = [FITNetTarget alloc] ;
    target.baseUrl = @"http://t11.klook.io";
    
    FITNetClient *client = [[FITNetClient alloc] initWithTarget:target];
    
    FITNetRequest *request = [[FITNetRequest alloc] init];
    request.requestSerializer = RequestSerializerHTTP;
    request.responseSerializer = ResponseSerializerHTTP;
    request.url = @"/";
    
    [client startRequest:request success:^(id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError * error) {
        NSLog(@"%@", error);
    }];
    
    
}

@end
