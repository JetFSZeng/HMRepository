//
//  ViewController.m
//  JETWebImage
//
//  Created by ZengFanSheng on 2016/10/23.
//  Copyright © 2016年 HeiMa. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "DownloadOperationManager.h"
#import "UIImageView+Web.h"
#import "YYModel.h"
#import "AppModel.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (strong,nonatomic) NSArray *appList;
@property (copy,nonatomic) NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadJSONData];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_appList.count) {
        return;
    }
    
    
    int random = arc4random_uniform((u_int32_t)_appList.count);
    AppModel *model = _appList[random];
    [self.testImageView JET_setImageWithURLString:model.icon];
}

- (void)loadJSONData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/JetFSZeng/JetRepository/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject;
        _appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:dictArr];
        
        NSLog(@"%@",_appList);
        
        int random = arc4random_uniform((u_int32_t)_appList.count);
        AppModel *model = _appList[random];
        [self.testImageView JET_setImageWithURLString:model.icon];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
