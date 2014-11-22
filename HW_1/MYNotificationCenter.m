//
//  MYNotificationCenter.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MYNotificationCenter.h"

@interface MYNotificationCenter()

@property (nonatomic, strong) NSMutableDictionary *eventDictionary;

@end

@implementation MYNotificationCenter

-(id)init
{
    self = [super init];
    self.eventDictionary = [NSMutableDictionary new];
    return self;
}

+ (instancetype)sharedInstance
{
    static MYNotificationCenter *_center = nil;
    @synchronized(self){
        if (!_center) {
            _center = [MYNotificationCenter new];
        }
    }
    return _center;
}

- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName
{
    CancelNotificationBlock cancelBlock = ^() {
        if ([self.eventDictionary objectForKey:notificationName]) {
            for (id block_ in [self.eventDictionary objectForKey:notificationName]) {
                if (![block_ isKindOfClass:[ObjecctAndSelector class]]) {
                    if ([block_ isEqual:block]){
                        [[self.eventDictionary objectForKey:notificationName] removeObject:block_];
                    }
                }
            }
        }
    };
    
    if (![self.eventDictionary objectForKey:notificationName]) {
        NSMutableArray *notificationArray = [NSMutableArray new];
        [self.eventDictionary setObject:notificationArray forKey:notificationName];
    }
    [[self.eventDictionary objectForKey:notificationName] addObject:block];
    
    return [cancelBlock copy];
}

// можно только 1 раз подписаться обьекту на событие
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name
{
    //Ищем объект класса ObjectAndSelector, который содержит объект, равный obj
    BOOL isExist = false;
    if ([self.eventDictionary objectForKey:name]){
        for (ObjecctAndSelector *objAndSel in [self.eventDictionary objectForKey:name]){
            if([objAndSel.object isEqual:obj]){
                isExist = true;
            }
        }
    }
    
    //Если не нашли, то создаем экземпляр класса ObjectAndSelector, записываем туда obj, selector и добавляем в массив подписчиков события name
    if (!isExist) {
        if (![self.eventDictionary objectForKey:name]) {
            NSMutableArray *notificationArray = [NSMutableArray new];
        [self.eventDictionary setObject:notificationArray forKey:name];
        }
    [[self.eventDictionary objectForKey:name] addObject:[[ObjecctAndSelector alloc]initWithObject:obj andSelector:selector]];
    }
}

- (void)unregisterObject:(id)obj notificationName:(NSString*)name
{
    if ([self.eventDictionary objectForKey:name]){
        for (ObjecctAndSelector *objAndSel in [self.eventDictionary objectForKey:name]){
            if ([objAndSel.object isEqual:obj]){
                [[self.eventDictionary objectForKey:name] removeObject:objAndSel];
            }
        }
    }
}


- (void)unregisterAllObject:(id)obj notificationName:(NSString*)name
{
    if ([self.eventDictionary objectForKey:name]){
        for (ObjecctAndSelector *objAndSel in [self.eventDictionary objectForKey:name]){
            if ([objAndSel isKindOfClass:[ObjecctAndSelector class]]) {
                [[self.eventDictionary objectForKey:name] removeObject:objAndSel];
            }
        }
    }
}

- (void)unregisterObject:(id)obj
{
    //Получаем все ключи словаря и заходя в каждый массив словаря ищем и удаляем (ObjectAndElector *), object которого является obj
    NSArray *keyArray = [self.eventDictionary allKeys];
    for (NSString *key in keyArray) {
        for (ObjecctAndSelector *objAndSel in [self.eventDictionary objectForKey:key]) {
            if ([objAndSel.object isEqual:obj]) {
                [[self.eventDictionary objectForKey:key] removeObject:objAndSel];
            }
        }
    }
}

- (void)postNotificationWithName:(NSString*)name
{
    typedef void(^Block)();
    
    for (id obj in [self.eventDictionary objectForKey:name]) {
        if ([obj isKindOfClass:[ObjecctAndSelector class]]) {
            ObjecctAndSelector *objAndSel = obj;
            if ([objAndSel.object respondsToSelector:objAndSel.selector]) {
                [objAndSel.object performSelector:objAndSel.selector];
            }
        } else if (obj && ![obj isKindOfClass:[ObjecctAndSelector class]]) {
            Block block = [obj copy];
            block();
        }
    }
}

/*The*/ @end
