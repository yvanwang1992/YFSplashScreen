//
//  YFSplashScreenView.h
//  YFSplashScreen
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

typedef void(^AnimationCompletedBlock)();
typedef void(^AnimationStartBlock)();

@interface YFSplashScreenView : UIView

@property (nonatomic, assign) AnimationCompletedBlock animationCompletedBlock;
@property (nonatomic, assign) AnimationStartBlock animationStartBlock;

//可以自定义动画
//也可以执行某些事情  //让用户自己移除本页面
-(instancetype)initWithFrame:(CGRect)frame
                defaultImage:(UIImage *)defaultImage;

-(void)setImage:(NSString *)imageUrl;

-(void)clearImageSavedFolder;

@end