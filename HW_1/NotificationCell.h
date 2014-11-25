//
//  NotificationCell.h
//  HW_NotificationBlock
//
//  Created by Gena on 23.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCell : NSObject

- (id)initWithObject:(NSObject *)obj andSelector:(SEL)sel;
- (id)initWithBlock:(void(^)())block;

- (void)performAction;
- (BOOL)isContainObj:(NSObject *)obj;
- (BOOL)isContainBlock:(void(^)())block;
- (BOOL)isContainSelector:(SEL)sel;

@end
