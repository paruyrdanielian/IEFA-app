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

@interface IEFAScheduleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) UIColor *const kColorLightRed;
@property (nonatomic, strong) UIColor *const kColorDarkRed;


@end


@implementation IEFAScheduleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.kColorLightRed = [UIColor colorWithRed:182.0/255.0 green:32.0/255.0 blue:32.0/255.0 alpha:1];
    self.kColorDarkRed = [UIColor colorWithRed:90.0/255.0 green:16.0/255.0 blue:19.0/255.0 alpha:1];

    
    [self loadDays];
}



- (void)loadDays {
    
    self.days = @[ @"July 3", @"July 4", @"July 5", @"July 6", @"July 7", @"July 8", @"July 9"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/5.0f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

    [self performSegueWithIdentifier:kSegueIdentifierDailySceduleSegue sender:indexPath];

    return NO;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierDay forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = self.kColorDarkRed;
        cell.textLabel.backgroundColor = self.kColorDarkRed;
    } else {
        cell.contentView.backgroundColor = self.kColorLightRed;
        cell.textLabel.backgroundColor = self.kColorLightRed;
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.days[indexPath.row];
    
    
    return cell;
}




#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)sender {
    IEFADailyScheduleViewController *vc = [segue destinationViewController];
    vc.day = sender.row + 3;
}


@end
