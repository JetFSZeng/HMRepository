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

+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString  AndSuccessBlock:(void(^)(UIImage *image))successBlock
{
    DownloaderOperation *downloaderOP = [[self alloc] init];
    downloaderOP.urlString = urlString;
    downloaderOP.successBlock = successBlock;
    return downloaderOP;
}

- (void)main
{
    if (self.isCancelled == YES) {
        return;
    }
//    [NSThread sleepForTimeInterval:1.0];
    
    NSURL *url = [NSURL URLWithString:_urlString];

    if (self.isCancelled == YES) {
        return;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    
    if (image) {
        [data writeToFile:[_urlString appendCachesPath] atomically:YES];
    }
    
    if (self.isCancelled == YES) {
        return;
    }
    
    NSAssert(self.successBlock != nil, @"下载完成的回调,不能为空!!!!!!");
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _successBlock(image);
    }];
}

@end
