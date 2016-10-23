//
//  AppModel.m
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@-%@-%@",self.name,self.download,self.icon];
}

@end
