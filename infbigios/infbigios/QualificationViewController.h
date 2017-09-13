//
//  QualificationViewController.h
//  infbigios
//
//  Created by 谭卓 on 2017/9/7.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QualificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ColseButton;

@property (weak, nonatomic) IBOutlet UITableView *QualiTable;
@property (nonatomic,strong)  NSMutableArray* qlist;
- (id)initWithDetailArry:(NSMutableArray*) qlist;
@end
