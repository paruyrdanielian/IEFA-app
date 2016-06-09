//
//  IEFAScheduleViewController.m
//  iefa
//
//  Created by User on 6/7/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAScheduleViewController.h"
#import "IEFADailyScheduleViewController.h"
#import "IEFAConstants.h"

@interface IEFAScheduleViewController ()

@end


@implementation IEFAScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dailyScheduleAction:(id)sender {
    [self performSegueWithIdentifier:kSegueIdentifierDailySceduleSegue sender:sender];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    IEFADailyScheduleViewController *vc = [segue destinationViewController];
    vc.day = sender.tag;
}


@end
