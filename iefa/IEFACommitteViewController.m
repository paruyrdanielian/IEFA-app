//
//  IEFACommitteViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/10/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFACommitteViewController.h"

@interface IEFACommitteViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *committeTopicLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleInCommittee;
@property (weak, nonatomic) IBOutlet UILabel *nameSurnameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chairImage;
@property (weak, nonatomic) IBOutlet UILabel *chairDiscription;

@end

@implementation IEFACommitteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.committeScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
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
