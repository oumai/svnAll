//
//  QYSPopupView.m
//  QieYouShop
//
//  Created by Vincent on 2/3/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSPopupView.h"
#import "QYSMainContentViewController.h"

@interface QYSPopupView ()

@property (nonatomic, assign) UIWindow *window;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation QYSPopupView

+ (void)hideAll:(void(^)())complete
{
    UIView *v;
    for (int i=(int)[UIApplication sharedApplication].keyWindow.rootViewController.view.subviews.count-1; i>0; i--)
    {
        v = [[UIApplication sharedApplication].keyWindow.rootViewController.view.subviews objectAtIndex:i];
        if ([v isKindOfClass:[QYSPopupView class]])
        {
            [(QYSPopupView *)v hide:YES complete:complete];
        }
    }
}

- (instancetype)init
{
    self.window = [UIApplication sharedApplication].keyWindow;
    
    CGRect win_f = [QYSConfigs screenRect];
    if (IS_LESS_THAN_IOS7)
    {
        win_f = _window.bounds;
    }
    
    self = [super initWithFrame:[QYSConfigs screenRect]];
    if (self)
    {
        {
            UIGraphicsBeginImageContextWithOptions(win_f.size, YES, 2.0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [_window.layer renderInContext:ctx];
            UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
            CGContextClearRect(ctx, win_f);
         
            CGImageRef cg_im = im.CGImage;
            CGDataProviderRef cg_data_provider_ref = CGImageGetDataProvider(cg_im);
            CFDataRef im_data_ref = CGDataProviderCopyData(cg_data_provider_ref);
            
            vImage_Buffer src;
            src.data = (void *)CFDataGetBytePtr(im_data_ref);
            src.width = CGImageGetWidth(cg_im);
            src.height = CGImageGetHeight(cg_im);
            src.rowBytes = CGImageGetBytesPerRow(cg_im);
            
            void *tmp_buffer = (void *)malloc(src.height*src.rowBytes);
            void *vImageRenderBuffer = (void *)malloc(src.height*src.rowBytes);
            
            vImage_Buffer dest;
            dest.data = vImageRenderBuffer;
            dest.width = src.width;
            dest.height = src.height;
            dest.rowBytes = src.rowBytes;
            
            unsigned char bg_color[4] = {1, 1, 1, 1};
            vImageBoxConvolve_ARGB8888(&src, &dest, tmp_buffer, 0, 0, 21, 21, bg_color, kvImageBackgroundColorFill);
            
            CGContextScaleCTM(ctx, 1, -1);
            CGContextTranslateCTM(ctx, 0, win_f.size.height*-1.0);
            
            CGContextRef renderContext = CGBitmapContextCreate(vImageRenderBuffer, src.width, src.height, CGImageGetBitsPerComponent(cg_im), CGImageGetBytesPerRow(cg_im), CGImageGetColorSpace(cg_im), CGImageGetBitmapInfo(cg_im));
            cg_im = CGBitmapContextCreateImage(renderContext);
            CGContextDrawImage(ctx, win_f, cg_im);
            CGImageRelease(cg_im);
            
            im = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:im];
            if (IS_LESS_THAN_IOS7)
            {
                if (UIDeviceOrientationLandscapeLeft == [UIDevice currentDevice].orientation)
                {
                    iv.transform = CGAffineTransformMakeRotation(-M_PI_2);
                }
                else
                {
                    iv.transform = CGAffineTransformMakeRotation(M_PI_2);
                }
                CGRect f = iv.frame;
                f.origin.x = 0.0;
                f.origin.y = 0.0;
                iv.frame = f;
                
#if TARGET_IPHONE_SIMULATOR
                iv.transform = CGAffineTransformMakeRotation(M_PI_2);
                f = iv.frame;
                f.origin.x = 0.0;
                f.origin.y = 0.0;
                iv.frame = f;
#endif
            }
            [self addSubview:iv];
            
            CFRelease(im_data_ref);
            CGContextRelease(renderContext);
            free(tmp_buffer);
            free(vImageRenderBuffer);
        }
        
        self.maskView = [[UIView alloc] init];
        _maskView.backgroundColor = COLOR_MAIN_BLACK;
        _maskView.alpha = 0.0;
        
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
        [_maskView addGestureRecognizer:g];
    }
    return self;
}

#pragma mark -

- (void)show
{
    UIViewController *c = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (c.presentedViewController)
    {
        c = c.presentedViewController;
    }
    
    [c.view addSubview:self];
    
    if ([[(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController) topViewController] isKindOfClass:[QYSMainContentViewController class]])
    {
        POST_NORMAL_NOTIFICATION(NOTIFICATION_POPUP_SHOW, nil);
    }
    
    CGSize scr_s = [QYSConfigs screenSize];
    CGRect f = [QYSConfigs screenRect];
    
    _maskView.frame = self.bounds;
    [self addSubview:_maskView];
    
    _contentView.alpha = 4.0;
    [self addSubview:_contentView];
    
    if (QYSPopupViewContentAlignLeft == _contentAlign)
    {
        UISwipeGestureRecognizer *g = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipGesture:)];
        g.direction = UISwipeGestureRecognizerDirectionRight;
        [_contentView addGestureRecognizer:g];
        
        f = _contentView.frame;
        f.origin.x = scr_s.width;
        _contentView.frame = f;
        f.origin.x = scr_s.width - _contentView.bounds.size.width;
    }
    else if (QYSPopupViewContentAlignCenter == _contentAlign)
    {
        _contentView.center = CGPointMake(scr_s.width*0.5, scr_s.height*0.5);
        
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _maskView.alpha = 0.6;
                         }
                         completion:nil];
        
        [UIView animateWithDuration:0.25
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _contentView.alpha = 1.0;
                         }
                         completion:nil];
        
        return;
    }
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _maskView.alpha = 0.7;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.25
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _contentView.alpha = 1.0;
                         _contentView.frame = f;
                     }
                     completion:nil];
}

- (void)hide:(BOOL)animated complete:(void(^)())complete
{
    if ([[(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController) topViewController] isKindOfClass:[QYSMainContentViewController class]])
    {
        POST_NORMAL_NOTIFICATION(NOTIFICATION_POPUP_HIDE, nil);
    }
    
    CGSize scr_s = [QYSConfigs screenSize];
    CGRect f;
    
    if (QYSPopupViewContentAlignLeft == _contentAlign)
    {
        f = _contentView.frame;
        f.origin.x = scr_s.width;
    }
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _contentView.alpha = 4.0;
                         
                         if (_contentAlign == QYSPopupViewContentAlignLeft)
                         {
                             _contentView.frame = f;
                         }
                         else if (_contentAlign == QYSPopupViewContentAlignCenter)
                         {
                             _contentView.alpha = 0.0;
                         }
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.25
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _maskView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if (!finished)
                         {
                             return ;
                         }
                         
                         [_contentView removeFromSuperview];
                         [_maskView removeFromSuperview];
                         [self removeFromSuperview];
                         
                         if (complete)
                         {
                             complete();
                         }
                     }];
}

#pragma mark -

- (void)onTapGesture:(UITapGestureRecognizer *)gesture
{
    [self removeGestureRecognizer:gesture];
    [self hide:YES complete:nil];
}

- (void)onSwipGesture:(UISwipeGestureRecognizer *)gesture
{
    [_contentView removeGestureRecognizer:gesture];
    [self hide:YES complete:nil];
}

@end
