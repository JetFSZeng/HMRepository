//
//  UIImageView+Web.h
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadOperationManager.h"

@interface UIImageView (Web)

@property (copy,nonatomic) NSString *lastURLString;

- (void)JET_setImageWithURLString:(NSString *)urlString;

@end
