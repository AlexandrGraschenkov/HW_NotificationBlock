//
//  MYNotificationCenter.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MYNotificationCenter.h"
#import "NotificationCell.h"

@interface MYNotificationCenter()
@end

@implementation MYNotificationCenter

@synthesize myData;

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)initMyData
{
    myData = [NSMutableDictionary new];
}

- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    // So close no matter how far
    if (!myData) [self initMyData];
    if (![myData objectForKey:notificationName]) {
        NSMutableSet *a = [NSMutableSet new];
        //NSMutableArray *a = [NSMutableArray new];
        [myData setObject:a forKey:notificationName];
    }
    NSMutableSet *ar = [myData objectForKey:notificationName];
    //NSMutableArray *ar = [myData objectForKey:notificationName];
    NotificationCell *cell;
    for (NotificationCell *c in ar) {
        if ([c isContainBlock:block]) cell = c;
    }
    if (!cell) {
        cell = [[NotificationCell alloc] initWithBlock:block];
        [ar addObject:cell];
    }
    [myData setObject:ar forKey:notificationName];
    void(^cancelBlock)() = ^() {
        NSMutableArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:notificationName];
//        for (NotificationCell *c in ar) {
//            if ([cell isEqual:c]) [ar removeObject:cell];
//        }
        [ar removeObject:cell];
        [[MYNotificationCenter sharedInstance].myData setObject:ar forKey:notificationName];
    };
    return cancelBlock;
}

// можно только 1 раз подписаться обьекту на событие
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    if (!myData) [self initMyData];
    if (![myData objectForKey:name]) {
        NSMutableSet *a = [NSMutableSet new];
        [myData setObject:a forKey:name];
    }
    NSMutableSet *ar = [myData objectForKey:name];
    BOOL check = YES;
    for (NotificationCell *c in ar) {
        if ([c isContainObj:obj] && [c isContainSelector:selector]) check = NO;
    }
    if (check) {
        NotificationCell *cell = [[NotificationCell alloc] initWithObject:obj andSelector:selector];
        [ar addObject:cell];
    }
    [myData setObject:ar forKey:name];
}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    NSMutableArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:name];
    for (NotificationCell *cell in ar) {
        if ([cell isContainObj:obj]) [ar removeObject:cell];
    }
    [[MYNotificationCenter sharedInstance].myData setObject:ar forKey:name];
    // Forever trusting who we are
}


- (void)unregisterAllObject:(id)obj notificationName:(NSString*)name
{
    NSArray *ar = [NSArray new];
    [[MYNotificationCenter sharedInstance].myData setObject:ar forKey:name];
}

- (void)unregisterObject:(id)obj
{
    if (!myData) [self initMyData];
    NSArray *keys = [[MYNotificationCenter sharedInstance].myData allKeys];
    for (NSString *key in keys) {
        NSMutableSet *objects = [[MYNotificationCenter sharedInstance].myData objectForKey:key];
        NotificationCell *cell;
        for (NotificationCell *c in objects) {
            if ([c isContainObj:obj]) cell = c;
        }
        if (cell) [objects removeObject:cell];
        [[MYNotificationCenter sharedInstance].myData setObject:objects forKey:key];
    }
}

- (void)postNotificationWithName:(NSString*)name
{
    NSArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:name];
    for (NotificationCell *cell in ar) {
        [cell performAction];
    }
    /*
     Never opened myself this way
     Life is ours, we live it our way
     All these words I don't just say
     And nothing else matters
     */
}

/*The*/ @end
