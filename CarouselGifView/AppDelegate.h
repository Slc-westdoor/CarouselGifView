//
//  AppDelegate.h
//  CarouselGifView
//
//  Created by Slc on 2018/1/15.
//  Copyright © 2018年 Slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

