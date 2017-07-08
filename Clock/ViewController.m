//
//  ViewController.m
//  Clock
//
//  Created by guangying_tang on 2017/7/7.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (strong, nonatomic) UIImageView *faceLayer;
@property (strong, nonatomic) UIImageView *hourHandLayer;
@property (strong, nonatomic) UIImageView *minuteHandLayer;
@property (strong, nonatomic) UIImageView *secondHandLayer;

@property (strong, nonatomic) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self createAndAddSubLayers];
    
}

- (void)createAndAddSubLayers
{
    _faceLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ClockFace"]];
    _hourHandLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HourHand"]];
    _minuteHandLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MinuteHand"]];
    _secondHandLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SecondHand"]];
    
    _faceLayer.frame = CGRectMake(100, 100, 300, 300);
    _faceLayer.center = self.view.center;
    _hourHandLayer.layer.position = _faceLayer.center;
    _minuteHandLayer.layer.position = _faceLayer.center;
    _secondHandLayer.layer.position = _faceLayer.center;

    
    [self.view addSubview:_faceLayer];

    [self.view addSubview:_hourHandLayer];
    [self.view addSubview:_minuteHandLayer];
    [self.view addSubview:_secondHandLayer];
    
    _hourHandLayer.contentMode = UIViewContentModeScaleAspectFit;
    _minuteHandLayer.contentMode = UIViewContentModeScaleAspectFit;
    _secondHandLayer.contentMode = UIViewContentModeScaleAspectFit;
    
    _hourHandLayer.layer.anchorPoint = CGPointMake(.5, 0.9);
    _minuteHandLayer.layer.anchorPoint = CGPointMake(.5, 0.9);
    _secondHandLayer.layer.anchorPoint = CGPointMake(.5, 0.9);
    
    [self transformImageViewsByTime];
    
}

- (void)tick
{
    
    [self transformImageViewsByTime];

}

- (void)transformImageViewsByTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [calendar components:units fromDate:[NSDate date]];
    NSInteger hour = dateComponents.hour;
    NSInteger minute = dateComponents.minute;
    NSInteger second = dateComponents.second;
    
    
    CGFloat hourAngle = hour / 12.0 * 2 * M_PI;
    CGFloat minuteAngle = minute / 60.0 * 2 * M_PI;
    CGFloat secondAngle = second / 60.0 * 2 * M_PI;
    
    _hourHandLayer.transform = CGAffineTransformMakeRotation(hourAngle);
    _minuteHandLayer.transform = CGAffineTransformMakeRotation(minuteAngle);
    _secondHandLayer.transform = CGAffineTransformMakeRotation(secondAngle);
}

-(void)dealloc
{
    [_timer invalidate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_timer fire];
}

- (NSString *)systemDateWithDate:(NSDate *)date
{
    NSDateFormatter *df = [NSDateFormatter new];
    df.timeZone = [NSTimeZone systemTimeZone];
    df.dateFormat = @"yyy-MM-dd HH:mm:ss Z";
    return [df stringFromDate:date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
