//
//  serviceView.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SvGifView.h"

#import <MediaPlayer/MediaPlayer.h>

@interface serviceView : UIViewController{
    SvGifView * _gifView;
}

@property( nonatomic ,strong)NSMutableData * receiveData;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic ,strong)NSTimer *timer;
@end
