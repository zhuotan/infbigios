//
//  ViewController.m
//  CFFlowButtonView
//
//  Created by 周凌宇 on 15/10/27.
//  Copyright © 2015年 周凌宇. All rights reserved.
//

#import "ViewController.h"
#import "CFFlowButtonView.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, weak) CFFlowButtonView *flowButtonView;
@property (nonatomic, strong) NSMutableArray *buttonList;
@end

@implementation ViewController




#pragma mark - =======================viewDidLoad=======================
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton  *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(110.0f,200.0f,100.0f,44.0f);
    [myButton setTitle:@"Normal"  forState:UIControlStateNormal];
    [myButton setTitle:@"Pressed" forState:UIControlStateHighlighted];
    [self.MyScrollView addSubview:myButton];
}



@end
