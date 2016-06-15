# YFSplashScreen
YFSplashScreen is a Dynamic SplashScreen just like the APP : 
["抽屉新热榜"](https://www.microsoft.com/zh-cn/store/phoneappid/b8e9f94d-c1cd-4317-9eef-a9494585b40a/)<p/>
if you set image using url in the app, the next time when the app starting, the image will be shown with animation.

[博客园记录: 【IOS】模仿"抽屉新热榜"动态启动页](http://www.cnblogs.com/yffswyf/p/5585157.html) 

##Effection: 

<p/>
 ![splashscreen](https://github.com/yvanwang1992/YFSplashScreen/blob/master/screenshots/splashscreen.gif)


# How To Use It?

####1.#import "YFSplashScreenView.h"

####2.Initialization:<p/>

YFSplashScreenView *splashScreenView = [[YFSplashScreenView alloc] initWithFrame:self.window.bounds 
                <p/>defaultImage:[UIImage imageNamed:@"defaultStartScreen"]];

if you don't want defaultImage,just set it nil.

####3.Methods:<p/>
//Set animatable network image.
-(void)setImage:(NSString *)imageUrl;

//Clear all the images saved.
-(void)clearImageSavedFolder;

####4.block:<p/> 
//When the Animation is Started.<p/>
splashScreenView.animationStartBlock = ^void(){<p/>
NSLog(@"Animation Start......");<p/>
};<p/>
//When the Animation is Completed.<p/>
splashScreenView.animationCompletedBlock = ^void(){<p/>
NSLog(@"Animation Completed......");<p/>
};

####5.notice:<p/>
1.All the portrait LaunchScreen Images can be seen in path ~./Assets.xcassets/LaunchImage.launchimage/
2.if you wanna make your own LaunchScreen Images, Please make sure that The Location of Top Views is the same as the Current LaunchScreen's.
