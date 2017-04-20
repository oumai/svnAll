//
//  AppDelegate.m
//  QieYouShop
//
//  Created by Vincent on 1/28/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "AppDelegate.h"
#import "QYSMainViewController.h"
#import <Reachability.h>

@interface AppDelegate ()

@property (nonatomic, strong) UIImageView *blurCoverView;

@end

@implementation AppDelegate{
    Reachability *_reachability;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (IS_LESS_THAN_IOS7)
    {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    else
    {
        self.window = [[UIWindow alloc] initWithFrame:[QYSConfigs screenRect]];
    }
    
    _window.rootViewController = [QYSMainViewController navController];
    [_window makeKeyAndVisible];
    
    //启动定位
    [[Location sharedLocationManager] startLocation];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    
    return YES;
}

#pragma mark - 当App失去焦点的时候调用（未激活）
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [_reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
    
    //添加模糊效果
    [SQSecurityStrategyTool addBlurEffect];
}

#pragma mark - 在App进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
}

#pragma mark - 在App进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [_reachability startNotifier];
}

#pragma mark - 当App获得焦点的时候调用（已激活）
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [_reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    //移除模糊效果
    [SQSecurityStrategyTool removeBlurEffect];
}

#pragma mark - 当App被关闭的时候会调用（前提条件：App在后台运行的时候）
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - Reachability Notification
- (void)reachabilityChanged:(NSNotification *)notify {
    if ([_reachability currentReachabilityStatus] == NotReachable) {
        [JDStatusBarNotification showWithStatus:@"亲，您好像没有连接到互联网哦！" dismissAfter:1.5f styleName:JDStatusBarStyleError];
    }
    
}

#pragma mark -

@end
