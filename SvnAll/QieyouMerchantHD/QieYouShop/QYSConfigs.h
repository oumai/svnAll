//
//  QYSConfigs.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#pragma mark - device

#define IS_UP_THAN_IOS8     ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define IS_UP_THAN_IOS7     ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define IS_LESS_THAN_IOS7   ([[[UIDevice currentDevice] systemVersion] floatValue]<=7.9)

#define SCREEN_SIZE (CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height))
#define SCREEN_RECT (CGRectMake(0.0,0.0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height))

#pragma mark - unities

#define APP_SHOW_NETWORK_ACTIVITY   ([UIApplication sharedApplication].networkActivityIndicatorVisible=YES)
#define APP_HIDE_NETWORK_ACTIVITY   ([UIApplication sharedApplication].networkActivityIndicatorVisible=NO)

#pragma mark - UI elements

#define COLOR_HEX2RGB(c)        ([UIColor colorWithRed:(c>>16&0x0000ff)/255.0 green:(c>>8&0x0000ff)/255.0 blue:(c&0x0000ff)/255.0 alpha:1.0f])
#define COLOR_RGBA(r,g,b,a)     ([UIColor colorWithRed:r green:g blue:b alpha:a])

#define COLOR_MAIN_CLEAR        ([UIColor clearColor])
#define COLOR_MAIN_WHITE        ([UIColor whiteColor])
#define COLOR_MAIN_BLACK        ([UIColor blackColor])
#define COLOR_MAIN_BLUE         (COLOR_HEX2RGB(0x1C74E8))
#define COLOR_MAIN_YELLOW       ([UIColor colorWithRed:0.98f green:0.80f blue:0.41f alpha:1.0f])
#define COLOR_MAIN_GREEN        (COLOR_HEX2RGB(0x31b65d))


#define COLOR_MAIN_BORDER_GRAY  ([UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.0f])
#define COLOR_MAIN_BG_GRAY      (COLOR_HEX2RGB(0xf0f0f0))
#define COLOR_SPLITE_BG_GRAY    (COLOR_HEX2RGB(0xf4f4f4))
#define COLOR_CELL_SEPARTATOR   (COLOR_HEX2RGB(0xcccccc))

#define COLOR_BTN_BG_GREEN      ([UIColor colorWithRed:0.18f green:0.74f blue:0.40f alpha:1.0f])
#define COLOR_BTN_BG_DARK_GRAY  ([UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.0f])

#define COLOR_TEXT_BLACK        (COLOR_HEX2RGB(0x333333))
#define COLOR_TEXT_BLUE         (COLOR_HEX2RGB(0x1C74E8))
#define COLOR_TEXT_GRAY         (COLOR_RGBA(0.41, 0.41, 0.41, 1.0))
#define COLOR_TEXT_LIGHT_GRAY   (COLOR_RGBA(0.71, 0.71, 0.71, 1.0))
#define COLOR_TEXT_ORANGE       (COLOR_HEX2RGB(0xff5a00))
#define COLOR_TEXT_RED          ([UIColor redColor])
#define COLOR_TEXT_GREEN        (COLOR_RGBA(0.0, 0.49, 0.38, 1.0))
#define COLOR_TEXT_LIGHT_GREEN  (COLOR_HEX2RGB(0x33bc60))

#define COLOR_RANDOM            ([UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1.0f])

#define FONT_NORMAL             ([UIFont systemFontOfSize:15.0])
#define FONT_NORMAL_14          ([UIFont systemFontOfSize:14.0])
#define FONT_NORMAL_13          ([UIFont systemFontOfSize:14.0])
#define FONT_WITH_SIZE(s)       ([UIFont systemFontOfSize:s])

#pragma mark - notification

#define POST_NORMAL_NOTIFICATION(notification, info) ([[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:info])

#define NOTIFICATION_LOGIN          @"NOTIFICATION_LOGIN"
#define NOTIFICATION_LOGOUT         @"NOTIFICATION_LOGIN"
#define NOTIFICATION_LOGINCHANGE    @"NOTIFICATION_LOGINCHANGE"

#define NOTIFICATION_POPUP_SHOW     @"NOTIFICATION_POPUP_SHOW"
#define NOTIFICATION_POPUP_HIDE     @"NOTIFICATION_POPUP_HIDE"

#pragma mark - URLs

#define API_SECRET_KEY       @"123#$%zz"

#define BASE_DOMAIN      @"qieyou.com"
#define API_URL          @"http://api.qieyou.com/"

#pragma mark - DIRs

#define PATH_IN_DOCUMENTS_DIR(f) ([NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),f])
#define PATH_IN_CACHE_DIR(f) ([NSString stringWithFormat:@"%@/Documents/cache/%@", NSHomeDirectory(),f])

#define SAFE_DICT_VALUE(d,v) ((d[v]&&![d[v] isKindOfClass:[NSNull class]])?d[v]:nil)

#define JDStatusBarNotificationError(error) [JDStatusBarNotification showWithStatus:error dismissAfter:1.5f styleName:JDStatusBarStyleError]
#define JDStatusBarNotificationSuccess(string) [JDStatusBarNotification showWithStatus:string dismissAfter:1.5f styleName:JDStatusBarStyleSuccess];
#define kImageUrl(imageUrl) [NSString stringWithFormat:@"%@%@",kImageAPIBaseUrlString,imageUrl]
#define kPlaceholderImage [UIImage imageNamed:@"common_placehoder_image"]
#define kSetIntenetImageWith(imageView, imageUrl) [imageView sd_setImageWithURL:[NSURL URLWithString:kImageUrl(imageUrl)] placeholderImage:[UIImage imageNamed:@"common_placehoder_image"]];

#define ValidateParam(param) ([param isValid] && ![param isBlank]) ? param : @""

#pragma mark -

@interface QYSConfigs : NSObject

+ (CGSize)screenSize;

+ (CGRect)screenRect;

@end
