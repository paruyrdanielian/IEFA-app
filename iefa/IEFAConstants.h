//
//  IEFAConstants.h
//  iefa
//
//  Created by Paruyr Danielian on 6/6/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#ifndef IEFAConstants_h
#define IEFAConstants_h

static NSString *const kCellIdentifierCommittees = @"CommitteeIdentifier";
static NSString *const kSegueIdentifierDailySceduleSegue = @"DailySceduleSegue";
static NSString *const kCellIdentifierDailySchedule = @"DailyScheduleCellIdentifier";
static NSString *const kCellIdentifierDay = @"DayCellIdentifier";
static NSString *const kSegueIdentifierDay = @"DayIdentifier";
static NSString *const kKeyWeatherAPI = @"2170bb0b0bb704fba2b8d6d1b9afcaee";
static NSString *const kIDYerevan = @"616051";
static NSString *const kKeyApp = @"ykdeccp0qb202dv";
static NSString *const kSecretApp = @"tl2tl7imfdsvj27";
static NSString *const kTokenAccess = @"c30k0a7kihrf0i55";
static NSString *const kSecretToken = @"wchutecki6gnd9q";
static NSString *const kUserID = @"575444574";
static NSString *const kCellIdentifierStats = @"StatsIdentifier";
static NSString *const kCellIdentifierMedia = @"MediaIdentifier";
static NSString *const kCellIdentifierMediaActivityIndicator = @"MediaActivityIndicatorIdentifier";




typedef enum : NSUInteger {
    DailySceduleStayleNone,
    DailySceduleStayleDressCode,
    DailySceduleStayleDressCodeAndMap,
} DailySceduleStayle;


#endif /* IEFAConstants_h */
