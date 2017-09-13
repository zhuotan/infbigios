//
//  MainViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/8/22.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "MainViewController.h"
#import "CFFlowButtonView.h"
#import "TopoViewController.h"
#import "Masonry.h"

@interface MainViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSString *PageUrl;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *list1;
@property (nonatomic, strong) NSMutableArray *list2;
@property (nonatomic, weak) CFFlowButtonView *ComSearchView;
@property (nonatomic, weak) CFFlowButtonView *ProSearchView;
@property (nonatomic) NSInteger type;
@end

UIColor *myblue;
NSLock *theLock;
NSInteger inde=0;
//221.237.189.104
NSString  *URLString = @"http://221.237.189.104:8080/titanweb/SolrTitanAction?method=nameSearch&name=";
NSString  *URLString2 = @"http://221.237.189.104:8080/titanweb/SolrTitanAction?method=projectSearch&name=";
NSString  *DisCompanyURL =@"http://221.237.189.104:8080/titanweb/SolrTitanAction?method=name&company=";
NSString  *DisProjectURL =@"http://221.237.189.104:8080/titanweb/SolrTitanAction?method=load&project=";

CGRect rect;
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.GovButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[self.GovButton.layer setBorderWidth:1.0];
    rect = [[UIScreen mainScreen] bounds];
    
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
    
    self.ComSearch.delegate = self;
    self.ProSearch.delegate = self;
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
    
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat screen_width = size.width;
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screen_width, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"搜索"forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    
    [_ComSearch setInputAccessoryView:topView];
    [_ProSearch setInputAccessoryView:topView];
    
    _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
}

- (IBAction)GovAction:(id)sender {
    inde = 0;
    _type = 1;
    [self dismissKeyBoard1];
}

- (IBAction)EnpAction:(id)sender {
    inde = 1;
    _type = 1;
    [self dismissKeyBoard1];
}

-  (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
        
    }
    
    return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.ComSearch]){
        _type = 1;
    }else if([textField isEqual:self.ProSearch]){
        _type = 2;
    }
}

- (BOOL)   textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
   replacementString:(NSString *)string{
    return YES;
}

-(UIColor*)randomColor
{
    CGFloat hue = (arc4random() %256/256.0);
    
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5];
    return color;
}
-(void)dismissKeyBoard1
{
    [_ComSearch resignFirstResponder];
    [_ProSearch resignFirstResponder];
    // 获取数据
    
    NSString *word = nil;
    
    word = _ComSearch.text;
    
    if(![self isBlankString:word]){
        _PageUrl = [URLString stringByAppendingString:word];
        _PageUrl = [_PageUrl stringByAppendingString:@"&index="];
        NSString *stringInt = nil;
        if(inde == 0){
            stringInt = @"0";
        }else{
            stringInt = @"1";
        }
        
        _PageUrl = [_PageUrl stringByAppendingString:stringInt];
        
        NSString *encodedURL = [_PageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self alert];
                return;
            } else {
                //NSLog(@"%@ %@", response, data);
                //[myObject isKindOfClass:[NSString class]]
                if(![data isKindOfClass:[NSArray class]]){
                    [self alert];
                    return;
                }
                if (_list1 == nil) {
                    _list1 = [NSMutableArray array];
                }else{
                    [_list1 removeAllObjects];
                }
                NSArray *views = [self.ComSearchView subviews];
                for(UIView *view in views){
                    if([view isKindOfClass:UIButton.class]){
                        [view removeFromSuperview];
                    }
                }
                NSArray *array = data;
                if([array count] == 0){
                    [self alert];
                    return;
                }
                for(NSString* item in array) {
                    UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
                    
                    button.mas_key = @"1";
                    
                    button.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Light" size:12];
                    [button addTarget:self action:@selector(TouchDownInside:) forControlEvents:UIControlEventTouchDown];
                    CGSize titleSize = [item sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:button.titleLabel.font.fontName size:button.titleLabel.font.pointSize]}];
                    button.width = titleSize.width + 10;
                    
                    if(button.width > rect.size.width){
                        button.width = rect.size.width - 30;
                    }
                    
                    button.backgroundColor = [self randomColor];
                    [button setTitle:item forState:UIControlStateNormal];
                    
                    [_list1 addObject:button];

                }
                [self addSearchView];
                _type = 2;
                [self dismissKeyBoard2];
            }
        }];
        [_dataTask resume];
    }else{
        NSArray *views = [self.ComSearchView subviews];
        for(UIView *view in views){
            if([view isKindOfClass:UIButton.class]){
                [view removeFromSuperview];
            }
        }
        _type = 2;
        [self dismissKeyBoard2];
    }
    
}

