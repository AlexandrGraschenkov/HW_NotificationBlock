//
//  MYNotificationCenter.h
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CancelNotificationBlock)();

@interface MYNotificationCenter : NSObject

@property (strong) NSMutableDictionary *observers;
@property (strong) NSMutableSet *tempSet;
@property (strong) NSMutableSet *tempSet2;
@property (strong) NSMutableArray *tempArr;

+ (instancetype)sharedInstance;

// возвращает блок для отписки
- (CancelNotificationBlock)registerBlock:(void(^)())block notificationName:(NSString *)notificationName;

// при получении нотификации с name, должен быть вызван метод selector у obj
- (void)registerObject:(id)obj selector:(SEL)selector notificationName:(NSString*)name;
- (void)unregisterObject:(id)obj notificationName:(NSString*)name;
// удаляем все нотификации для обьекта
- (void)unregisterObject:(id)obj;

// уведомляем всех подпиичкиов
- (void)postNotificationWithName:(NSString*)name;

@end
