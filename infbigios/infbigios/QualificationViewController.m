//
//  QualificationViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/9/7.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "QualificationViewController.h"

static NSString *TableViewCellIdentifier = @"QuliCell";

@interface QualificationViewController () <UITableViewDataSource>

@end

@implementation QualificationViewController

- (id)initWithDetailArry:(NSMutableArray*) qlist{
    self = [self init];
    self.qlist = qlist;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.QualiTable registerClass:[UITableViewCell class]
             forCellReuseIdentifier:TableViewCellIdentifier];
    self.QualiTable.dataSource = self;
    //self..dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return [self.qlist count];
}

- (UITableViewCell *)     tableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    cell = [tableView
            dequeueReusableCellWithIdentifier:TableViewCellIdentifier
            forIndexPath:indexPath];
    NSString *Qulistr = self.qlist[indexPath.row];
    cell.textLabel.font =  [UIFont fontWithName:@"PingFangTC-Thin" size:14];
    cell.textLabel.text =Qulistr;
    return cell;
    
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
