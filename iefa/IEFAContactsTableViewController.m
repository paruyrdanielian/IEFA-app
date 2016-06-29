//
//  IEFAContactsTableViewController.m
//  iefa
//
//  Created by Khoren Markosyan on 28.06.16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAContactsTableViewController.h"
#import "IEFAConstants.h"

@interface IEFAContactModel : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *phoneNumber;

+ (instancetype)contactWithFullName:(NSString *)fullName phoneNumber:(NSString *)phoneNumber;

- (instancetype)initWithFullName:(NSString *)fullName phoneNumber:(NSString *)phoneNumber;

@end

@implementation IEFAContactModel

+ (instancetype)contactWithFullName:(NSString *)fullName phoneNumber:(NSString *)phoneNumber {
    return [[IEFAContactModel alloc]initWithFullName:fullName phoneNumber:phoneNumber];
}

- (instancetype)initWithFullName:(NSString *)fullName phoneNumber:(NSString *)phoneNumber {
    
    self = [super init];
    if (self) {
        self.fullName = fullName;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

@end


@interface IEFAContactSectionModel : NSObject

@property (nonatomic, strong) NSString *sectionHeaderTitle;
@property (nonatomic, strong) NSMutableArray *contacts;

+ (instancetype)sectionModelWithSectionHeaderTitle:(NSString *)title;

- (instancetype)initWithSectionHeaderTitle:(NSString *)title;

@end

@implementation IEFAContactSectionModel

+ (instancetype)sectionModelWithSectionHeaderTitle:(NSString *)title {
    return [[IEFAContactSectionModel alloc]initWithSectionHeaderTitle:title];
}

- (instancetype)initWithSectionHeaderTitle:(NSString *)title {
    
    self = [super init];
    if (self) {
        self.sectionHeaderTitle = title;
    }
    return self;
}

@end




@interface IEFAContactsTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation IEFAContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    IEFAContactSectionModel *section0 =
    [IEFAContactSectionModel sectionModelWithSectionHeaderTitle:@"Head Organisers"];
    section0.contacts = [@[[IEFAContactModel contactWithFullName:@"Nune Hayrapetyan" phoneNumber:@"+374 94 600210"],
                           [IEFAContactModel contactWithFullName:@"Arman Gasparian" phoneNumber:@"+374 94 934488"]] mutableCopy];
    
    IEFAContactSectionModel *section1 =
    [IEFAContactSectionModel sectionModelWithSectionHeaderTitle:@"Chairs Support"];
    section1.contacts = [@[[IEFAContactModel contactWithFullName:@"Tigran Bazarchyan" phoneNumber:@"+374 55 520339"]] mutableCopy];
    
    IEFAContactSectionModel *section2 =
    [IEFAContactSectionModel sectionModelWithSectionHeaderTitle:@"Outreach, Media and PR"];
    section2.contacts = [@[[IEFAContactModel contactWithFullName:@"Tatev Mkrtumyan" phoneNumber:@"+374 91 704515"],
                           [IEFAContactModel contactWithFullName:@"Davit Kocharyan" phoneNumber:@"+374 93 714664"],
                           [IEFAContactModel contactWithFullName:@"Elen Simonyan" phoneNumber:@"+374 77 533035"]] mutableCopy];
    
    
    self.dataSource = [@[section0, section1, section2] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    IEFAContactSectionModel *currentSection = self.dataSource[section];
    
    return currentSection.contacts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    IEFAContactSectionModel *currentSection = self.dataSource[section];
    
    return currentSection.sectionHeaderTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierContacts forIndexPath:indexPath];
    
    IEFAContactSectionModel *currentSection = self.dataSource[indexPath.section];
    IEFAContactModel *currentContact = currentSection.contacts[indexPath.row];
    
    cell.textLabel.text = currentContact.fullName;
    cell.detailTextLabel.text =  currentContact.phoneNumber;
    
    cell.accessoryView = [self accessoryView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)accessoryView {
    
    UIButton *accessory = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [accessory setImage:[UIImage imageNamed:@"infoIcon"] forState:UIControlStateNormal];
    [accessory addTarget:self action:@selector(onCustomAccessoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return accessory;
}

- (void)onCustomAccessoryTapped:(UIButton *)sender {
    
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Now you can do the following
    [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    IEFAContactSectionModel *currentSection = self.dataSource[indexPath.section];
    IEFAContactModel *currentContact = currentSection.contacts[indexPath.row];
    
    [self callToNumber:currentContact.phoneNumber];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)callToNumber:(NSString *)number {
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",number]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                                 message:@"Call facility is not available!!!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:^{
                             
                         }];
    }
    
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
