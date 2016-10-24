//
//  DownloadOperationManager.h
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloaderOperation.h"

@interface DownloadOperationManager : NSObject

+ (instancetype)sharedManager;


- (void)downloadWithURLString:(NSString *)urlString SuccessBlock:(void(^)(UIImage *image))successBlock;

- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString;

@end
