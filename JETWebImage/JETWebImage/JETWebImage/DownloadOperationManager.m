//
//  DownloadOperationManager.m
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "DownloadOperationManager.h"

@interface DownloadOperationManager ()

@property (strong,nonatomic) NSOperationQueue *queue;
@property (strong,nonatomic) NSMutableDictionary *operationsCache;
@property (strong,nonatomic) NSMutableDictionary *imagesCache;

@end

@implementation DownloadOperationManager

+ (instancetype)sharedManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _queue = [[NSOperationQueue alloc] init];
        _operationsCache = [[NSMutableDictionary alloc] init];
        _imagesCache = [[NSMutableDictionary alloc] init];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanMemoryCache) name:@"UIApplicationDidReceiveMemoryWarningNotification" object:nil];
    
    return self;
}

- (void)cleanMemoryCache
{
    if (_imagesCache.count != 0) {
         [_imagesCache removeAllObjects];
    }

}


//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


- (BOOL)checkCachesWithURLString:(NSString *)urlString
{
    if ([_imagesCache objectForKey:urlString]) {
        return YES;
    }
    
    UIImage *cacheImg = [UIImage imageWithContentsOfFile:[urlString appendCachesPath]];
    if (cacheImg) {
        [_imagesCache setObject:cacheImg forKey:urlString];
        return YES;
    }
    
    return NO;
}

- (void)downloadWithURLString:(NSString *)urlString SuccessBlock:(void(^)(UIImage *image))successBlock
{
    if ([self checkCachesWithURLString:urlString]) {
        if (successBlock) {
            UIImage *memoryImg = [_imagesCache objectForKey:urlString];
            successBlock(memoryImg);
            return;
        }
    }
    
    if ([_operationsCache objectForKey:urlString]) {
        return;
    }
    
    DownloaderOperation *DO = [DownloaderOperation downloaderOperationWithURLString:urlString AndSuccessBlock:^(UIImage *image) {
        if (image) {
            [_imagesCache setObject:image forKey:urlString];
        }
        
        if (successBlock) {
            successBlock(image);
        }
        
        [_operationsCache removeObjectForKey:urlString];
    }];
    
    [_queue addOperation:DO];
}

- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString
{
    [[_operationsCache objectForKey:lastURLString] cancel];
    
    [_operationsCache removeObjectForKey:lastURLString];
}

@end
