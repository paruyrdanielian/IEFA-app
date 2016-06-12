//
//  IEFACommitteViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/10/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFACommitteViewController.h"
#import "IEFACommitteDB.h"

@interface IEFACommitteViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *committeTopicLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleInCommittee;
@property (weak, nonatomic) IBOutlet UILabel *nameSurnameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chairImage;
@property (weak, nonatomic) IBOutlet UILabel *chairDiscription;
@property (weak, nonatomic) IBOutlet UIImageView *committeImage;

@end

@implementation IEFACommitteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.committeTopicLabel sizeToFit];
    self.committeTopicLabel.numberOfLines = 0;

    NSDictionary *committeInfo = nil;
    
        switch (self.selectedCommitteeCell) {
            case 0:
                committeInfo = [IEFACommitteDB AFCO];
                break;
            case 1:
                committeInfo = [IEFACommitteDB ECON];
                break;
            case 2:
                committeInfo = [IEFACommitteDB AFET];
                break;
            case 3:
                committeInfo = [IEFACommitteDB PECH];
                break;
            case 4:
                committeInfo = [IEFACommitteDB JURI];
                break;
            case 5:
                committeInfo = [IEFACommitteDB SEDE];
                break;
            case 6:
                committeInfo = [IEFACommitteDB DROI];
                break;
            case 7:
                committeInfo = [IEFACommitteDB DEVE];
                break;
            case 8:
                committeInfo = [IEFACommitteDB LIBE];
                break;
            case 9:
                committeInfo = [IEFACommitteDB ENVI];
                break;
            default:
                break;
                
           }
    
    self.committeTopicLabel.text = [committeInfo objectForKey:@"CommitteTopic"];
    self.peopleInCommittee.text = [committeInfo objectForKey:@"PeopleInCommitte"];
    self.nameSurnameLabel.text = [committeInfo objectForKey:@"NameSurname"];
    self.chairDiscription.text = [committeInfo objectForKey:@"ChairDiscription"];
    [self.chairImage setImage:[UIImage imageNamed:[committeInfo objectForKey:@"ChairImage"]]];
}

- (void)viewDidLayoutSubviews {
   [self.committeScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
//     self.committeScrollView.contentSize = self.view.frame.size;
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
