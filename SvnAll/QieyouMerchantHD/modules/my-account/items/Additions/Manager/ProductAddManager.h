//
//  ProductAddManager.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/27.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kProductTitleImageKey ;
extern NSString *const kProductCidKey ;
extern NSString *const kProductCcidKey;
extern NSString *const kProductNameKey;
extern NSString *const kProductPriceKey;
extern NSString *const kProductSellCountKey;
extern NSString *const kProductYongjinKey ;
extern NSString *const kProductNoteKey ;
extern NSString *const kProductNoteImagesKey;
extern NSString *const kProductBuyNoteKey;
extern NSString *const kProductTimeKey  ;

@interface ProductAddManager : NSObject

-(NSMutableDictionary *)findInfoDict;
-(void)removeAll;

+(id)sharedProductAddManager;

@end
