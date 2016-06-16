//
//  IEFATopicOverviewViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/15/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFATopicOverviewViewController.h"
#import <SafariServices/SafariServices.h>
#import "IEFACommitteViewController.h"

@interface IEFATopicOverviewViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
@end

@implementation IEFATopicOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.title = ;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {

    if ([SFSafariViewController class] != nil) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
        [self presentViewController:sfvc animated:YES completion:nil];
    } else if (![[UIApplication sharedApplication] openURL:URL]) {
        NSLog(@"%@%@",@"Failed to open url:",[URL description]);
    }
    
    return NO;
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
