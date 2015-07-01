//
//  AircraftMenuTableViewController.m
//  WAB
//
//  Created by Robert Mahoney on 6/3/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "AircraftMenuTableViewController.h"

@interface AircraftMenuTableViewController ()

@property int selectedRow;
@property NSArray *aircraft;
@property NSIndexPath *oldIndex;
@property(retain) NSIndexPath *lastIndexPath;
@property NSMutableArray *acArray;

@end

@implementation AircraftMenuTableViewController

@synthesize acList, acArray, acDescription, acID, fuelWeight, fuelGal, fuelMoment, frontSeatWeight, frontSeatMoment, rearSeatWeight, rearSeatMoment, bag1Weight, bag1Moment, bag2Weight, bag2Moment, taxiFuelWeight, taxiFuelMoment, flightFuelWeight, flightFuelMoment;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    NSLog(@"The contents of _acList are: %@", acList);
    
    _aircraft = [[NSArray alloc] initWithObjects:@"N73262 - 1976 C-172 M", @"N6796H - 1975 C-172 M", @"N0376Q - 1972 C-182 P", @"N668DB - 1975 C-210 L", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"_acList count is %d", (int)[acList count]);
    return acList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"the selected row is %d", (int)indexPath.row);
    self.lastIndexPath = indexPath;
    [self setData:indexPath];
    [tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"prototypeCell" forIndexPath:indexPath];

    static NSString *CellIdentifier = @"prototypeCell";
    
    if(cell == nil )
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSLog(@"%@", [acList objectAtIndex:indexPath.row]);
    cell.textLabel.text = [[acArray objectAtIndex:indexPath.row] objectForKey:@"acID"];
    
    return cell;
}

- (void) getData {
    
    Singleton *data = [Singleton sharedInput];
    acDescription = data.acDescription;
    fuelWeight = data.fuelWeight;
    fuelMoment = data.fuelMoment;
    frontSeatWeight = data.frontSeatWeight;
    frontSeatMoment = data.frontSeatMoment;
    rearSeatWeight = data.rearSeatWeight;
    rearSeatMoment = data.rearSeatMoment;
    bag1Weight = data.bag1Weight;
    bag1Moment = data.bag1Moment;
    bag2Weight = data.bag2Weight;
    bag2Moment = data.bag2Moment;
    flightFuelWeight = data.flightFuelWeight;
    flightFuelMoment = data.flightFuelMoment;
    taxiFuelWeight = data.taxiFuelWeight;
    taxiFuelMoment = data.taxiFuelMoment;
    
    acList = data.acList;
    acArray = [[NSMutableArray alloc] init];
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectoryPath = [pathsArray objectAtIndex:0];
    NSString *dataPath = [documentDirectoryPath stringByAppendingPathComponent:@"/ACData"];
    int listCount = (int)[acList count];
    for ( int i = 0 ; i < listCount ; i++ ) {
        NSString *filePath = [dataPath stringByAppendingPathComponent:acList[i]];
        acArray[i] = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
}

- (void) setData:(NSIndexPath *)indexPath {
    
    int i = (int)indexPath.row;
    NSDictionary *selectedAC = acArray[i];
    acDescription = [selectedAC objectForKey:@"acDescription"];
    acID = [selectedAC objectForKey:@"acID"];
    
    NSLog(@"I'm in setData. The selected acDescription is %@", acDescription);
}



/*
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"oldIndex = %d", (int)_oldIndex);
    _oldIndex = [self.tableView indexPathForSelectedRow];
    [self.tableView cellForRowAtIndexPath:_oldIndex].accessoryType = UITableViewCellAccessoryNone;
    [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    return indexPath;
}
*/
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
