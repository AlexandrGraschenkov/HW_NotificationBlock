//
//  Observer.m
//  HW_NotificationBlock
//
//  Created by Артур Сагидулин on 07.01.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "Observer.h"

@interface Observer()

@property (assign, nonatomic) void(^myBlock)();
@property BOOL isContain;
@property SEL mySelector;
@property __weak NSObject *myObject;

@end


@implementation Observer

- (id)initWithObject:(NSObject *)obj andSelector:(SEL)sel{
    self=[super init];
    if (self) {
        _mySelector = sel;
        _myObject = obj;
    }
    _isContain = YES;
    return self;
}
- (id)initWithBlock:(void(^)())block{
    self = [super init];
    if (self) {
        _myBlock = block;
    }
    _isContain = NO;
    return self;
}

- (void)performAction {
    if (_isContain) {
        [_myObject performSelector:_mySelector];
    } else {
        _myBlock();
    }
}
- (BOOL)isContainObj:(NSObject *)obj{
    return [obj isEqual:_myObject];
}
- (BOOL)isContainBlock:(void(^)())block{
    return (_myBlock == block);
}
- (BOOL)isContainSelector:(SEL)sel{
    return (_mySelector==sel);
}
@end
