# YFSplashScreen
splash screen just like the app : drawer

[博客园记录: 【IOS】模仿"抽屉新热榜"动态启动页](http://www.cnblogs.com/yffswyf/p/5585157.html) 

##Effection: 

<p/>
 ![splashscreen](https://github.com/yvanwang1992/YFSplashScreen/blob/master/screenshots/splashscreen.gif)


# How To Use It?

####1.#import "YFSplashScreenView.h"

####2.Initialization:<p/>

YFSplashScreenView *splashScreenView = [[YFSplashScreenView alloc] initWithFrame:self.window.bounds defaultImage:[UIImage imageNamed:@"defaultStartScreen"]];

if you don't want defaultImage,just set it nil.

####3.Methods:<p/>
//Set animatable network image.
-(void)setImage:(NSString *)imageUrl;

//Clear all the images saved.
-(void)clearImageSavedFolder;

####4.block:<p/> 
//When the Animation is Started.
splashScreenView.animationStartBlock = ^void(){
NSLog(@"Animation Start......");
};
//When the Animation is Completed.
splashScreenView.animationCompletedBlock = ^void(){
NSLog(@"Animation Completed......");
};

####5.notice:<p/>
1.All the portrait LaunchScreen Images are provided in path /Images/Resources/.
2.if you wanna make your own LaunchScreen Images, Please make sure that The Location of Top Views is the same as the Current LaunchScreen's.
