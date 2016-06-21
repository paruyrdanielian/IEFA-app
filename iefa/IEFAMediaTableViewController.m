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

@interface IEFAMediaTableViewController () <DBRestClientDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) IEFADropBoxAccessTokenManager *tokenManager;
@property (strong, nonatomic) DBRestClient *restClient;
@property (strong, nonatomic) UIImage *mediaImage;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger numberOfPhotos;
@property (strong, nonatomic) UIActivityIndicatorView *mediaActivityIndicator;
@property (nonatomic, strong) NSMutableArray *infoOfPhotos;
//@property (assign, nonatomic) BOOL imageDismiss;




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



- (NSArray *)loadSectionDate {
    return @[@"July 3",@"July 4",@"July 5",@"July 6",@"July 7",@"July 8", @"July 9"];
}



- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSLog(@"Folder '%@' contains:", metadata.path);
        [self.mediaActivityIndicator stopAnimating];
        for (DBMetadata *file in metadata.contents) {
            if([file.filename.stringByStandardizingPath hasSuffix:@".png"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpeg"] || [file.filename.stringByStandardizingPath hasSuffix:@".jpg"]) {
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond  fromDate:file.clientMtime];
                
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
                
                
                //[self.restClient loadFile:[NSString stringWithFormat:@"%@/%@",metadata.path,file.filename] intoPath:path];
            
            }
        }
        NSLog(@"%ld",self.infoOfPhotos.count );
        [self.infoOfPhotos sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([[obj1 objectAtIndex:0] integerValue] < [[obj2 objectAtIndex:0] integerValue]) {
                return NSOrderedDescending;
            } else {
                return NSOrderedAscending;
            }
        }];
        
        
        [self.tableView reloadData];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
    path = [path stringByAppendingPathComponent:[self.infoOfPhotos[indexPath.section] objectAtIndex:(indexPath.row+1)]];
    
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    CGFloat ratio =  image.size.width / image.size.height;
    return self.view.frame.size.width / ratio + 5;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [[self loadSectionDate] objectAtIndex:([self.infoOfPhotos count] - section-1)];
    return [NSString stringWithFormat :@"July %ld", [[self.infoOfPhotos[section] objectAtIndex:0] integerValue]];
}

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.infoOfPhotos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSLog(@"%ld +++++++++++", (long)section);
    return [self.infoOfPhotos[section] count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IEFAMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierMedia forIndexPath:indexPath];
    
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/"];
    path = [path stringByAppendingPathComponent:[self.infoOfPhotos[indexPath.section] objectAtIndex:(indexPath.row+1)]];
    
    
    [[cell mediaImage] setImage:[UIImage imageWithContentsOfFile:path]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *imageViewController = [[UIViewController alloc]init];

    
    
    IEFAMediaTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *mediaImageView = [[UIImageView alloc] initWithImage:cell.mediaImage.image] ;
    mediaImageView.frame = cell.mediaImage.bounds;
    mediaImageView.contentMode = UIViewContentModeScaleToFill;
    mediaImageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    
    
    UIScrollView *imageScrlView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    
    imageScrlView.tag = 7;
    imageScrlView.backgroundColor = [UIColor blackColor];
    
    imageScrlView.maximumZoomScale = 5.0;
    imageScrlView.minimumZoomScale = 1;
    imageScrlView.clipsToBounds = YES;
    imageScrlView.userInteractionEnabled = YES;
    imageScrlView.delegate = self;
    
    [imageViewController.view addSubview: imageScrlView];
    [imageScrlView addSubview:mediaImageView];
    [self.navigationController pushViewController:imageViewController animated:YES];
   // imageScrlView.contentSize = CGSizeMake(imageView.frame.size.width , imageView.frame.size.height + 5);
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return scrollView.subviews[0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    if (offsetY == 0) {
        [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height + 10)];
    }
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}


@end
