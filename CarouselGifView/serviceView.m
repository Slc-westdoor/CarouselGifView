//
//  serviceView.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "serviceView.h"
#import "XRCarouselView.h"
#import "CRMediaPickerController.h"

@interface serviceView ()<XRCarouselViewDelegate,CRMediaPickerControllerDelegate>
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (strong, nonatomic) XRCarouselView *carouselView2;
@property (strong, nonatomic) CRMediaPickerController *mediaPickerController;
@end

@implementation serviceView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.5];
    [self initNavigationItems];
    [self scrollView];
    [self creatViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
  
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

-(void)initNavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationBar];
    [navigationBar pushNavigationItem:[self addNavigationItemRight:nil Title:@"服务" bartitle:@"选择视频" color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(turnTovc)] animated:NO];
    
}

//设定右边导航按钮
-(UINavigationItem *)addNavigationItemRight:(NSString *)Image Title:(NSString *)title bartitle:(NSString *)btitle color:(UIColor *)color barcolor:(UIColor *)bcolor target:(id)Target
                                     action:(SEL)Action
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    lab.text=title;
    lab.textColor=color;
    
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]initWithTitle:@""];
    navigationItem.titleView=lab;
    
    //右侧添加导航
    UIBarButtonItem * ButtonRight=[[UIBarButtonItem alloc]initWithTitle:btitle style:UIBarButtonItemStyleDone target:Target action:Action];
    [ButtonRight setTintColor:bcolor];
    [ButtonRight setImage:[UIImage imageNamed:Image]];
    //ButtonRight.enabled=NO;
    navigationItem.rightBarButtonItem=ButtonRight;
    
    //添加内容到导航栏
    return navigationItem;
    
}



-(void)creatViews{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"cat" withExtension:@"gif"];
    _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 150) fileURL:fileUrl];
    _gifView.backgroundColor = [UIColor clearColor];
    _gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_gifView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(50, self.view.frame.size.height - 80, 100, 60);
    btn.center = CGPointMake(100, self.view.bounds.size.height - 80);
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn setTitle:@"Start Gif" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(self.view.frame.size.width - 150, self.view.frame.size.height - 80, 100, 60);
    btn2.center = CGPointMake(220, self.view.bounds.size.height - 80);
    btn2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn2 setTitle:@"Stop Gif" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(stopGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}



//轮播图
-(void)scrollView{
    NSArray *arr2 = @[[UIImage imageNamed:@"one.jpg"], [UIImage imageNamed:@"two.jpg"], [UIImage imageNamed:@"three.jpg"]];

    NSArray *arr3 = @[[UIImage imageNamed:@"one.jpg"], [UIImage imageNamed:@"two.jpg"], [UIImage imageNamed:@"three.jpg"]];
    
    NSArray *describeArray = @[@"这是第一张图片的描述", @"这是第二张图片的描述", @"这是第三张图片的描述", @"这是第四张图片的描述"];
    
    //创建方式1
    //    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr1];
    
    //创建方式2
    //    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr2 imageClickBlock:^(NSInteger index) {
    //        NSLog(@"第%ld张图片被点击", index);
    //    }];
    
    //创建方式3
    self.carouselView = [XRCarouselView carouselViewWithImageArray:arr2 describeArray:describeArray];
    
    
    //设置frame
    self.carouselView.frame = CGRectMake(0, 64, self.view.frame.size.width, 150);
    
    //用block处理图片点击
    self.carouselView.imageClickBlock = ^(NSInteger index) {
        //        NSLog(@"1幅图第%ld张图片被点击",(long)index);
    };
    
    //用代理处理图片点击，如果两个都实现，block优先级高于代理
    self.carouselView.delegate = self;
    
    //设置每张图片的停留时间
    _carouselView.time = 1.5;
    
    //设置分页控件的图片
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的frame
    CGFloat width = arr3.count * 30;
    CGFloat height = 20;
    CGFloat x = _carouselView.frame.size.width - width - 10;
    CGFloat y = _carouselView.frame.size.height - height - 20;
    _carouselView.pageControl.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:_carouselView];
    
    //最简单的使用方式
    self.carouselView2 = [[XRCarouselView alloc]initWithFrame: CGRectMake(0, 269, self.view.frame.size.width, 150)];
    self.carouselView2.imageClickBlock = ^(NSInteger index) {
        //        NSLog(@"2幅图第%ld张图片被点击",(long)index);
    };
    self.carouselView2.delegate = self;
    //其他的颜色
    self.carouselView2.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    //当前的颜色
    self.carouselView2.pageControl.currentPageIndicatorTintColor = [UIColor brownColor];
    //self.carouselView2.imageArray=arr3;
    [_carouselView2 setImageArray:arr3];
    _carouselView2.time = 2;
    [self.view addSubview:self.carouselView2];
}

#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
    //    NSLog(@"点击了第%ld张图片",(long)index);
}

- (void)startGif
{
    //    NSLog(@"-----");
    [_gifView startGif];
    

}

- (void)stopGif
{
    //    NSLog(@"*****");
    [_gifView stopGif];
    

}


//视频选择
-(void)turnTovc{
    // 初始化自己的视频选择器
    self.mediaPickerController = [[CRMediaPickerController alloc] init];
    // 设置视频选择器的代理为自己
    self.mediaPickerController.delegate = self;
    // 设置媒体类型为视频
    self.mediaPickerController.mediaType = CRMediaPickerControllerMediaTypeVideo;
    // 设置视频来源为本地库文件
    self.mediaPickerController.sourceType = CRMediaPickerControllerSourceTypePhotoLibrary;
    // 设置是否允许编辑
    self.mediaPickerController.allowsEditing = YES;
    // 设置视频质量
    self.mediaPickerController.videoQualityType = UIImagePickerControllerQualityTypeMedium;
    // 设置视频最大持续时间
    self.mediaPickerController.videoMaximumDuration = 60.0f;
    // 显示视频选择器
    [self.mediaPickerController show];
    
}

#pragma mark - CPDMediaPickerControllerDelegate
- (void)CRMediaPickerController:(CRMediaPickerController *)mediaPickerController didFinishPickingAsset:(ALAsset *)asset error:(NSError *)error
{
    // 如果没有错误
    if (!error) {
        // 如果有选择数据
        if (asset) {
            // 如果用户选择了照片数据
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
            }
            // 如果用户选择了视频数据
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                // 获取视频的url
                NSURL *contentURL = asset.defaultRepresentation.url;
                // 将数据转化为字符串
                // NSString *inputUrl = [contentURL ];
                [self CreatView:contentURL];
            }
        }
    }
}

-(void)CreatView:(NSURL *)url{
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
        [_moviePlayer play];
    //    [_moviePlayer.view setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 80)];
    
        [self.view addSubview:_moviePlayer.view];
        _moviePlayer.shouldAutoplay = YES;
        [_moviePlayer setControlStyle:MPMovieControlStyleNone];
        [_moviePlayer setFullscreen:YES];
    
        [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackStateChanged)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_moviePlayer];
    
}

-(void)playbackStateChanged{
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            //            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            //            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            //            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            //            NSLog(@"往后快转");
            break;
            
        default:
            //            NSLog(@"无法辨识的状态");
            break;
    }
}

-(void)exit{
    [_moviePlayer stop];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer.view removeFromSuperview];
}



@end
