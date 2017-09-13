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
    
    
    _memstr = @"";
    
    _orgstr =@"";
    
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
    
    [self.CompLable setText:self.company];
    
    NSString *zcarea = [self.dictionary objectForKey:@"zcarea"];
    NSString *zccity = [self.dictionary objectForKey:@"zccity"];
    NSString *regplace = nil;
    if([zcarea isEqualToString:@"北京"]||[zcarea isEqualToString:@"上海"]||[zcarea isEqualToString:@"重庆"]||[zcarea isEqualToString:@"天津"]){
        regplace = zccity;
    }else{
        regplace = [zcarea stringByAppendingString:@"/"];
        regplace = [regplace stringByAppendingString:zccity];
    }
    
    NSString *OrganCodeL = @"机构代码：";
    NSString *RegPlaceL = @"注册省市：";
    NSString *UsedNameL = @"曾用名：";
    NSString *AdmiDepartL = @"行政主管部门：";
    NSString *BuslicenL = @"营业执照注册号：";
    NSString *EnterTypeL = @"企业类型：";
    NSString *EnterNatureL = @"企业性质：";
    NSString *LicenPeriodL = @"营业执照日期：";
    NSString *CreditCodeL = @"社会信誉代码：";
    
    
    
    NSString *fddbr = [self.dictionary objectForKey:@"fddbr"];
    if(fddbr == nil){
        fddbr = @"";
    }
    
    NSString *fddbrzc = [self.dictionary objectForKey:@"fddbrzc"];
    if(fddbrzc == nil){
        fddbrzc= @"";
    }
    
    NSString *qyfzr = [self.dictionary objectForKey:@"qyfzr"];
    if(qyfzr == nil){
        qyfzr = @"";
    }
    
    NSString *qyfzrc = [self.dictionary objectForKey:@"qyfzrc"];
    if(qyfzrc == nil){
        qyfzrc = @"";
    }
    
    NSString *jsfzr = [self.dictionary objectForKey:@"jsfzr"];
    if(jsfzr == nil){
        jsfzr = @"";
    }
    
    NSString *jsfzrzz = [self.dictionary objectForKey:@"jsfzrzz"];
    if(jsfzrzz == nil){
        jsfzrzz =@"";
    }

    _memstr = [_memstr stringByAppendingString:@"法定代表人："];
    _memstr = [_memstr stringByAppendingString:fddbr];
    _memstr = [_memstr stringByAppendingString:@"\n"];
    _memstr = [_memstr stringByAppendingString:@"法定代表人职称："];
    _memstr = [_memstr stringByAppendingString:fddbrzc];
    _memstr = [_memstr stringByAppendingString:@"\n"];
    _memstr = [_memstr stringByAppendingString:@"企业负责人："];
    _memstr = [_memstr stringByAppendingString:qyfzr];
    _memstr = [_memstr stringByAppendingString:@"\n"];
    _memstr = [_memstr stringByAppendingString:@"企业负责人职称："];
    _memstr = [_memstr stringByAppendingString:qyfzrc];
    _memstr = [_memstr stringByAppendingString:@"\n"];
    _memstr = [_memstr stringByAppendingString:@"技术负责人"];
    _memstr = [_memstr stringByAppendingString:jsfzr];
    _memstr = [_memstr stringByAppendingString:@"\n"];
    _memstr = [_memstr stringByAppendingString:@"技术负责人职称："];
    _memstr = [_memstr stringByAppendingString:jsfzrzz];
    
    OrganCodeL = [OrganCodeL stringByAppendingString:[self.dictionary objectForKey:@"jgdm"]];
    RegPlaceL = [RegPlaceL stringByAppendingString:regplace];
    UsedNameL = [UsedNameL stringByAppendingString:[self.dictionary objectForKey:@"oldname"]];
    AdmiDepartL = [AdmiDepartL stringByAppendingString:[self.dictionary objectForKey:@"xzzgbm"]];
    BuslicenL = [BuslicenL stringByAppendingString:[self.dictionary objectForKey:@"yyzz"]];
    EnterTypeL = [EnterTypeL stringByAppendingString:[self.dictionary objectForKey:@"qylx"]];
    EnterNatureL = [EnterNatureL stringByAppendingString:[self.dictionary objectForKey:@"qyxz"]];
    LicenPeriodL = [LicenPeriodL stringByAppendingString:[self.dictionary objectForKey:@"yyzzrq"]];
    CreditCodeL = [CreditCodeL stringByAppendingString:[self.dictionary objectForKey:@"shxydm"]];
    
    [self.OrganCode setText:OrganCodeL];
    [self.RedPlace setText:RegPlaceL];
    [self.UsedName setText:UsedNameL];
    [self.AdmiDepart setText:AdmiDepartL];
    [self.Buslicen setText:BuslicenL];
    [self.EnterType setText:EnterTypeL];
    [self.EnterNature setText:EnterNatureL];
    [self.LicenPeriod setText:LicenPeriodL];
    [self.CreditCode setText:CreditCodeL];
    
    self.orgstr = [self.dictionary objectForKey:@"yyfw"];
    
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

- (IBAction)CloseAction:(id)sender {
    UIViewController *root = self.presentingViewController;
    while (root.presentingViewController) {
        root = root.presentingViewController;
    }
    [root dismissViewControllerAnimated:YES completion:NULL];
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
