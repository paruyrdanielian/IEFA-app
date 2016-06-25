//
//  IEFASchedule.m
//  iefa
//
//  Created by User on 6/7/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFASchedule.h"
#import "IEFAConstants.h"

@implementation IEFASchedule


+ (NSArray *)scheduleForThirdDay {
    return @[ @{ @"startTime" : @"09:00",
                 @"endTime" : @"11:00",
                 @"evant" : @"Arrival of international delegates",
                 @"show" :[NSNumber numberWithInteger:DailySceduleStayleNone]
                 },
                     
              @{ @"startTime" : @"11:00",
                 @"endTime" : @"13:00",
                 @"evant" : @"Teambuilding(1)",
                 @"place" : @[@40.196411, @44.480097],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"TUMO",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
                     
              @{ @"startTime" : @"13:00",
                 @"endTime" : @"14:00",
                 @"evant" : @"Lunch",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"14:00",
                 @"endTime" : @"16:00",
                 @"evant" : @"Teambuilding(2)",
                 @"place" : @[@40.196411, @44.480097],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"TUMO",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},

                     
              @{ @"startTime" : @"16:00",
                 @"endTime" : @"16:30",
                 @"evant" : @"Coffee break",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
                     
              @{ @"startTime" : @"16:30",
                 @"endTime" : @"18:00",
                 @"evant" : @"Teambuilding(3)",
                 @"place" : @[@40.196411, @44.480097],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"TUMO",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"18:00",
                 @"endTime" : @"19:00",
                 @"evant" : @"Transfer to Eurovillage Venue",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
            
              @{ @"startTime" : @"19:00",
                 @"endTime" : @"23:00",
                 @"evant" : @"Eurovillage and Vardavar Festival",
                 @"place" : @[@40.176196, @44.514568],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Safran",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]}
              ];
    
}


+ (NSArray *)scheduleForForthDay {
    return @[ @{ @"startTime" : @"09:00",
                 @"endTime" : @"10:30",
                 @"evant" : @"Opening Ceremony",
                 @"place" : @[@40.177016, @44.515252],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"AGBU",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"10:30",
                 @"endTime" : @"11:00",
                 @"evant" : @"Reception",
                 @"place" : @[@40.177016, @44.515252],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"AGBU",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"11:00",
                 @"endTime" : @"11:15",
                 @"evant" : @"Transfer to CW Venue",
                 @"place" : @[@40.168638, @44.435778],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Avedisian School"},
              
              @{ @"startTime" : @"11:15",
                 @"endTime" : @"14:00",
                 @"evant" : @"Committee Work(1)",
                 @"place" : @[@40.168638, @44.435778],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Avedisian School",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"14:00",
                 @"endTime" : @"15:00",
                 @"evant" : @"Lunch break",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"15:00",
                 @"endTime" : @"17:00",
                 @"evant" : @"Committee Work(2)",
                 @"place" : @[@40.168638, @44.435778],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Avedisian School",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"17:00",
                 @"endTime" : @"17:30",
                 @"evant" : @"Coffee break",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"17:30",
                 @"endTime" : @"19:00",
                 @"evant" : @"Committee Work(3)",
                 @"place" : @[@40.168638, @44.435778],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Avedisian School",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"19:30",
                 @"endTime" : @"00:00",
                 @"evant" : @"Traditional Armenian Dinner",
                 @"place" : @[@40.179993, @44.514848],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Megerian carpet",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]}
              ];
    
}

+ (NSArray *)scheduleForFifthDay {
    return @[ @{ @"startTime" : @"10:00",
                 @"endTime" : @"12:00",
                 @"evant" : @"Free time",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"12:30",
                 @"endTime" : @"16:00",
                 @"evant" : @"Treasure Hunt",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"16:30",
                 @"endTime" : @"17:30",
                 @"evant" : @"Committee Lunch",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleNone]},
              
              @{ @"startTime" : @"18:00",
                 @"endTime" : @"20:00",
                 @"evant" : @"Euro Concert",
                 @"place" : @[@40.179005, @44.513651],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Arno Babajanian Hall",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]},
              
              @{ @"startTime" : @"20:30",
                 @"endTime" : @"00:00",
                 @"evant" : @"Dinner at Megerian Carpets",
                 @"place" : @[@40.179993, @44.514848],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Megerian carpet",
                 @"show" : [NSNumber numberWithInteger:DailySceduleStayleDressCodeAndMap]}
              ];
    
}

+ (NSArray *)scheduleForSixthDay {
    return @[ @{ @"startTime" : @"09:00",
                 @"endTime" : @"11:30",
                 @"evant" : @"Committee Work(4)",
                 @"place" : @"",
                 @"dressCode" : @"",
 //   map
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"11:30",
                 @"endTime" : @"12:00",
                 @"evant" : @"Coffee break",
                 @"place" : @"",
                 @"dressCode" : @"",
    // non
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"12:00",
                 @"endTime" : @"14:00",
                 @"evant" : @"Committee Work(5)",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"14:00",
                 @"endTime" : @"15:00",
                 @"evant" : @"Lunch break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"15:00",
                 @"endTime" : @"16:30",
                 @"evant" : @"Committee Work(6)",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"16:30",
                 @"endTime" : @"17:00",
                 @"evant" : @"Coffee break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"17:00",
                 @"endTime" : @"19:00",
                 @"evant" : @"Committee Work(7)",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"19:30",
                 @"endTime" : @"21:00",
                 @"evant" : @"Dinner",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"21:00",
                 @"endTime" : @"00:00",
                 @"evant" : @"Thematic Party",
                 @"place" : @"",
                 @"dressCode" : @"",
      // map
                 @"aboutPlace" : @"The Venue"}

              ];
    
}


+ (NSArray *)scheduleForSeventhDay {
    return @[ @{ @"startTime" : @"10:00",
                 @"endTime" : @"12:30",
                 @"evant" : @"Opening of the General Assembly, Committees 1, 2",
                 @"place" : @[@40.173808, @44.504237],
                 @"dressCode" : @"",
                 @"aboutPlace" : @"Moscow House"},
              
              @{ @"startTime" : @"12:30",
                 @"endTime" : @"13:00",
                 @"evant" : @"Coffee Break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"13:00",
                 @"endTime" : @"14:00",
                 @"evant" : @"GA, Committee 3",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"14:00",
                 @"endTime" : @"15:00",
                 @"evant" : @"Lunch Break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"15:00",
                 @"endTime" : @"17:30",
                 @"evant" : @"GA, Committee 4, 5",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"19:00",
                 @"endTime" : @"21:00",
                 @"evant" : @"Dinner",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"21:00",
                 @"endTime" : @"00:00",
                 @"evant" : @"Free time",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""}
              ];
    
}

+ (NSArray *)scheduleForEighthDay {
    return @[ @{ @"startTime" : @"10:00",
                 @"endTime" : @"12:30",
                 @"evant" : @"GA, Committee 6, 7",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"12:30",
                 @"endTime" : @"13:00",
                 @"evant" : @"Coffee Break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"13:00",
                 @"endTime" : @"14:00",
                 @"evant" : @"GA, Committee 8",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"14:00",
                 @"endTime" : @"15:00",
                 @"evant" : @"Lunch Break",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"15:00",
                 @"endTime" : @"17:30",
                 @"evant" : @"GA, Committee 9, 10",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"17:30",
                 @"endTime" : @"19:30",
                 @"evant" : @"Closing Ceremony",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""},
              
              @{ @"startTime" : @"20:00",
                 @"endTime" : @"02:00",
                 @"evant" : @"Farewell Party",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @""}
              
              ];
    
}

+ (NSArray *)scheduleForNinthDay {
    return @[ @{ @"startTime" : @"ALL day",
                 @"endTime" : @"",
                 @"evant" : @"Seeing off International Delegates",
                 @"place" : @"",
                 @"dressCode" : @"",
                 @"aboutPlace" : @"" }
              
              ];
    
}


@end
