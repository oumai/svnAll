//
//  ProductAddManager.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/27.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductAddManager.h"

 NSString *const kProductTitleImageKey    = @"kProductTitleImageKey";
 NSString *const kProductCidKey           = @"kProductCidKey";
 NSString *const kProductCcidKey          = @"kProductCcidKey";
 NSString *const kProductNameKey          = @"kProductNameKey";
 NSString *const kProductPriceKey         = @"kProductPriceKey";
 NSString *const kProductSellCountKey     = @"kProductSellCountKey";
 NSString *const kProductYongjinKey       = @"kProductYongjinKey";
 NSString *const kProductNoteKey          = @"kProductNoteKey";
 NSString *const kProductNoteImagesKey    = @"kProductNoteImagesKey";
 NSString *const kProductBuyNoteKey       = @"kProductBuyNoteKey";
 NSString *const kProductTimeKey          = @"kProductTimeKey";

@interface ProductAddManager ()
@property (nonatomic, strong) NSMutableDictionary *infoDict;
@end

@implementation ProductAddManager

+(id)sharedProductAddManager {
    static ProductAddManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ProductAddManager alloc] init];
        instance.infoDict = [NSMutableDictionary new];
        CategoryTitle *categoryTitle = [[CategoryTitle alloc] init];
        categoryTitle.id = @"0";
        [instance.infoDict setObject:categoryTitle forKey:kProductCidKey];
        
        CategoryList *categoryList = [[CategoryList alloc] init];
        categoryList.category_id = @"0";
        [instance.infoDict setObject:categoryList forKey:kProductCcidKey];
        
        NSDate *currentDate = [NSDate date];
        
        NSDate *yearDate = [currentDate initWithTimeInterval:60 * 60 * 24 * 365   sinceDate:currentDate]; //一年后
        [instance.infoDict setObject:[NSString stringFromDate:yearDate] forKey:kProductTimeKey];
    });
    
    return instance;
}


-(NSMutableDictionary *)findInfoDict {
    return _infoDict;
}

-(void)removeAll {
    if (nil == _infoDict) {
        return;
    }
    [_infoDict removeAllObjects];
    CategoryTitle *categoryTitle = [[CategoryTitle alloc] init];
    categoryTitle.id = @"0";
    [self.infoDict setObject:categoryTitle forKey:kProductCidKey];
    
    CategoryList *categoryList = [[CategoryList alloc] init];
    categoryList.category_id = @"0";
    [self.infoDict setObject:categoryList forKey:kProductCcidKey];
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *yearDate = [currentDate initWithTimeInterval:60 * 60 * 24 * 365   sinceDate:currentDate]; //一年后
    [self.infoDict setObject:[NSString stringFromDate:yearDate] forKey:kProductTimeKey];
    
}

@end
