//
//  YFSplashScreenView.m
//  YFSplashScreen
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#define kSplashScreenImage @"SplashScreenImage"
#define kImagesSavedFolder @"YFSplashScreenView"

#define fileManager [NSFileManager defaultManager]


#import "YFSplashScreenView.h"


@interface YFSplashScreenView()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *defaultImage;//默认图片
@property (nonatomic, copy) NSString *imageUrl;//显示图片

@end

@implementation YFSplashScreenView

//抽屉效果   每次新的都去请求
-(instancetype)initWithFrame:(CGRect)frame
                defaultImage:(UIImage *)defaultImage{
    if(self == [super initWithFrame:frame]){
        self.defaultImage = defaultImage;
        self.imageUrl = nil;
        [self layout];
    }
    return self;
}

-(void)layout{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];

    NSString *imageName = [self getCurrentLaunchImageNameForOrientation:orientation];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    
    //图片
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.alpha = 0;
    [self addSubview:self.imageView];
    
    
    //以下logo和应用名称  是为了保持和启动画面一致
    //Logo   需要根据这里的位置来做图呀！！！！！
    CGFloat loginWidth = self.bounds.size.width / 6;
    CGFloat loginHeight = loginWidth;
    CGFloat loginX = (self.bounds.size.width - loginWidth) / 2;
    CGFloat loginY = self.bounds.size.height / 7;
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(loginX,loginY, loginWidth, loginHeight)];
    logoView.image = [UIImage imageNamed:@"logo_about180"];
    [self addSubview:logoView];

    //应用名称
    NSString *appName = @"抽屉新热榜";//[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    CGSize nameLabelSize = [appName sizeWithAttributes: @{
                        NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - nameLabelSize.width) / 2, CGRectGetMaxY(logoView.frame) + 10, nameLabelSize.width, nameLabelSize.height)];
    nameLabel.text = appName;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithRed:93/255.0 green:40/255.0 blue:4/255.0 alpha:1];
    [self addSubview:nameLabel];
    
    NSString *path = [self pathToSave];
    if([fileManager fileExistsAtPath:path]){
        NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
        if(data){
            self.imageView.image = [UIImage imageWithData:data];
        }
    }else{
        self.imageView.image = self.defaultImage;
     }
    [self startAnimation:(self.imageView.image == nil) ? 0 : 1];
}


-(void)startAnimation:(CGFloat)duration{
    self.imageView.transform = CGAffineTransformIdentity;
     [UIView animateWithDuration:duration delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         self.imageView.transform = CGAffineTransformMakeScale(1.3,1.3);
         self.imageView.alpha = 1;
         if(_animationStartBlock){
             _animationStartBlock();
         }
     } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration + 0.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //移除
            [self removeFromSuperview];
            if(_animationCompletedBlock){
                _animationCompletedBlock();
            }
        }];
    }];
}

-(void)setImage:(NSString *)imageUrl{
    if(imageUrl == nil) NSLog(@"未设置图片");
    self.imageUrl = imageUrl;
    [self createHttpRequestForImage:imageUrl];
}


-(void)createHttpRequestForImage:(NSString *)imageUrl{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLSessionDownloadTask *pictureDownloadTask = [session downloadTaskWithRequest:request];
    [pictureDownloadTask resume];
}

-(NSString *)pathToSave{
    
    //获取沙盒中的Documents文件路径
    NSString  *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [libraryPath stringByAppendingPathComponent:kImagesSavedFolder];
    
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return [path stringByAppendingPathComponent:kSplashScreenImage];
}

#pragma -m NSURLSessionDownloadDelegate

//完成后
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    NSString *path = [self pathToSave];

    [fileManager removeItemAtPath:path error:nil];
    
    [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];

    NSLog(@"下载成功");
    
    [session invalidateAndCancel];
}

//进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{

}

//调用resumedData方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{

}

-(void)clearImageSavedFolder{
    NSError *error;
    [fileManager removeItemAtPath:[self pathToSave] error:&error];
    NSLog(@"已清空");
}
 

-(NSString *)getCurrentLaunchImageNameForOrientation:(UIInterfaceOrientation)orientation{
    NSString *currentImageName = nil;

    CGSize viewSize = self.bounds.size;
    NSString* viewOrientation = @"Portrait";

    if(UIInterfaceOrientationIsLandscape(orientation)){
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
        viewOrientation = @"Landscape";
    }
    
    NSArray *imageDicts = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary * dic in imageDicts) {
        CGSize imageSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        NSString *orientation = dic[@"UILaunchImageOrientation"];
        if(CGSizeEqualToSize(viewSize, imageSize) && [orientation isEqualToString:viewOrientation]){
            currentImageName = dic[@"UILaunchImageName"];
        }
    }
    
    return currentImageName;
}



@end

