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

@synthesize acList, acArray,
acDescription, acID,
maxGross, mgva,
emptyWeight, emptyWeightArm, emptyWeightMoment,
maxFuelGal, defaultFuelGal, defaultTaxiFuelGal, defaultFlightFuelGal, fuelArm,
defaultStation1Weight, defaultStation2Weight,defaultStation3Weight, defaultStation4Weight,
station1Arm, station2Arm, station3Arm, station4Arm,
station1Name, station2Name, station3Name, station4Name,
momentArray1, momentArray2, balanceArray;


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

- (void) viewWillDisappear:(BOOL)animated {
    
    NSLog(@"I'm in Aircraft Menu. The value of defaultFuel is %f", defaultFuelGal);
    
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
    [self shareData];
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
    acList = data.acList;
    acArray = [[NSMutableArray alloc] init];

    acDescription = data.acDescription;
    acID = data.acID;
    maxGross = data.maxGross;
    mgva = data.mgva;
    emptyWeight = data.emptyWeight;
    emptyWeightArm = data.emptyWeightArm;
    maxFuelGal = data.maxFuelGal;
    defaultFuelGal = data.emptyWeightArm;
    defaultTaxiFuelGal = data.defaultTaxiFuelGal;
    defaultFlightFuelGal = data.defaultFlightFuelGal;
    fuelArm = data.fuelArm;
    defaultStation1Weight = data.defaultStation1Weight;
    defaultStation2Weight = data.defaultStation2Weight;
    defaultStation3Weight = data.defaultStation3Weight;
    defaultStation4Weight = data.defaultStation4Weight;
    station1Arm = data.station1Arm;
    station2Arm = data.station2Arm;
    station3Arm = data.station3Arm;
    station4Arm = data.station4arm;
    station1Name = data.station1Name;
    station2Name = data.station2Name;
    station3Name = data.station3Name;
    station4Name = data.station4Name;
    momentArray1 = data.momentArray1;
    momentArray2 = data.momentArray2;
    balanceArray = data.balanceArray;
    
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
    acDescription =         [selectedAC objectForKey:@"acDescription"];
    acID =                  [selectedAC objectForKey:@"acID"];
    maxGross =              [[selectedAC objectForKey:@"maxGross"] floatValue];
    mgva =                  [[selectedAC objectForKey:@"mgva"] floatValue];
    emptyWeight =           [[selectedAC objectForKey:@"emptyWeight"] floatValue];
    emptyWeightArm =        [[selectedAC objectForKey:@"emptyWeightArm"] floatValue];
    maxFuelGal =            [[selectedAC objectForKey:@"maxFuel"] floatValue];
    defaultFuelGal =        [[selectedAC objectForKey:@"defaultFuel"] floatValue];
    defaultTaxiFuelGal =    [[selectedAC objectForKey:@"defaultTaxiFuel"] floatValue];
    defaultFlightFuelGal =  [[selectedAC objectForKey:@"defaultFlightFuel"] floatValue];
    fuelArm =               [[selectedAC objectForKey:@"fuelArm"] floatValue];
    defaultStation1Weight = [[selectedAC objectForKey:@"defaultStation1Weight"] floatValue];
    defaultStation2Weight = [[selectedAC objectForKey:@"defaultStation2Weight"] floatValue];
    defaultStation3Weight = [[selectedAC objectForKey:@"defaultStation3Weight"] floatValue];
    defaultStation4Weight = [[selectedAC objectForKey:@"defaultStation4Weight"] floatValue];
    station1Arm =           [[selectedAC objectForKey:@"station1Arm"] floatValue];
    station2Arm =           [[selectedAC objectForKey:@"station2Arm"] floatValue];
    station3Arm =           [[selectedAC objectForKey:@"station3Arm"] floatValue];
    station4Arm =           [[selectedAC objectForKey:@"station4Arm"] floatValue];
    station1Name =          [selectedAC objectForKey:@"station1Name"];
    station2Name =          [selectedAC objectForKey:@"station2Name"];
    station3Name =          [selectedAC objectForKey:@"station3Name"];
    station4Name =          [selectedAC objectForKey:@"station4Name"];
    momentArray1 =          [selectedAC objectForKey:@"momentArray1"];
    momentArray2 =          [selectedAC objectForKey:@"momentArray2"];
    balanceArray =          [selectedAC objectForKey:@"balanceArray"];
    
    
    NSLog(@"I'm in setData. The selected aircraft is %@", acID);
    NSLog(@"The default fuel value is %f", defaultFuelGal);
}

- (void)shareData {
    
    Singleton *data = [Singleton sharedInput];
    
    data.defaultFuelGal = defaultFuelGal;
    data.fuelArm = fuelArm;
    data.defaultStation1Weight = defaultStation1Weight;
    data.defaultStation2Weight = defaultStation1Weight;
    data.defaultStation3Weight = defaultStation1Weight;
    data.defaultStation4Weight = defaultStation1Weight;
    data.station1Arm = station1Arm;
    data.station1Arm = station1Arm;
    data.station1Arm = station1Arm;
    data.station1Arm = station1Arm;
    data.station1Arm = station1Arm;
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
