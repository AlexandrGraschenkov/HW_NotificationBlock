//
//  ObjecctAndSelector.h
//  HW_NotificationBlock
//
//  Created by Daniil Novoselov on 21.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjecctAndSelector : NSObject

@property (nonatomic, weak) NSObject *object;
@property (nonatomic) SEL selector;

-(id) initWithObject:(NSObject*) object andSelector:(SEL) selector;

@end
