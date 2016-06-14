//
//  ViewController.m
//  YFSplashScreen
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import "ViewController.h"
#import "YFSplashScreenView.h"
#import "YFAppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    self.view.backgroundColor = [UIColor lightGrayColor];

    NSArray *arrays = @[@"换一张", @"再换一张", @"清空"];
    
    for (int i = 0 ; i < arrays.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 50 + 60 * i, 100, 40);
        button.tag = i + 100;
        button.backgroundColor = [UIColor redColor];
        [button setTitle:arrays[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClick:(UIButton *)button{
    YFSplashScreenView *splashScreenView = ((YFAppDelegate*)[UIApplication sharedApplication].delegate).splashScreenView;
    
    NSInteger tag = button.tag;
    switch (tag - 100) {
        case 0:
            [splashScreenView setImage:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1603/18/c2/19342216_1458277734284_320x480.jpg"];
            break;
        case 1:
            [splashScreenView setImage:@"http://imgsrc.baidu.com/forum/w%3D580/sign=e2d1a4d359b5c9ea62f303ebe538b622/f2abaa51f3deb48f5a1e3306f21f3a292cf57840.jpg"];
            break;
        case 2:
            [splashScreenView clearImageSavedFolder];
            break;
    }
}


@end
