//
//  ViewController.m
//  03-AvPlayer
//
//  Created by qingyun on 15/12/30.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define KsongUrl @"http://down.5nd.com/a/down.ashx?t=1&xcode=e9067b9ac78488f8ab104e5c0328c470&sid=578379"

@interface ViewController ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:KsongUrl];
    
    _player = [[AVPlayer alloc] initWithURL:url];
    
}
- (IBAction)touchPlayer:(UIButton *)sender {
    [_player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
