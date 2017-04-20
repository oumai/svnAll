//
//  UIImage+Thumb.h
//  SchoolMSN
//
//  Created by Vincent on 1/28/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Thumb)

- (UIImage*)thumbnailWithHeight:(float)_height width:(float)_width;

- (UIImage *)circleThumbnailWithSize:(CGSize)size;

@end
