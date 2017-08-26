//
//  MainViewController.h
//  infbigios
//
//  Created by 谭卓 on 2017/8/22.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *GovButton;
@property (weak, nonatomic) IBOutlet UIButton *EnpButton;
@property (weak, nonatomic) IBOutlet UITextField *ComSearch;
@property (weak, nonatomic) IBOutlet UITextField *ProSearch;

@property (nonatomic) NSInteger radio;
@end
