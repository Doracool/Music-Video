//
//  ViewController.m
//  04-RecorderDemo
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
@interface ViewController ()<AVAudioRecorderDelegate>
//录音对象
@property (nonatomic, strong) AVAudioRecorder *recorder;
//播放器对象
@property (nonatomic, strong) AVAudioPlayer *player;
//文件路径
@property (nonatomic, strong) NSURL *Kurl;

@end

@implementation ViewController

-(NSURL *)Kurl
{
    if (_Kurl) {
        return _Kurl;
    }
    NSString *url = [@"/Users/qingyun/Desktop/" stringByAppendingPathComponent:@"recorder.caf"];
    //文件转换路径
    _Kurl = [NSURL URLWithString:url];
    
    return _Kurl;
}

//设置音频录音格式
-(NSDictionary *)setAudioSettings{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //设置编码格式
    [dic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    
    //采样率
    [dic setObject:@(8000) forKey:AVSampleRateKey];
    
    //设置声道数
    [dic setObject:@(2) forKey:AVNumberOfChannelsKey];
    //设置量化位置
    [dic setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //编码是否可以用浮点数
    [dic setObject:@YES forKey:AVLinearPCMIsFloatKey];
    
    //设置编码质量
    [dic setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    
    return dic;
}

-(AVAudioRecorder *)recorder
{
    if (_recorder) {
        return _recorder;
    }
    //生成录音对象
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.Kurl settings:[self setAudioSettings] error:&error];
    
    //设置委托
    _recorder.delegate = self;
    
    //开始录音
    [_recorder prepareToRecord];
    
    return _recorder;
}

-(AVAudioPlayer *)player
{
    if (_player) {
        return _player;
    }
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.Kurl error:nil];
    
    //准备开始播放
    [_player prepareToPlay];
    return _player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//开始录制
- (IBAction)recorderAction:(UIButton *)sender {
    if ([self.recorder isRecording]) {
        [sender setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateNormal];
        
        [self.recorder pause];
    }else{
        [sender setImage:[UIImage imageNamed:@"luyinzhong"] forState:UIControlStateNormal];
        [self.recorder record];
    }
}
//结束录制
- (IBAction)stopRecorder:(UIButton *)sender {
    [self.recorder stop];
}
//播放
- (IBAction)playAction:(UIButton *)sender {
    if ([self.player isPlaying]) {
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
    }else{
        [sender setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
        [self.player play];
    }
}
//结束播放
- (IBAction)stopPlayAction:(UIButton *)sender {
    [self.player stop];
}


-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"完成录制");
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"编码失败");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
