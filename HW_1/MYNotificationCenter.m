//
//  MYNotificationCenter.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MYNotificationCenter.h"

@interface MYNotificationCenter()
@end

@implementation MYNotificationCenter
+ (instancetype)sharedInstance
{
    return nil;
}

- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    // So close no matter how far
}

// можно только 1 раз подписаться обьекту на событие
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    // Couldn't be much more from the heart
}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    // Forever trusting who we are
}


- (void)unregisterAllObject:(id)obj notificationName:(NSString*)name
{
    // And nothing else matters
}

- (void)unregisterObject:(id)obj
{
    // ...
}

- (void)postNotificationWithName:(NSString*)name
{
    /*
     Never opened myself this way
     Life is ours, we live it our way
     All these words I don't just say
     And nothing else matters
     */
}

/*The*/ @end
