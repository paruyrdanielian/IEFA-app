//
//  IEFAMediaTableViewController.m
//  iefa
//
//  Created by Paruyr Danielian on 6/20/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAMediaTableViewController.h"
#import "IEFAMediaTableViewCell.h"
#import "IEFAConstants.h"
#import "AppDelegate.h"
#import "IEFADropBoxAccessTokenManager.h"
#import <DropboxSDK/DropboxSDK.h>

@interface IEFAMediaTableViewController () <DBRestClientDelegate>
@property (strong, nonatomic) IEFADropBoxAccessTokenManager *tokenManager;
@property (strong, nonatomic) DBRestClient *restClient;
@property (strong, nonatomic) UIImage *mediaImage;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger numberOfPhotos;
@property (strong, nonatomic) UIActivityIndicatorView *mediaActivityIndicator;
@property (nonatomic, strong) NSMutableArray *infoOfPhotos;



@end

@implementation IEFAMediaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoOfPhotos = [[NSMutableArray alloc] init];
    self.mediaActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:self.mediaActivityIndicator];
    self.mediaActivityIndicator.center =self.view.center;
    [self.mediaActivityIndicator startAnimating];
    
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:kKeyApp appSecret:kSecretApp root:kDBRootDropbox];
    
    [DBSession setSharedSession:dbSession];
    [[DBSession sharedSession] updateAccessToken:kTokenAccess accessTokenSecret:kSecretToken forUserId:kUserID];
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    [self.restClient loadMetadata:@"/Pictures/"];
    self.mediaActivityIndicator.center = self.view.center;


    
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSLog(@"Folder '%@' contains:", metadata.path);
        [self.mediaActivityIndicator stopAnimating];
        for (DBMetadata *file in metadata.contents) {
            if([file.filename.stringByStandardizingPath hasSuffix:@".png"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpeg"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpg"]) {
                
                NSDateComponents *components = [[NSCalendar currentCalendar]components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:file.clientMtime];
                
                BOOL arrayIsFound = NO;
                NSLog(@"%ld Components day", [components day]);
                for (NSMutableArray *days in self.infoOfPhotos) {
                    if ([days[0] integerValue] == [components day]) {
                        [days insertObject:file.filename atIndex:[days count]];
                        arrayIsFound = YES;
                    }
                }
                
                if (!arrayIsFound) {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array insertObject:[NSNumber numberWithInteger:[components day]] atIndex:0];
                    [array insertObject:file.filename atIndex:1];
                    [self.infoOfPhotos insertObject:array atIndex:self.infoOfPhotos.count];
                }
                
                
                
                
                
                
                
                NSLog(@"%@\n %lu",file.clientMtime, (unsigned long)[metadata.contents count]);
                self.numberOfPhotos = [metadata.contents count];
                NSString *path;
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
                path = [path stringByAppendingPathComponent:file.filename];
                
                
                [self.restClient loadFile:[NSString stringWithFormat:@"%@/%@",metadata.path,file.filename] intoPath:path];
            
            }
        }
        NSLog(@"%ld",self.infoOfPhotos.count );
        
        [self.tableView reloadData];
    }
}


- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    
    
    self.mediaImage =[UIImage imageWithContentsOfFile:localPath];
    dispatch_async(dispatch_get_main_queue(), ^{
       // [self.tableView reloadData];
    });
    NSLog(@"File loaded into path: %@", localPath);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.infoOfPhotos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSLog(@"%ld +++++++++++", (long)section);
    return self.numberOfPhotos;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IEFAMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierMedia forIndexPath:indexPath];
    [[cell imageView] setImage:self.mediaImage];
    //[[cell textLabel] setText:[NSString stringWithFormat:@"%d",[indexPath row]];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
