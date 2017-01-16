//
//  VCSendMessage.m
//  计时器
//
//  Created by 武利彬 on 17-1-14.
//  Copyright (c) 2017年 mosign. All rights reserved.
//

#import "VCSendMessage.h"
#import "CaptchaTimerManager.h"
@interface VCSendMessage ()
@property(nonatomic,assign)__block int timeout;
@end

@implementation VCSendMessage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnGetCode setBackgroundColor:[UIColor redColor]];
    [btnGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGRect rect = CGRectMake(20, 20, 100, 30);
    [btnGetCode setFrame:rect];
    self.btn = btnGetCode;
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
    //返回上个页面按钮
    
    UIButton *btnGoBack =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnGoBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnGoBack setBackgroundColor:[UIColor redColor]];
    [btnGoBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnGoBack setFrame:CGRectMake(20, 70, 100, 30)];
    [self.view addSubview:btnGoBack];
    [btnGoBack addTarget:self action:@selector(backFrontView:) forControlEvents:UIControlEventTouchUpInside];
    

    // Do any additional setup after loading the view.
}

-(void) backFrontView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
    int temp = manager.timeout;
    if (temp > 0) {
        _timeout = temp; //倒计时时间
        [self timerCountDown];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.timeout > 0) {
        CaptchaTimerManager *manager = [CaptchaTimerManager sharedTimerManager];
        
        if (manager.timeout == 0) {
            manager.timeout = _timeout;
            [manager countDown];
        }
        _timeout = 0;//置为0，释放Controller
    }
}

-(void)startTimer:(id)sender{
    _timeout = 60;//倒计时时间
    
    [self timerCountDown];
}

//控制器里的倒计时
-(void)timerCountDown{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.btn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                self.btn.userInteractionEnabled = YES;

                            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                                NSString *strtime = [NSString stringWithFormat:@"%.2d",_timeout];
                [self.btn setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strtime ] forState:UIControlStateNormal];
                self.btn.userInteractionEnabled = NO;
                NSLog(@"%@",strtime);
                NSLog(@"%@",self.btn.titleLabel);
            });
            
            _timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}











/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
