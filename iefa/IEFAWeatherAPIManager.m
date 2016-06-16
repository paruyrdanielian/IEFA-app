//
//  IEFAWeatherAPIManager.m
//  iefa
//
//  Created by User on 6/16/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAWeatherAPIManager.h"
#import "IEFAConstants.h"

@interface IEFAWeatherAPIManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation IEFAWeatherAPIManager


+ (IEFAWeatherAPIManager *)sharedManager {
    
    static IEFAWeatherAPIManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[IEFAWeatherAPIManager alloc] init];
    });
    return sharedManager;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)getWeather {
    NSString *URLString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?id=%@&appid=%@",kIDYerevan,kKeyWeatherAPI];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict;
        
        
        
        if (!error) {
            switch ([(NSHTTPURLResponse *)response statusCode]) {
                case 200: {
                    
                    dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    break;
                }
                default:
                    break;
            }
        }
        
        
        NSLog(@"%@",dict);
        
    }];
    [task resume];
}





@end
