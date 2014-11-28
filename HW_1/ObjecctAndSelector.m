//
//  ObjecctAndSelector.m
//  HW_NotificationBlock
//
//  Created by Daniil Novoselov on 21.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ObjecctAndSelector.h"

@implementation ObjecctAndSelector

-(id) initWithObject:(NSObject*) object andSelector:(SEL) selector
{
    self = [super init];
    self.object = object;
    self.selector = selector;
    
    return self;
}

@end
