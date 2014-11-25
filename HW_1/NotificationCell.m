//
//  NotificationCell.m
//  HW_NotificationBlock
//
//  Created by Gena on 23.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "NotificationCell.h"

@interface NotificationCell()

@property (assign, nonatomic) void(^myBlock)();
    
@end

@implementation NotificationCell {
    __weak NSObject *someObj;
    SEL selector;
    BOOL isContainObject;
//    void(^myBlock)();
}

- (id)initWithObject:(NSObject *)obj andSelector:(SEL)sel
{
    self = [super init];
    if (self) {
        someObj = obj;
        selector = sel;
    }
    isContainObject = YES;
    return self;
}

- (id)initWithBlock:(void(^)())block
{
    self = [super init];
    if (self) {
        _myBlock = block;
    }
    isContainObject = NO;
    return self;
}

- (BOOL)isContainObj:(NSObject *)obj
{
    return [obj isEqual: someObj];
}

- (BOOL)isContainSelector:(SEL)sel
{
    return (selector == sel);
}

- (BOOL)isContainBlock:(void (^)())block
{
    return (_myBlock == block);
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class Foo"
                                 userInfo:nil];
    return nil;
}

- (void)performAction
{
    if (isContainObject) {
        [someObj performSelector:selector];
    } else {
        _myBlock();
    }
}

@end
