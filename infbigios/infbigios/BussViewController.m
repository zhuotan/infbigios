//
//  BussViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/8/24.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "BussViewController.h"

@interface BussViewController ()
@property (strong, nonatomic)  UIView *bottomBorder;
@property (nonatomic) NSInteger radio;
@property (nonatomic) NSString *memstr;
@property (nonatomic) NSString *orgstr;
@end

UIColor *mywhite;

@implementation BussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _memstr = @"法定代表人：弓天云\n法定代表人职称：无\n企业负责人：郭主龙\n企业负责人职称：总经理\n技术负责人：卢冠楠\n技术负责人职称：总监";
    
    _orgstr =@"建设工程项目管理；工程勘察设计；承包与公司实力、规模、业绩相适应的国外工程项目，对外派遣实施上述境外工程所需的劳务人员；施工总承包；专业承包；开发、销售机械设备、计算机软件；设备租赁；项目投资；投资管理；资产管理；技术开发、技术咨询、技术服务、技术转让；经济信息咨询；公路管理、养护；货物进出口；代理进出口；技术进出口。";
    
    mywhite= [UIColor colorWithRed:87/255.0 green:210/255.0 blue:247/255.0 alpha:0.0];

    _bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.Range.frame.size.height - 4.0f, self.Range.frame.size.width+15, 1)];
    _bottomBorder.backgroundColor = [UIColor lightGrayColor];
    
    //UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.InfoView.frame.size.height)];
    //leftBorder.backgroundColor = [UIColor redColor];
    
    
    
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0,1,self.InfoView.frame.size.width,1)];
    topBorder.backgroundColor = [UIColor lightGrayColor];
    

    [self.InfoView addSubview:topBorder];
    
    [self.Member.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Member.layer setBorderWidth:1.0];
    [self.Member.layer setCornerRadius:3];
    self.Member.layer.masksToBounds = YES;
    [self.Member setTitle:@"成员" forState:UIControlStateNormal];
    self.Member.backgroundColor = [UIColor whiteColor];
    [self.Member addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.Member addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Range.layer setBorderColor :(__bridge CGColorRef _Nullable)(mywhite)];
    [self.Range.layer setBorderWidth:1.0];
    [self.Range.layer setCornerRadius:3];
    self.Range.layer.masksToBounds = YES;
    [self.Range setTitle:@"经营范围" forState:UIControlStateNormal];
    [self.Range addSubview:_bottomBorder];
    self.Range.backgroundColor = [UIColor whiteColor];
    [self.Range addTarget:self action:@selector(button2BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.Range addTarget:self action:@selector(button2BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.InfoView setText:_memstr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button1BackGroundNormal:(UIButton *)sender
{
    if(self.radio == 1){
        [sender.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }else{
        [sender.layer setBorderColor :(__bridge CGColorRef _Nullable)(mywhite)];
    }
}


- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    self.radio = 1;
    [self.InfoView setText:_memstr];
    [self.Range.layer setBorderColor :(__bridge CGColorRef _Nullable)(mywhite)];
    [sender.layer setBorderColor:[UIColor lightGrayColor].CGColor];

    [self.Range addSubview:_bottomBorder];
}

- (void)button2BackGroundNormal:(UIButton *)sender
{
    if(self.radio == 2){
        [sender.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }else{
       [sender.layer setBorderColor :(__bridge CGColorRef _Nullable)(mywhite)];
    }
}


- (void)button2BackGroundHighlighted:(UIButton *)sender
{
    self.radio = 2;
    [self.InfoView setText:_orgstr];
    [self.Member.layer setBorderColor :(__bridge CGColorRef _Nullable)(mywhite)];
    [sender.layer setBorderColor:[UIColor lightGrayColor].CGColor];

    [self.Member addSubview:_bottomBorder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
