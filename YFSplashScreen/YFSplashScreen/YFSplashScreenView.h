//
//  YFSplashScreenView.h
//  YFSplashScreen
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

typedef void(^AnimationBlock)();

@interface YFSplashScreenView : UIView

@property (nonatomic, assign) AnimationBlock animationCompletedBlock;
@property (nonatomic, assign) AnimationBlock animationStartBlock;


-(instancetype)initWithFrame:(CGRect)frame
                defaultImage:(UIImage *)defaultImage;

-(void)setImage:(NSString *)imageUrl;

-(void)clearImageSavedFolder;

@end