//
//  IEFAMoreTableViewController.m
//  iefa
//
//  Created by Khoren Markosyan on 08.06.16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAMoreTableViewController.h"

#import <SafariServices/SafariServices.h>

@interface IEFAMoreTableViewController ()

@end

@implementation IEFAMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 4) {
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
}

@end
