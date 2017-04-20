//
//  LoginingAnimateView.m
//  QieyouMerchant
//
//  Created by 李赛强 on 14/12/30.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "LoginingAnimateView.h"
#import "SQTumblrHud.h"

@interface LoginingAnimateView ()

@property (nonatomic, strong) SQTumblrHud *hud;

@end

@implementation LoginingAnimateView

-(void)dealloc {
    _hud = nil;
}

-(id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        UILabel *label = [UILabel LabelWithFrame:CGRectMake(98, (frame.size.height- 18) /2, 60, 18) text:@"登录中" textColor:[UIColor whiteColor] font:13.0f textAlignment:NSTextAlignmentRight];
        [self addSubview:label];
        
        self.hud = [[SQTumblrHud alloc] initWithFrame:CGRectMake(98 + 60+2 , (frame.size.height-5) / 2, 30, 5)];
        self.hud.hudColor = [UIColor whiteColor];
        [self addSubview:_hud];
        [self.hud showAnimated:YES];
    }
    
    return self;
}

@end
