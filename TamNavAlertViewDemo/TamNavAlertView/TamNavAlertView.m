//
//  TamNavAlertView.m
//  TamNavAlertViewDemo
//
//  Created by xin chen on 2017/8/14.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamNavAlertView.h"

// 屏幕的宽和高
#define TamScreenWith [UIScreen mainScreen].bounds.size.width
#define TamScreenHeight [UIScreen mainScreen].bounds.size.height
//是否为IphoneX
#define TamIS_iPhoneX (TamScreenWith == 375 && TamScreenHeight == 812)
//导航栏总高
#define TamNavCountHeight (TamIS_iPhoneX ? (64+24) : 64)

@interface TamNavAlertView()

@property(nonatomic,strong)UILabel *alertLabel;
@property(nonatomic,copy)TouchEventBlock touchEvent;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int currentNum;

@end

@implementation TamNavAlertView

+(TamNavAlertView *)showMessage:(NSString *)message touchEventBlock:(TouchEventBlock)touchEventBlock
{
    TamNavAlertView *alertView = [self showMessage:message];
    if (touchEventBlock) {
        alertView.touchEvent = touchEventBlock;
    }
    return alertView;
}

+(TamNavAlertView *)showMessage:(NSString *)message
{
    //    [ApplicationShared setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    TamNavAlertView *alertView = [[TamNavAlertView alloc]init];
    alertView.alertLabel.text = message;
    alertView.backgroundColor = [UIColor colorWithRed:61/255.0 green:182/255.0 blue:251/255.0 alpha:1.0];
    alertView.frame = CGRectMake(0, -TamNavCountHeight, [UIScreen mainScreen].bounds.size.width, TamNavCountHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = alertView.frame;
        rect.origin.y = 0;
        alertView.frame = rect;
    }];

    [alertView.timer fire];
    return alertView;
}

+(void)dissmiss
{
    for (id sub in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([sub isMemberOfClass:[TamNavAlertView class]]) {
            TamNavAlertView *alertView = (TamNavAlertView *)sub;
            [alertView.timer invalidate];
            alertView.timer = nil;
            [UIView animateWithDuration:0.5 animations:^{
                CGRect rect = alertView.frame;
                rect.origin.y = -TamNavCountHeight;
                alertView.frame = rect;
            }completion:^(BOOL finished) {
                [alertView removeFromSuperview];
                //        BOOL isChangeBarStyle = YES;
                //        for (id sub in key_window.subviews) {
                //            if ([sub isMemberOfClass:[DDNavAlertView class]]) {
                //                isChangeBarStyle = NO;
                //                break;
                //            }
                //        }
                //        if (isChangeBarStyle) {
                //            [ApplicationShared setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                //        }
            }];
            break;
        }
    }
}

-(NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(void)timerChange
{
    self.currentNum++;
    if (self.currentNum >= 4) {
        [TamNavAlertView dissmiss];
        self.currentNum = 0;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    UILabel *alertLabel = [[UILabel alloc]init];
    alertLabel.numberOfLines = 2;
    self.alertLabel = alertLabel;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.frame = CGRectMake(10, TamIS_iPhoneX ? 24 : 20, TamScreenWith-10*2, TamIS_iPhoneX ? 64 : 44);
    [self addSubview:alertLabel];

    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesAction:)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeGes];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesAction:)];
    tapGes.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGes];
    
}

-(void)swipeGesAction:(UISwipeGestureRecognizer *)ges
{
    [TamNavAlertView dissmiss];
}

-(void)tapGesAction:(UITapGestureRecognizer *)ges
{
    [TamNavAlertView dissmiss];
    if (self.touchEvent) {
        self.touchEvent();
    }
}

@end
