//
//  CaptchaTimerManager.h
//  计时器
//
//  Created by 武利彬 on 17-1-14.
//  Copyright (c) 2017年 mosign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaptchaTimerManager : NSObject
@property (nonatomic,assign) __block int timeout;
+(id)sharedTimerManager;
-(void)countDown;
@end
