//
//  UIImageView+Web.m
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "UIImageView+Web.h"
#import <objc/runtime.h>

@implementation UIImageView (Web)

- (void)setLastURLString:(NSString *)lastURLString
{
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    return objc_getAssociatedObject(self, @"key");
}

- (void)JET_setImageWithURLString:(NSString *)urlString
{
    if (![urlString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        [[DownloadOperationManager sharedManager] cancelDownloadingOperationWithLastURLString:self.lastURLString];
    }
    
    self.lastURLString = urlString;
    
    [[DownloadOperationManager sharedManager] downloadWithURLString:urlString SuccessBlock:^(UIImage *image) {
        self.image = image;
    }];
}


@end
