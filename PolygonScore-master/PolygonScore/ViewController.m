//
//  ViewController.m
//  PolygonScore
//
//  Created by 周俊杰 on 15/7/14.
//  Copyright (c) 2015年 北京金溪欣网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ScoreView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    NSArray *Infoarray = @[@{@"A":@(0.95)}, @{@"B":@(0.1)}, @{@"C":@(0.8)}, @{@"D":@(0.5)}, @{@"E":@(0.4)}, @{@"F":@(0.9)}, @{@"G":@(0.2)}, @{@"H":@(0.2)},];
    NSArray *textArray = @[@"助攻", @"三分", @"两分", @"罚球", @"前板", @"后板", @"盖帽", @"抢断"];
    
//    ScoreView *scoreView = [[ScoreView alloc] initWithInfoArray:Infoarray TextArray:textArray];
    
    ScoreView *scoreView = [[ScoreView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) InfoArray:Infoarray TextArray:textArray];
    
    [self.view addSubview:scoreView];
}



@end
