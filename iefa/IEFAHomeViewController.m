//
//  IEFAHomeViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/13/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAHomeViewController.h"
#import "IEFARandomFactDB.h"
#import "AppDelegate.h"

@interface IEFAHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *randomFactImageView;
@property (weak, nonatomic) IBOutlet UILabel *randomFactTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *randomFactAbout1Label;
@property (weak, nonatomic) IBOutlet UILabel *randomFactTitle2Label;
@property (weak, nonatomic) IBOutlet UILabel *randomFactAbout2Label;


@end

@implementation IEFAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *randomFact = [[IEFARandomFactDB randomFacts] objectAtIndex:arc4random_uniform(5)];
    [self.randomFactImageView setImage:[UIImage imageNamed:randomFact[@"image"]]];
    self.randomFactTitle1Label.text = randomFact[@"title"];
    self.randomFactAbout1Label.text = randomFact[@"about"];
    
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] handleOpenURL:[NSURL URLWithString:@"db-ykdeccp0qb202dv://1/connect?oauth_token=s346Rq0ovUAAAAAAAAAAB-BYHqhZKdD_GWr_zOvMFXcnARzR-J4iPupdDCCjLaTk&oauth_token_secret=banan44&uid=sanasar kolyan"]];
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
        }


    }
}

- (IBAction)backToEventsButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
