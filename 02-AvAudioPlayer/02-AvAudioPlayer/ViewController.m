//
//  ViewController.m
//  02-AvAudioPlayer
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *voicePregress;
@property (weak, nonatomic) IBOutlet UISlider *playSilder;

@property (nonatomic, strong) AVAudioPlayer *player;
//计时器，刷新播放进度
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadDataForView];
}

-(AVAudioPlayer *)player
{
    if (_player) {
        return _player;
    }
    NSURL *songUrl = [[NSBundle mainBundle] URLForResource:@"张杰 - 时光十年" withExtension:@"mp3"];
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:&error];
    
    //设置参数可用
    //设置速率
    _player.enableRate = YES;
    
    //设置循环播放 -1表示无限循环  2表示循环两次
    _player.numberOfLoops = 1;
    
    _player.delegate = self;
    //调用硬件
    [_player prepareToPlay];
    
    return _player;
    
}

-(NSTimer *)timer
{
    if (_timer) {
        return _timer;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:.3f target:self selector:@selector(UPdateSlider) userInfo:nil repeats:YES];
    return _timer;
}
//更新当前进度
-(void)UPdateSlider{
    _playSilder.value = self.player.currentTime;
}

-(void)loadDataForView{
    //音量初始值
    _voicePregress.maximumValue = 1.0;
    _voicePregress.value = self.player.volume;
    
    //播放进度
    _playSilder.maximumValue = self.player.duration;
    _playSilder.minimumValue = 0;
    _playSilder.value = self.player.currentTime;
}

//设置声音
- (IBAction)changeValueSilder:(UISlider *)sender {
    self.player.volume = sender.value;
}
//设置播放位置
- (IBAction)playValueChange:(UISlider *)sender {
    self.player.currentTime = sender.value;
}
- (IBAction)playOrPause:(UIButton *)sender {
    if (self.player.isPlaying) {
        //暂停
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
        
        self.timer.fireDate = [NSDate distantFuture];
    }else{
        //播放
        [sender setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
        [self.player play];
        
        self.timer.fireDate = [NSDate distantPast];
    }
}
- (IBAction)rateAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.player.rate = 0.5;
            break;
        case 2:
            self.player.rate = 2;
            break;
        case 3:
            self.player.rate = 1;
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
