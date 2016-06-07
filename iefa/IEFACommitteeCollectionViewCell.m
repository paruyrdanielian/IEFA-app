//
//  IEFACommitteeCollectionViewCell.m
//  iefa
//
//  Created by Paruyr Danielian on 6/7/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFACommitteeCollectionViewCell.h"

@implementation IEFACommitteeCollectionViewCell


-(void)awakeFromNib {
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = backgroundView;
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"someImageName"]];
}
@end
