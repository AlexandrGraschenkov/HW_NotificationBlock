//
//  TestObj.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj

- (id)init
{
    self = [super init];
    if(self){
        [self reset];
    }
    return self;
}

- (void)method1
{
    _method1CallCount++;
    NSLog(@"method 1 %d", _method1CallCount);
}

- (void)method2
{
    _method2CallCount++;
}

- (void)method3
{
    _method3CallCount++;
}

- (void)reset
{
    
    _method1CallCount = _method2CallCount = _method3CallCount = 0;
}

@end
