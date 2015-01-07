//
//  Observer.m
//  HW_NotificationBlock
//
//  Created by Артур Сагидулин on 07.01.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "Observer.h"

@implementation Observer{
    BOOL isContain;
    SEL mySelector;
    __weak NSObject *myObject;
}

- (id)initWithObject:(NSObject *)obj andSelector:(SEL)sel{
    self=[super init];
    if (self) {
        mySelector = sel;
        myObject = obj;
    }
    isContain = YES;
    return self;
}
- (id)initWithBlock:(void(^)())block{
    self = [super init];
    if (self) {
        _myBlock = block;
    }
    isContain = NO;
    return self;
}

- (void)performAction {
    if (isContain) {
        [myObject performSelector:mySelector];
    } else {
        _myBlock();
    }
}
- (BOOL)isContainObj:(NSObject *)obj{
    return [obj isEqual:myObject];
}
- (BOOL)isContainBlock:(void(^)())block{
    return (_myBlock == block);
}
- (BOOL)isContainSelector:(SEL)sel{
    return (mySelector==sel);
}
@end
