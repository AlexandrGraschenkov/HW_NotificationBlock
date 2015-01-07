//
//  Observer.h
//  HW_NotificationBlock
//
//  Created by Артур Сагидулин on 07.01.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observer : NSObject

@property (assign, nonatomic) void(^myBlock)();

- (id)initWithObject:(NSObject *)obj andSelector:(SEL)sel;
- (id)initWithBlock:(void(^)())block;

- (void)performAction;
- (BOOL)isContainObj:(NSObject *)obj;
- (BOOL)isContainBlock:(void(^)())block;
- (BOOL)isContainSelector:(SEL)sel;

@end
