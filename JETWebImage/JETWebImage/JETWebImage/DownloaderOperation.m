//
//  DownloaderOperation.m
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "DownloaderOperation.h"

@interface DownloaderOperation ()

@property (copy,nonatomic) NSString *urlString;
@property (copy,nonatomic) void(^successBlock)(UIImage *);

@end

@implementation DownloaderOperation

+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString AndSuccessBlock:(void (^)(UIImage *))successBlock
{
    DownloaderOperation *downloaderOP = [[self alloc] init];
    downloaderOP.urlString = urlString;
    downloaderOP.successBlock = successBlock;
    return downloaderOP;
}

@end
