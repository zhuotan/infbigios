//
//  FilingViewController.m
//  infbigios
//
//  Created by 谭卓 on 2017/9/7.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "FilingViewController.h"
#import "FilingViewCell.h"

static NSString *CellIdentifer = @"FilingViewCell";
@interface FilingViewController () <UITableViewDataSource>

@end

@implementation FilingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FilingTableView.dataSource = self;
    self.FilingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    return [self.flist count];
}

- (UITableViewCell *)     tableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // area_id
    // level
    // year
    // cate
    
    NSDictionary *dic = [self.flist objectAtIndex:([indexPath row])];
    
    FilingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath];
    if(cell == nil){
        cell = [[FilingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    
    cell.year.text = [dic objectForKey:@"year"];
    cell.level.text = [dic objectForKey:@"level"];
    cell.type.text = [dic objectForKey:@"cate"];
    long long area_id = [[dic objectForKey:@"area_id"]longLongValue];
    switch (area_id) {
        case 2:
            cell.province.text = @"北京";
            break;
        case 3:
            cell.province.text = @"安徽";
            break;
        case 4:
            cell.province.text = @"福建";
            break;
        case 5:
            cell.province.text = @"甘肃";
            break;
        case 6:
            cell.province.text = @"广东";
            break;
        case 7:
            cell.province.text = @"广西";
            break;
        case 8:
            cell.province.text = @"贵州";
            break;
        case 9:
            cell.province.text = @"海南";
            break;
        case 10:
            cell.province.text = @"河北";
            break;
        case 11:
            cell.province.text = @"河南";
            break;
        case 12:
            cell.province.text = @"黑龙江";
            break;
        case 13:
            cell.province.text = @"湖北";
            break;
        case 14:
            cell.province.text = @"湖南";
            break;
        case 15:
            cell.province.text = @"吉林";
            break;
        case 16:
            cell.province.text = @"江苏";
            break;
        case 17:
            cell.province.text = @"江西";
            break;
        case 18:
            cell.province.text = @"辽宁";
            break;
        case 19:
            cell.province.text = @"内蒙古";
            break;
        case 20:
            cell.province.text = @"宁夏";
            break;
        case 21:
            cell.province.text = @"青海";
            break;
        case 22:
            cell.province.text = @"山东";
            break;
        case 23:
            cell.province.text = @"山西";
            break;
        case 24:
            cell.province.text = @"陕西";
            break;
        case 25:
            cell.province.text = @"上海";
            break;
        case 26:
            cell.province.text = @"四川";
            break;
        case 27:
            cell.province.text = @"天津";
            break;
        case 28:
            cell.province.text = @"西藏";
            break;
        case 29:
            cell.province.text = @"新疆";
            break;
        case 30:
            cell.province.text = @"云南";
            break;
        case 31:
            cell.province.text = @"浙江";
        case 32:
            cell.province.text = @"重庆";
        case 33:
            cell.province.text = @"香港";
            break;
        default:
            cell.province.text = @"中国";
            break;
    }
    
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
