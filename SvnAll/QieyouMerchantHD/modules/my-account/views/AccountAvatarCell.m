//
//  AccountAvatarCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/27.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "AccountAvatarCell.h"

@interface AccountAvatarCell ()
@property (nonatomic, strong) UIImageView *avatar;
@end

@implementation AccountAvatarCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"头像";
        self.avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tst-user-avatar"]];
        self.avatar.frame = CGRectMake(400-46-45, (83-46)*0.5, 46, 46);
        self.avatar.layer.cornerRadius = 23.0f;
        self.avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatar];

    }
    return self;
}

-(void) setAvatarImageUrl:(NSString *)avatarImageUrl {
     kSetIntenetImageWith(_avatar, avatarImageUrl);
}

-(void) setAvatarImage:(UIImage *)avatarImage {
    self.avatar.image = avatarImage;
}

@end
