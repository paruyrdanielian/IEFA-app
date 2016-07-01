//
//  IEFAHomeViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/13/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAHomeViewController.h"
#import "IEFARandomFactDB.h"
#import "IEFAConstants.h"
#import "AppDelegate.h"
#import "IEFADropBoxAccessTokenManager.h"
#import "IEFAWeatherAPIManager.h"
#import <DropboxSDK/DropboxSDK.h>

@interface IEFAHomeViewController () <DBRestClientDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *randomFactImageView;
@property (weak, nonatomic) IBOutlet UILabel *randomFactTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *randomFactAbout1Label;
@property (strong, nonatomic) IEFADropBoxAccessTokenManager *tokenManager;
@property (strong, nonatomic) DBRestClient *restClient;
@property (weak, nonatomic) IBOutlet UIButton *resolutionBookletButton;
@property (nonatomic, strong) NSString *downloadPath;
@property (nonatomic, assign) BOOL download;
@property (strong, nonatomic) UIActivityIndicatorView *resolutionBookletActivityIndicator;

@end

@implementation IEFAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kFileNameResolutionBooklet]) {
        [self resolutionBooklet];
    } else {
        DBSession *dbSession = [[DBSession alloc] initWithAppKey:kKeyApp appSecret:kSecretApp root:kDBRootDropbox];
        
        [DBSession setSharedSession:dbSession];
        [[DBSession sharedSession] updateAccessToken:kTokenAccess accessTokenSecret:kSecretToken forUserId:kUserID];
        
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
        [self.restClient loadMetadata:@"/"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
    
    [[IEFAWeatherAPIManager sharedManager] getWeatherComplitionHandler:^(NSString *temp, NSString *weather) {
        self.weatherLabel.text = [NSString stringWithFormat:@"%@° C\n%@",temp,weather];
    }];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kFileNameResolutionBooklet];
    
    
    
    NSDictionary *randomFact = [[IEFARandomFactDB randomFacts] objectAtIndex:arc4random_uniform(20)];
    [self.randomFactImageView setImage:[UIImage imageNamed:randomFact[@"image"]]];
    self.randomFactTitle1Label.text = randomFact[@"title"];
    self.randomFactAbout1Label.text = randomFact[@"about"];
    [self.resolutionBookletButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.resolutionBookletButton.titleLabel setNumberOfLines:0];
}

- (IBAction)resolutionBookletAction:(id)sender {
    
    if (self.download) {
        self.download = NO;
        self.resolutionBookletButton.enabled = NO;
        self.resolutionBookletActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.resolutionBookletActivityIndicator.center =self.resolutionBookletButton.titleLabel.center;
        [self.resolutionBookletActivityIndicator startAnimating];
        [self.resolutionBookletButton addSubview:self.resolutionBookletActivityIndicator];
        
        NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
        path = [path stringByAppendingPathComponent:kFileNameResolutionBooklet];
        [self.restClient loadFile:self.downloadPath intoPath:path];

        
        
    } else {
        NSString *filePath;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
        filePath = [filePath stringByAppendingPathComponent:kFileNameResolutionBooklet];
        
        UIViewController *pdfViewController = [[UIViewController alloc]init];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        NSString *urlString = [fileUrl absoluteString];
        NSString *encodedString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *webViewURL = [NSURL URLWithString:encodedString];
        webView.scalesPageToFit = YES;
        NSURLRequest *request = [NSURLRequest requestWithURL:webViewURL];
        [webView loadRequest:request];
        [pdfViewController.view addSubview:webView];
        [self.navigationController pushViewController:pdfViewController animated:YES ];
        [self.navigationController setNavigationBarHidden:NO];
    }
    
    
    
    
    
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
       // NSLog(@"Folder '%@' contains:", metadata.path);
        for (DBMetadata *file in metadata.contents) {
            if([file.filename.stringByStandardizingPath hasSuffix:kFileNameResolutionBooklet]) {
                
                
                
                self.downloadPath = [NSString stringWithFormat:@"%@/%@",metadata.path,file.filename];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self downloadIsReady];
                });
                
                
            }
        }
    }
}


- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFileNameResolutionBooklet];
        dispatch_async(dispatch_get_main_queue(), ^{
        
        [self resolutionBooklet];
        [self.resolutionBookletActivityIndicator stopAnimating];
    });
}


- (void)downloadIsReady {
    
    self.resolutionBookletButton.enabled = YES;
    [self.resolutionBookletButton setTitle:@"Download\nResolution\nBooklet" forState:UIControlStateNormal];
    [self.resolutionBookletButton setTitle:@"Download\nResolution\nBooklet" forState:UIControlStateDisabled];
    [self.view layoutIfNeeded];
    self.download = YES;

}

- (void)resolutionBooklet {
    self.resolutionBookletButton.enabled = YES;
    [self.resolutionBookletButton setTitle:@"Resolution\nBooklet" forState:UIControlStateNormal];
    [self.view layoutIfNeeded];

    
}


- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
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
