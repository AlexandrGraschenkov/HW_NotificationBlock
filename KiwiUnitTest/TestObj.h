//
//  TestObj.h
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObj : NSObject

- (void)method1;
- (void)method2;
- (void)method3;

@property (nonatomic, assign) int method1CallCount;
@property (nonatomic, assign) int method2CallCount;
@property (nonatomic, assign) int method3CallCount;

- (void)reset;

@end

