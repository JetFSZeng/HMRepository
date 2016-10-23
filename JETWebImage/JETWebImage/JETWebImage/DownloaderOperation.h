//
//  DownloaderOperation.h
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderOperation : NSOperation

+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString  AndSuccessBlock:(void(^)(UIImage *))successBlock;

@end