-(void)dismissKeyBoard2
{
    
    NSString *word = nil;
    
    word = _ProSearch.text;
    
    if(![self isBlankString:word]){
        
        _PageUrl = [URLString2 stringByAppendingString:word];
        
        _PageUrl = [_PageUrl stringByAppendingString:@"&index="];
        NSString *stringInt = nil;
        if(inde == 0){
            stringInt = @"0";
        }else{
            stringInt = @"1";
        }
        
        _PageUrl = [_PageUrl stringByAppendingString:stringInt];
        
        NSString *encodedURL = [_PageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self alert];
                return;
            } else {
                //NSLog(@"%@ %@", response, data);
                //[myObject isKindOfClass:[NSString class]]
                if(![data isKindOfClass:[NSArray class]]){
                    [self alert];
                    return;
                }
                if (_list2 == nil) {
                    _list2 = [NSMutableArray array];
                }else{
                    [_list2 removeAllObjects];
                }
                NSArray *views = [self.ProSearchView subviews];
                for(UIView *view in views){
                    if([view isKindOfClass:UIButton.class]){
                        [view removeFromSuperview];
                    }
                }
                
                NSArray *array = data;
                if([array count] == 0){
                    [self alert];
                    return;
                }
                for(NSString* item in array) {
                    UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
                    
                    button.mas_key = @"2";
                    
                    button.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Light" size:12];
                    [button addTarget:self action:@selector(TouchDownInside:) forControlEvents:UIControlEventTouchDown];
                    CGSize titleSize = [item sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:button.titleLabel.font.fontName size:button.titleLabel.font.pointSize]}];
                    button.width = titleSize.width + 10;
                    
                    if(button.width > rect.size.width){
                        button.width = rect.size.width - 30;
                    }
                    
                    button.backgroundColor = [self randomColor];
                    [button setTitle:item forState:UIControlStateNormal];
                    
                    [_list2 addObject:button];
                    
                }
                [self addSearchView];
            }
        }];
        [_dataTask resume];
    }else{
        NSArray *views = [self.ProSearchView subviews];
        for(UIView *view in views){
            if([view isKindOfClass:UIButton.class]){
                [view removeFromSuperview];
            }
        }
        return;
    }
    
}

