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



- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    // So close no matter how far
    return block;
}

// можно только 1 раз подписаться обьекту на событие
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    NSMutableArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:name];
    NotificationCell *cell = [NotificationCell new];
    [cell initWithObject:obj andSelector:selector];
    if (![ar containsObject:cell]) [ar addObject:cell];
    [[MYNotificationCenter sharedInstance].myData setObject:ar forKey:name];
}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    NSMutableArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:name];
    for (NotificationCell *cell in ar) {
        if ([cell.someObj isEqual:obj]) [ar removeObject:cell];
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
    NSArray *keys = [[MYNotificationCenter sharedInstance].myData allKeys];
    for (NSString *key in keys) {
        NSMutableArray *objects = [[MYNotificationCenter sharedInstance].myData objectForKey:key];
        for (NotificationCell *cell in objects) {
            if ([cell.someObj isEqual:obj]) [objects removeObject:cell];
        }
        [[MYNotificationCenter sharedInstance].myData setObject:objects forKey:key];
    }
}

- (void)postNotificationWithName:(NSString*)name
{
    NSArray *ar = [[MYNotificationCenter sharedInstance].myData objectForKey:name];
    for (NotificationCell *cell in ar) {
        [cell.someObj performSelector:cell.selector];
    }
    /*
     Never opened myself this way
     Life is ours, we live it our way
     All these words I don't just say
     And nothing else matters
     */
}

/*The*/ @end
