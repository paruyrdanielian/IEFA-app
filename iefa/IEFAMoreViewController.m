//
//  IEFAMoreViewController.m
//  iefa
//
//  Created by Khoren Markosyan on 16.06.16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAMoreViewController.h"

#import <SafariServices/SafariServices.h>

@interface IEFAMoreViewController ()

@end

@implementation IEFAMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)openStats:(UIButton *)sender {
    
    NSURL *URL = [NSURL URLWithString:@"https://stats.eyp.org"];
    
    if ([SFSafariViewController class] != nil) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
        [self presentViewController:sfvc animated:YES completion:nil];
    } else {
        if (![[UIApplication sharedApplication] openURL:URL]) {
            NSLog(@"%@%@",@"Failed to open url:",[URL description]);
        }
    }
    

    
    
}
@end
