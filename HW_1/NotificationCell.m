//
//  NotificationCell.m
//  HW_NotificationBlock
//
//  Created by Gena on 23.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

@synthesize someObj, selector;

- (void)initWithObject:(NSObject *)obj andSelector:(SEL)sel
{
    someObj = obj;
    selector = sel;
}

@end
