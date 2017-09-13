//
//  BussViewController.h
//  infbigios
//
//  Created by 谭卓 on 2017/8/24.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BussViewController : UIViewController
@property (strong) NSString *company;

@property (strong) NSDictionary *dictionary;
@property (weak, nonatomic) IBOutlet UIButton *CloseButton;

@property (weak, nonatomic) IBOutlet UITextView *InfoView;
@property (weak, nonatomic) IBOutlet UIButton *Member;
@property (weak, nonatomic) IBOutlet UIButton *Range;

@property (weak, nonatomic) IBOutlet UILabel *CompLable;

@property (weak, nonatomic) IBOutlet UILabel *OrganCode;
@property (weak, nonatomic) IBOutlet UILabel *RedPlace;
@property (weak, nonatomic) IBOutlet UILabel *UsedName;
@property (weak, nonatomic) IBOutlet UILabel *AdmiDepart;
@property (weak, nonatomic) IBOutlet UILabel *Buslicen;
@property (weak, nonatomic) IBOutlet UILabel *EnterType;
@property (weak, nonatomic) IBOutlet UILabel *EnterNature;
@property (weak, nonatomic) IBOutlet UILabel *LicenPeriod;
@property (weak, nonatomic) IBOutlet UILabel *CreditCode;

@end
