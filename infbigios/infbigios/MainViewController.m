//
//  MainViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/8/22.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "MainViewController.h"
#import "CFFlowButtonView.h"
#import "Masonry.h"

@interface MainViewController ()
@property (nonatomic, strong) NSMutableArray *buttonList1;
@property (nonatomic, strong) NSMutableArray *buttonList2;
@property (nonatomic, weak) CFFlowButtonView *ComSearchView;
@property (nonatomic, weak) CFFlowButtonView *ProSearchView;
@end

UIColor *myblue;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.GovButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[self.GovButton.layer setBorderWidth:1.0];
    myblue= [UIColor colorWithRed:87/255.0 green:210/255.0 blue:247/255.0 alpha:0.7];
    [self.GovButton.layer setCornerRadius:3];
    self.GovButton.layer.masksToBounds = YES;
    [self.GovButton setTitle:@"政府认证" forState:UIControlStateNormal];
    self.GovButton.backgroundColor =myblue;
    [self.GovButton addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.GovButton addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    

    [self.EnpButton.layer setCornerRadius:3];
    self.EnpButton.layer.masksToBounds = YES;
    [self.EnpButton setTitle:@"企业认证" forState:UIControlStateNormal];
    self.EnpButton.backgroundColor = [UIColor lightGrayColor];
    [self.EnpButton addTarget:self action:@selector(button2BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.EnpButton addTarget:self action:@selector(button2BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    //文字垂直居中
    self.ComSearch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ComSearch.backgroundColor = [UIColor colorWithRed:73.0f/255.0f green:148.0f/255.0f blue:230.0f/255.0f alpha:0.1];
    self.ComSearch.layer.cornerRadius = 3;
    self.ComSearch.font = [UIFont systemFontOfSize:14];
    self.ComSearch.placeholder = @"搜索公司名称";
    //搜索图标
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"search.png"];
    view.frame = CGRectMake(0, 0, 35, 35);
    //左边搜索图标的模式
    view.contentMode = UIViewContentModeCenter;
    self.ComSearch.leftView = view;
    //左边搜索图标总是显示
    self.ComSearch.leftViewMode = UITextFieldViewModeAlways;
    //右边删除所有图标
    self.ComSearch.clearButtonMode = UITextFieldViewModeAlways;
    
    
    //文字垂直居中
    self.ProSearch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ProSearch.backgroundColor = [UIColor colorWithRed:73.0f/255.0f green:148.0f/255.0f blue:230.0f/255.0f alpha:0.1];
    self.ProSearch.layer.cornerRadius = 3;
    self.ProSearch.font = [UIFont systemFontOfSize:14];
    self.ProSearch.placeholder = @"搜索项目名称";
    
    //搜索图标
    view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"search.png"];
    view.frame = CGRectMake(0, 0, 35, 35);
    //左边搜索图标的模式
    view.contentMode = UIViewContentModeCenter;
    self.ProSearch.leftView = view;
    //左边搜索图标总是显示
    self.ProSearch.leftViewMode = UITextFieldViewModeAlways;
    //右边删除所有图标
    self.ProSearch.clearButtonMode = UITextFieldViewModeAlways;

    [self addSearchView];
}


- (void)button1BackGroundNormal:(UIButton *)sender
{
    if(self.radio == 1){
         sender.backgroundColor = myblue;
    }else{
        sender.backgroundColor = [UIColor lightGrayColor];
    }
}


- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    self.radio = 1;
    sender.backgroundColor = myblue;
    self.EnpButton.backgroundColor = [UIColor lightGrayColor];
}

- (void)button2BackGroundNormal:(UIButton *)sender
{
    if(self.radio == 2){
        sender.backgroundColor = myblue;
    }else{
        sender.backgroundColor = [UIColor lightGrayColor];
    }
}


- (void)button2BackGroundHighlighted:(UIButton *)sender
{
    self.radio = 2;
    sender.backgroundColor = myblue;
    self.GovButton.backgroundColor = [UIColor lightGrayColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)buttonList1 {
    if (_buttonList1 == nil) {
        _buttonList1 = [NSMutableArray array];
        for (int i = 0; i < 18; i++) {
            UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
            [button setTitle:[NSString stringWithFormat:@"按钮%d", i] forState:UIControlStateNormal];
            // 模拟一些不同宽度和颜色，我很懒。。。就不写随机函数了
            if (i == 0 || i == 10) {
                button.width = 75;
                button.backgroundColor = [UIColor colorWithRed:102/255.0 green:180/255.0 blue:180/255.0 alpha:1];
            }
            if (i == 15 || i == 9 || i == 6) {
                button.width = 100;
                button.backgroundColor = [UIColor colorWithRed:255/255.0 green:196/255.0 blue:102/255.0 alpha:1];
            }
            [_buttonList1 addObject:button];
        }
    }
    return _buttonList1;
}

- (NSMutableArray *)buttonList2 {
    if (_buttonList2 == nil) {
        _buttonList2 = [NSMutableArray array];
        for (int i = 0; i < 18; i++) {
            UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
            [button setTitle:[NSString stringWithFormat:@"按钮%d", i] forState:UIControlStateNormal];
            // 模拟一些不同宽度和颜色，我很懒。。。就不写随机函数了
            if (i == 1 || i == 11) {
                button.width = 100;
                button.backgroundColor = [UIColor colorWithRed:102/255.0 green:80/255.0 blue:180/255.0 alpha:1];
            }
            if (i == 15 || i == 9 || i == 6) {
                button.width = 75;
                button.backgroundColor = [UIColor colorWithRed:255/55.0 green:196/255.0 blue:102/255.0 alpha:1];
            }
            [_buttonList2 addObject:button];
        }
    }
    return _buttonList2;
}

- (void)addSearchView {
    
    CFFlowButtonView *SearchView1 = [[CFFlowButtonView alloc] initWithButtonList:self.buttonList1];
    [self.view addSubview:SearchView1];
    self.ComSearchView = SearchView1;
    
    // 设置约束，不需要设置高度相关的约束
    [self.ComSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ComSearch.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    CFFlowButtonView *SearchView2= [[CFFlowButtonView alloc] initWithButtonList:self.buttonList2];
    [self.view addSubview:SearchView2];
    self.ProSearchView = SearchView2;
    
    // 设置约束，不需要设置高度相关的约束
    [self.ProSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ProSearch.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    //self.flowButtonView.backgroundColor = [UIColor lightGrayColor];
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
