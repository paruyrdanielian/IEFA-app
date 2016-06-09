//
//  IEFAAFCOViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/9/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAAFCOViewController.h"

@interface IEFAAFCOViewController ()

@end

@implementation IEFAAFCOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.AFCOScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
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
