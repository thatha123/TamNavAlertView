//
//  ViewController.m
//  TamNavAlertViewDemo
//
//  Created by xin chen on 2017/8/14.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamNavAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)dissmissAction:(UIButton *)sender {
    [TamNavAlertView dissmiss];
}

- (IBAction)showAction:(UIButton *)sender {
    [TamNavAlertView showMessage:[NSString stringWithFormat:@"楼主最帅了！无人能及%d",arc4random_uniform(100)] touchEventBlock:^{
        NSLog(@"点击了我");
    }];
}



@end
