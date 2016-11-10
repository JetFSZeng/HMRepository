//
//  NSString+Path.m
//  DownloadWebImage
//
//  Created by ZengFanSheng on 2016/10/22.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "NSString+Path.h"
#import "NSString+Hash.h"

@implementation NSString (Path)

- (NSString *)appendCachesPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSLog(@"--------%@",path);
//    NSString *name = [self lastPathComponent];
    NSString *name = [self md5String];
    
    
    NSString *filePath = [path stringByAppendingString:name];
    
    return filePath;
}


@end
