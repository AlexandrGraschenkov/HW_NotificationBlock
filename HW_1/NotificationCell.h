//
//  NotificationCell.h
//  HW_NotificationBlock
//
//  Created by Gena on 23.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCell : NSObject

@property (nonatomic, weak) NSObject *someObj;
@property (nonatomic) SEL selector;

- (void)initWithObject:(NSObject *)obj andSelector:(SEL)sel;

@end
