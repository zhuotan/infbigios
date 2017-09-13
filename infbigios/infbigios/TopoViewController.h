//
//  TopoViewController.h
//  infbigios
//
//  Created by 谭卓 on 2017/8/29.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface TopoViewController : UIViewController
@property (strong,nonatomic) NSString *weburl;
@property (nonatomic,strong) UIWebView *webView;
@end
