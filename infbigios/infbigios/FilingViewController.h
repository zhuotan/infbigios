//
//  FilingViewController.h
//  infbigios
//
//  Created by 谭卓 on 2017/9/7.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *CloseButton;

@property (weak, nonatomic) IBOutlet UITableView *FilingTableView;
@property (nonatomic,strong)  NSMutableArray* flist;
@end
