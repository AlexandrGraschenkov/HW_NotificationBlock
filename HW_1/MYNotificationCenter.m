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

@property (strong) NSMutableDictionary *observers;

@end

@implementation MYNotificationCenter

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
    _observers = [NSMutableDictionary new];
}

- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    Observer *obs;
    NSMutableSet *obsSetForName = [NSMutableSet setWithSet:[self createSet:notificationName]];
    
    for (Observer *ob in obsSetForName) {
        if ([ob isContainBlock:block]) obs=ob;
    }
    if (!obs) {
        obs = [[Observer alloc]initWithBlock:block];
        [obsSetForName addObject:obs];
    }
    [_observers setObject:obsSetForName forKey:notificationName];
    void(^denyBlock)() = ^(){
        NSMutableArray *obsArrForName = [[MYNotificationCenter sharedInstance].observers objectForKey:notificationName];
        [obsArrForName removeObject:obs];
        [[MYNotificationCenter sharedInstance].observers setObject:obsArrForName forKey:notificationName];
    };
    return denyBlock;
    
}

-(NSSet*)createSet:(NSString*)name{
    if (!_observers) [self initDictionary];
    
    if (![_observers objectForKey:name]) {
        NSMutableSet *emptySet = [NSMutableSet new];
        [_observers setObject:emptySet forKey:name];
    }
    return [_observers objectForKey:name];
}

- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    NSMutableSet *obsSetForName = [NSMutableSet setWithSet:[self createSet:name]];
    BOOL isAlreadyExist = NO;
    for (Observer *ob in obsSetForName) {
        if ([ob isContainObj:obj] && [ob isContainSelector:selector]) isAlreadyExist = YES;
    }
    if (isAlreadyExist==NO) {
        Observer *obs = [[Observer alloc]initWithObject:obj andSelector:selector];
        [obsSetForName addObject:obs];
    }
    [_observers setObject:obsSetForName forKey:name];

}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    NSMutableArray *obsArrForName = [[MYNotificationCenter sharedInstance].observers objectForKey:name];
    for (Observer *ob in obsArrForName) {
        if ([ob isContainObj:obj]) {
            [obsArrForName removeObject:ob];
        }
    }
    [[MYNotificationCenter sharedInstance].observers setObject:obsArrForName forKey:name];
}


- (void)unregisterAllObject:(id)obj notificationName:(NSString*)name
{
    [[MYNotificationCenter sharedInstance].observers setObject:[NSArray new] forKey:name];
}

- (void)unregisterObject:(id)obj
{
    if (!_observers)[self initDictionary];
    
    NSArray *keys = [[MYNotificationCenter sharedInstance].observers allKeys];
    for (NSString *key in keys) {
        NSMutableSet *observersSet = [[MYNotificationCenter sharedInstance].observers objectForKey:key];
        Observer *ob;
        for (Observer *o in observersSet) {
            if ([o isContainObj:obj]) ob=o;
        }
        if (ob) [observersSet removeObject:ob];
        [[MYNotificationCenter sharedInstance].observers setObject:observersSet forKey:key];
    }
}

- (void)postNotificationWithName:(NSString*)name
{
    NSArray *obsArr = [[MYNotificationCenter sharedInstance].observers objectForKey:name];
    for (Observer *ob in obsArr) {
        [ob performAction];
    }
}

/*The*/ @end
