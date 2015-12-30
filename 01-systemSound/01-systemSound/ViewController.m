//
//  ViewController.m
//  01-systemSound
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()
//添加属性(系统声音ID对象的URL)
@property (nonatomic) CFURLRef soundFileURLRef;
//添加属性(系统声音ID对象)
@property (nonatomic) SystemSoundID soundFileObject;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

void soundFished(SystemSoundID snd,void *content){
    //移除snd对象
    AudioServicesRemoveSystemSoundCompletion(snd);
    //销毁soundID对象
    AudioServicesDisposeSystemSoundID(snd);
    
}
//配置播放声音的对象
-(void)setSystemSoundID{
    //获取音频的路径
    NSURL *songUrl = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"caf"];
    
    //创建soundID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(songUrl), &_soundFileObject);
    
    //注册监听，监听播放完毕调用
    AudioServicesAddSystemSoundCompletion(_soundFileObject, NULL, NULL, soundFished, NULL);
    
}
//播放声音
- (IBAction)playSound:(id)sender {
    [self setSystemSoundID];
    
    //播放一个声音
    AudioServicesPlaySystemSound(_soundFileObject);
}
- (IBAction)playAlertSound:(id)sender {
    [self setSystemSoundID];
    
    AudioServicesPlayAlertSound(_soundFileObject);
}
- (IBAction)playVibrate:(id)sender {
    [self setSystemSoundID];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
