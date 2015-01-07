//
//  MYNotificationCenter.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MYNotificationCenter.h"
#import "Observer.h"
@interface MYNotificationCenter()
@end

@implementation MYNotificationCenter
@synthesize observers,tempSet,tempSet2,tempArr;
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;

}

-(void)initDictionary{
    observers = [[NSMutableDictionary alloc]init];
}

- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    if (!observers) {
        [self initDictionary];
    }
    if (![observers objectForKey:notificationName]) {
        tempSet = [NSMutableSet new];
        [observers setObject:tempSet forKey:notificationName];
    }
    
    tempSet2 = [observers objectForKey:notificationName];
    Observer *obs;
    
    for (Observer *ob in tempSet2) {
        if ([ob isContainBlock:block]) {
            obs=ob;
        }
    }
    if (!obs) {
        obs = [[Observer alloc]initWithBlock:block];
        [tempSet2 addObject:obs];
    }
    [observers setObject:tempSet2 forKey:notificationName];
    void(^denyBlock)() = ^(){
        tempArr = [[MYNotificationCenter sharedInstance].observers objectForKey:notificationName];
        [tempArr removeObject:obs];
        [[MYNotificationCenter sharedInstance].observers setObject:tempArr forKey:notificationName];
    };
    return denyBlock;
    
}

// можно только 1 раз подписаться обьекту на событие
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    if (!observers) {
        [self initDictionary];
    }
    if (![observers objectForKey:name]) {
        tempSet = [NSMutableSet new];
        [observers setObject:tempSet forKey:name];
    }
    tempSet2 = [observers objectForKey:name];
    for (Observer *ob in tempSet2) {
        if (![ob isContainObj:obj] && ![ob isContainSelector:selector]) {
            Observer *obs = [[Observer alloc]initWithObject:obj andSelector:selector];
            [tempSet2 addObject:obs];
        }
    }
    [observers setObject:tempSet2 forKey:name];

}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    tempArr = [[MYNotificationCenter sharedInstance].observers objectForKey:name];
    for (Observer *ob in tempArr) {
        if ([ob isContainObj:obj]) {
            [tempArr removeObject:ob];
        }
    }
    [[MYNotificationCenter sharedInstance].observers setObject:tempArr forKey:name];
}


- (void)unregisterAllObject:(id)obj notificationName:(NSString*)name
{
    [[MYNotificationCenter sharedInstance].observers setObject:[NSArray new] forKey:name];
}

- (void)unregisterObject:(id)obj
{
    if (!observers) {
        [self initDictionary];
    }
    NSArray *keys = [[MYNotificationCenter sharedInstance].observers allKeys];
    for (NSString *key in keys) {
        tempSet = [[MYNotificationCenter sharedInstance].observers objectForKey:key];
        Observer *ob;
        for (Observer *o in tempSet) {
            if ([o isContainObj:obj]) {
                ob=o;
            }
        }
        if (ob) {
            [tempSet removeObject:ob];
        }
        [[MYNotificationCenter sharedInstance].observers setObject:tempSet forKey:key];
    }
}

- (void)postNotificationWithName:(NSString*)name
{
    tempArr = [[MYNotificationCenter sharedInstance].observers objectForKey:name];
    for (Observer *ob in tempArr) {
        [ob performAction];
    }
}

/*The*/ @end
