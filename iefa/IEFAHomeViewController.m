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
#import <DropboxSDK/DropboxSDK.h>

@interface IEFAHomeViewController () <DBRestClientDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *randomFactImageView;
@property (weak, nonatomic) IBOutlet UILabel *randomFactTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *randomFactAbout1Label;
@property (strong, nonatomic) IEFADropBoxAccessTokenManager *tokenManager;
@property (strong, nonatomic) DBRestClient *restClient;


@end

@implementation IEFAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Home"]
                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"Home"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *randomFact = [[IEFARandomFactDB randomFacts] objectAtIndex:arc4random_uniform(5)];
    [self.randomFactImageView setImage:[UIImage imageNamed:randomFact[@"image"]]];
    self.randomFactTitle1Label.text = randomFact[@"title"];
    self.randomFactAbout1Label.text = randomFact[@"about"];
    

    DBSession *dbSession = [[DBSession alloc] initWithAppKey:kKeyApp appSecret:kSecretApp root:kDBRootDropbox];
    
    [DBSession setSharedSession:dbSession];
    [[DBSession sharedSession] updateAccessToken:kTokenAccess accessTokenSecret:kSecretToken forUserId:kUserID];
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    [self.restClient loadMetadata:@"/Pictures/"];
    
    
    
    
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
       // NSLog(@"Folder '%@' contains:", metadata.path);
        for (DBMetadata *file in metadata.contents) {
            if([file.filename.stringByStandardizingPath hasSuffix:@".png"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpeg"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpg"]) {
                
                
                NSString *path;
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
                path = [path stringByAppendingPathComponent:file.filename];
                
                
                [self.restClient loadFile:[NSString stringWithFormat:@"%@/%@",metadata.path,file.filename] intoPath:path];
            }
        }
    }
}


- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    
   // [self.randomFactImageView setImage:[UIImage imageWithContentsOfFile:localPath]];
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
