//
//  main.m
//  HW_NotificationBlock
//
//  Created by Alexander on 26.02.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "MYNotificationCenter.h"
#import "TestObj.h"

int main(int argc, char * argv[])
{
    
   /* TestObj *obj = [TestObj new];
    [[MYNotificationCenter sharedInstance] registerObject:obj selector:@selector(method1) notificationName:@"key1"];
    [[MYNotificationCenter sharedInstance] registerObject:obj selector:@selector(method1) notificationName:@"key2"];
    
    NSLog(@"%@", [[MYNotificationCenter sharedInstance].myData allKeys]);
*/
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