-(void)dismissKeyBoard
{
    [_ComSearch resignFirstResponder];
    [_ProSearch resignFirstResponder];
    // 获取数据
    
    NSString *word = nil;
    if (_type == 1){
        word = _ComSearch.text;
    }else{
        word = _ProSearch.text;
    }
    if(![self isBlankString:word]){
        if(_type == 1){
            _PageUrl = [URLString stringByAppendingString:word];
        }else{
            _PageUrl = [URLString2 stringByAppendingString:word];
        }
        _PageUrl = [_PageUrl stringByAppendingString:@"&index="];
        NSString *stringInt = nil;
        if(inde == 0){
            stringInt = @"0";
        }else{
            stringInt = @"1";
        }
        
        _PageUrl = [_PageUrl stringByAppendingString:stringInt];
        
        NSString *encodedURL = [_PageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self alert];
                return;
            } else {
                //NSLog(@"%@ %@", response, data);
                //[myObject isKindOfClass:[NSString class]]
                if(![data isKindOfClass:[NSArray class]]){
                    [self alert];
                    return;
                }
                if(_type == 1){
                    if (_list1 == nil) {
                        _list1 = [NSMutableArray array];
                    }else{
                        [_list1 removeAllObjects];
                    }
                    NSArray *views = [self.ComSearchView subviews];
                    for(UIView *view in views){
                        if([view isKindOfClass:UIButton.class]){
                            [view removeFromSuperview];
                        }
                    }
                    
                }else{
                    if (_list2 == nil) {
                        _list2 = [NSMutableArray array];
                    }else{
                        [_list2 removeAllObjects];
                    }
                    NSArray *views = [self.ProSearchView subviews];
                    for(UIView *view in views){
                        if([view isKindOfClass:UIButton.class]){
                            [view removeFromSuperview];
                        }
                    }
                }
                NSArray *array = data;
                if([array count] == 0){
                    [self alert];
                    return;
                }
                for(NSString* item in array) {
                    UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
                    if(_type == 1){
                        button.mas_key = @"1";
                    }else{
                        button.mas_key = @"2";
                    }
                    button.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Light" size:12];
                    [button addTarget:self action:@selector(TouchDownInside:) forControlEvents:UIControlEventTouchDown];
                    CGSize titleSize = [item sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:button.titleLabel.font.fontName size:button.titleLabel.font.pointSize]}];
                    button.width = titleSize.width + 10;
                    
                    if(button.width > rect.size.width){
                        button.width = rect.size.width - 30;
                    }
                    
                    button.backgroundColor = [self randomColor];
                    [button setTitle:item forState:UIControlStateNormal];
                    if(_type == 1){
                        [_list1 addObject:button];
                    }else{
                        [_list2 addObject:button];
                    }
                }
                [self addSearchView];
            }
        }];
        [_dataTask resume];
    }else{
        [_ComSearch resignFirstResponder];
        [_ProSearch resignFirstResponder];
        return;
    }
}

-(void)alert{
    
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有查询到相关的数据" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

-(void)TouchDownInside:(id)sender{
    UIButton* btn = (UIButton*)sender;
    //NSLog(@"title is %@",btn.titleLabel.text);
    NSString *type = (NSString*)btn.mas_key;
    if([type isEqualToString: @"1"]){
        _PageUrl = [DisCompanyURL stringByAppendingString: btn.titleLabel.text];
    }else{
        _PageUrl = [DisProjectURL stringByAppendingString: btn.titleLabel.text];
    }
    _PageUrl = [_PageUrl stringByAppendingString:@"&index="];
    
    NSString *stringInt = nil;
    if(inde == 0){
        stringInt = @"0";
    }else{
        stringInt = @"1";
    }
    
    _PageUrl = [_PageUrl stringByAppendingString:stringInt];
    
    NSString *encodedURL = [_PageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    TopoViewController *topo = [self.storyboard instantiateViewControllerWithIdentifier:@"TopoView"];
    topo.weburl = encodedURL;
    [self.navigationController pushViewController:topo animated:YES];
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

- (void)addSearchView {
    
    if(_type == 1){
        CFFlowButtonView *SearchView1 = [[CFFlowButtonView alloc] initWithButtonList:self.list1];
        [self.view addSubview:SearchView1];
        self.ComSearchView = SearchView1;
        
        // 设置约束，不需要设置高度相关的约束
        [self.ComSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ComSearch.mas_bottom).offset(0);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
        }];
    }else{
        CFFlowButtonView *SearchView2= [[CFFlowButtonView alloc] initWithButtonList:self.list2];
        [self.view addSubview:SearchView2];
        self.ProSearchView = SearchView2;
        
        // 设置约束，不需要设置高度相关的约束
        [self.ProSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ProSearch.mas_bottom).offset(0);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
        }];
    }
}

@end
