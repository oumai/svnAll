//
//  UIImage+Thumb.m
//  SchoolMSN
//
//  Created by Vincent on 1/28/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "UIImage+Thumb.h"

//static void drawRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}

@implementation UIImage (Thumb)

- (UIImage *)thumbnailWithHeight:(float)_height width:(float)_width
{
    UIImage *img = nil;
    CGSize itemSize = CGSizeMake(_width, _height);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 2.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self drawInRect:imageRect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)circleThumbnailWithSize:(CGSize)size
{
    UIImage *img = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextFillRect(ctx, imageRect);

    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, imageRect);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    
    [self drawInRect:imageRect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
