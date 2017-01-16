//
//  DosViewController.m
//  计时器
//
//  Created by 武利彬 on 17-1-14.
//  Copyright (c) 2017年 mosign. All rights reserved.
//

#import "DosViewController.h"
#import "VCSendMessage.h"

@interface DosViewController ()

@end

@implementation DosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGRect rect = CGRectMake(20, 20, 100, 30);
    [btn setFrame:rect];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCode:(id *)sender{
    VCSendMessage *vcSendMessage = [[VCSendMessage alloc]init];
    [self presentViewController:vcSendMessage animated:YES completion:nil];
}

@end
