//
//  TamNavAlertView.h
//  TamNavAlertViewDemo
//
//  Created by xin chen on 2017/8/14.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchEventBlock)();

@interface TamNavAlertView : UIView

+(TamNavAlertView *)showMessage:(NSString *)message;
+(TamNavAlertView *)showMessage:(NSString *)message touchEventBlock:(TouchEventBlock)touchEventBlock;
+(void)dissmiss;

@end
