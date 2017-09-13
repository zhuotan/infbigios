//
//  TopoViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/8/29.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "TopoViewController.h"
#import "WebViewJavascriptBridge.h"
#import "BussViewController.h"
#import "QualificationViewController.h"
#import "FilingViewController.h"

@interface TopoViewController () <UIWebViewDelegate>

@property WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end
NSString *BaseInfoURL = @"http://221.237.189.104:8080/titanweb/SearchAction?method=baseInfo&company=";
NSString *QuliInfoURL = @"http://221.237.189.104:8080/titanweb/SearchAction?method=zizhiInfo&company=";
NSString *FilingInfoURL = @"http://221.237.189.104:8080/titanweb/SearchAction?method=evalInfo&company=";


@implementation TopoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    //CGRect rectNav = self.navigationController.navigationBar.frame;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    [self.bridge registerHandler:@"getCompanyBaseInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getCompanyBaseInfo, data from js is %@", data);
        NSDictionary* dic = (NSDictionary*)data;
        NSString *company = [dic objectForKey:@"companyname"];
        NSString *BaseInfoURLs = [BaseInfoURL stringByAppendingString:company];
        
        NSString *encodedURL = [BaseInfoURLs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                //NSLog(@"%@ %@", response, data);
                NSDictionary* dic = (NSDictionary*)data;
                NSLog(@"%@",dic);
                BussViewController *buss = [self.storyboard instantiateViewControllerWithIdentifier:@"BussView"];
                buss.company = company;
                buss.dictionary = dic;
                //[self.navigationController pushViewController:buss animated:YES];
                [ self presentViewController:buss animated: YES completion:nil];
            }
        }];
        [_dataTask resume];

        if (responseCallback) {
            // 反馈给JS
            responseCallback(@{@"status": @"OK"});
        }
    }];
    
    [self.bridge registerHandler:@"getCompanyQualInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getCompanyQualInfo, data from js is %@", data);
        NSDictionary* dic = (NSDictionary*)data;
        NSString *company = [dic objectForKey:@"companyname"];
        NSString *QuliInfoURLs = [QuliInfoURL stringByAppendingString:company];
        
        NSString *encodedURL = [QuliInfoURLs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSMutableArray *qlist = (NSMutableArray*)data;
                QualificationViewController *Quali = [self.storyboard instantiateViewControllerWithIdentifier:@"QualiView"];
                Quali.qlist = qlist;
                [self presentViewController:Quali animated: YES completion:nil];
            }
        }];
        [_dataTask resume];
        
        if (responseCallback) {
            // 反馈给JS
            responseCallback(@{@"status": @"OK"});
        }
    }];
    [self.bridge registerHandler:@"getCompanyFilingInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getCompanyFilingInfo, data from js is %@", data);
        NSDictionary* dic = (NSDictionary*)data;
        NSString *company = [dic objectForKey:@"companyname"];
        NSString *FilingInfoURLs = [FilingInfoURL stringByAppendingString:company];
        
        NSString *encodedURL = [FilingInfoURLs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL= [NSURL URLWithString: encodedURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSMutableArray *qlist = (NSMutableArray*)data;
                FilingViewController *Filing = [self.storyboard instantiateViewControllerWithIdentifier:@"FilingView"];
                Filing.flist = qlist;
                [self presentViewController:Filing animated: YES completion:nil];
            }
        }];
        [_dataTask resume];
        
        if (responseCallback) {
            // 反馈给JS
            responseCallback(@{@"status": @"OK"});
        }
    }];
    _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_configuration];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
