//
//  WeightsVC.h
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "WeightsVC.h"
#import "MomentEnvelopeVC.h"

@interface WeightsVC () {
    
}

@end

@implementation WeightsVC

@synthesize  acDescription, acID, maxGross, mgva, emptyWeight, emptyWeightArm, emptyWeightMoment, maxFuelGal, defaultFuelGal, defaultTaxiFuelGal, defaultFlightFuelGal, fuelArm, defaultStation1Weight, defaultStation2Weight, defaultStation3Weight, defaultStation4Weight, station1Arm, station2Arm, station3Arm, station4Arm, station1Name, station2Name, station3Name, station4Name, momentArray1, momentArray2, balanceArray, fuelGal, fuelWeight, fuelMoment, fuelGalField, fuelWeightField, fuelMomentField;

- (void) viewDidLoad {
    [self copyData];

    


    [super viewDidLoad];
    [self keypadSetup];
}

- (void) viewWillAppear:(BOOL)animated {


}
- (void) viewDidAppear:(BOOL)animated {
    [self getData];
    _eWeightField.text = [NSString stringWithFormat:@"%.1f", emptyWeight];
    _eWeightArmField.text = [NSString stringWithFormat:@"%.1f", emptyWeightArm];
    _eWeightMomentField.text = [NSString stringWithFormat:@"%.1f", emptyWeightMoment];
    _totalMomentLabel.text = [NSString stringWithFormat:@"%.1f", emptyWeightMoment];
    _totalWeightLabel.text = [NSString stringWithFormat:@"%.1f", emptyWeight];
    _totalArmField.text = [NSString stringWithFormat:@"%.1f", emptyWeightArm];
    [self defaultWeights];
    NSLog(@"The value of defaultFuel is %f", defaultFuelGal);
}

- (void) viewWillDisappear:(BOOL)animated {
    //NSLog(@"I'm in viewWillDisappear");
    [self shareData];
}

- (void) keypadSetup {
    DoneCancelNumberPadToolbar *fuelToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:fuelGalField];
    fuelToolbar.delegate = self;
    fuelGalField.inputAccessoryView = fuelToolbar;
    DoneCancelNumberPadToolbar *station1Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_station1WeightField];
    station1Toolbar.delegate = self;
    _station1WeightField.inputAccessoryView = station1Toolbar;
    DoneCancelNumberPadToolbar *station2Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_station2WeightField];
    station2Toolbar.delegate = self;
    _station2WeightField.inputAccessoryView = station2Toolbar;
    DoneCancelNumberPadToolbar *station3Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_station3WeightField];
    station3Toolbar.delegate = self;
    _station3WeightField.inputAccessoryView = station3Toolbar;
    DoneCancelNumberPadToolbar *station4Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_station4WeightField];
    station4Toolbar.delegate = self;
    _station4WeightField.inputAccessoryView = station4Toolbar;
    DoneCancelNumberPadToolbar *taxiFuelToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_taxiFuelGalField];
    taxiFuelToolbar.delegate = self;
    _taxiFuelGalField.inputAccessoryView = taxiFuelToolbar;
    DoneCancelNumberPadToolbar *flightFuelToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_flightFuelGalField];
    taxiFuelToolbar.delegate = self;
    _flightFuelGalField.inputAccessoryView = flightFuelToolbar;
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField {
    NSLog(@"Canceled: %@", [textField description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)fuelGalField:(UITextField *)sender {
    if (!fuelGal) {
        if ([sender.text  isEqual: @""] ){
            fuelGalField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        fuelGalField.text = [NSString stringWithFormat:@"%.1f", fuelGal];
    }
    fuelGal = [sender.text floatValue];

    fuelWeight = fuelGal * weightOfAvGas;
    fuelMoment = fuelWeight * fuelArm;
    fuelGalField.text = [NSString stringWithFormat:@"%.1f", fuelGal];
    fuelWeightField.text = [NSString stringWithFormat:@"%.1f", fuelWeight];
    fuelMomentField.text = [NSString stringWithFormat:@"%.1f", fuelMoment];
    [self summation];
}

- (IBAction)taxiFuelGalField:(UITextField *)sender {
    if (!_taxiFuelGal) {
        if ([sender.text  isEqual: @""] ){
            _taxiFuelGalField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _taxiFuelGalField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelGal];
    }
    _taxiFuelGal = [sender.text floatValue];
    _taxiFuelWeight = _taxiFuelGal * weightOfAvGas;
    _taxiFuelMoment = _taxiFuelWeight * fuelArm;
    _taxiFuelGalField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelGal];
    _taxiFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelWeight];
    _taxiFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelMoment];
    [self summation];
}

- (IBAction)flightFuelGalField:(UITextField *)sender {
    if (!_flightFuelGal) {
        if ([sender.text  isEqual: @""] ){
            _flightFuelGalField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _flightFuelGalField.text = [NSString stringWithFormat:@"%.1f", _flightFuelGal];
    }
    _flightFuelGal = [sender.text floatValue];
    _flightFuelWeight = _flightFuelGal * weightOfAvGas;
    _flightFuelMoment = _flightFuelWeight * fuelArm;
    _flightFuelGalField.text = [NSString stringWithFormat:@"%.1f", _flightFuelGal];
    _flightFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _flightFuelWeight];
    _flightFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _flightFuelMoment];
    [self summation];
}

- (IBAction)station1WeightField:(UITextField *)sender {
    if (!_station1Weight) {
        if ([sender.text  isEqual: @""] ){
            _station1WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _station1WeightField.text = [NSString stringWithFormat:@"%.1f", _station1Weight];
    }
    _station1Weight = [sender.text floatValue];
    _station1Moment = _station1Weight * station1Arm;
    _station1WeightField.text = [NSString stringWithFormat:@"%.1f", _station1Weight];
    _station1MomentField.text = [NSString stringWithFormat:@"%.1f", _station1Moment];
    [self summation];
}

- (IBAction)station2WeightField:(UITextField *)sender {
    if (!_station2Weight) {
        if ([sender.text  isEqual: @""] ){
            _station2WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _station2WeightField.text = [NSString stringWithFormat:@"%.1f", _station2Weight];
    }
    _station2Weight = [sender.text floatValue];
    _station2Moment = _station2Weight * station2Arm;
    _station2WeightField.text = [NSString stringWithFormat:@"%.1f", _station2Weight];
    _station2MomentField.text = [NSString stringWithFormat:@"%.1f", _station2Moment];
    [self summation];
}

- (IBAction)station3WeightField:(UITextField *)sender {
    if (!_station3Weight) {
        if ([sender.text  isEqual: @""] ){
            _station3WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _station3WeightField.text = [NSString stringWithFormat:@"%.1f", _station3Weight];
    }
    _station3Weight = [sender.text floatValue];
    _station3Moment = _station3Weight * station3Arm;
    _station3WeightField.text = [NSString stringWithFormat:@"%.1f", _station3Weight];
    _station3MomentField.text = [NSString stringWithFormat:@"%.1f", _station3Moment];
    [self summation];
}

- (IBAction)station4WeightField:(UITextField *)sender {
    if (!_station4Weight) {
        if ([sender.text  isEqual: @""] ){
            _station4WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _station4WeightField.text = [NSString stringWithFormat:@"%.1f", _station4Weight];
    }
    _station4Weight = [sender.text floatValue];
    _station4Moment = _station4Weight * station4Arm;
    _station4WeightField.text = [NSString stringWithFormat:@"%.1f", _station4Weight];
    _station4MomentField.text = [NSString stringWithFormat:@"%.1f", _station4Moment];
    [self summation];
}

- (void) summation
{
    _totalMoment = emptyWeightMoment + fuelMoment + _station1Moment + _station2Moment + _station3Moment + _station4Moment - _taxiFuelMoment;
    _totalWeight = emptyWeight + fuelWeight + _station1Weight + _station2Weight + _station3Weight + _station4Weight - _taxiFuelWeight;
    _totalARM = _totalMoment/_totalWeight;
    _totalMomentLabel.text = [NSString stringWithFormat:@"%.1f", _totalMoment];
    _totalWeightLabel.text = [NSString stringWithFormat:@"%.1f", _totalWeight];
    _totalArmField.text = [NSString stringWithFormat:@"%.1f In.", _totalARM];
    
    [self limitsCheck];
    [self maneuveringSpeed];
}

- (void) defaultWeights
{
    if (!fuelGal) {
        fuelGal = defaultFuelGal;
        fuelGalField.text = [NSString stringWithFormat:@"%.1f", fuelGal];
        fuelWeight = fuelGal * weightOfAvGas;
        fuelWeightField.text = [NSString stringWithFormat:@"%.1f", fuelWeight];
        fuelMoment = fuelWeight * fuelArm;
        fuelMomentField.text = [NSString stringWithFormat:@"%.1f", fuelMoment];
        NSLog(@"I'm in defaultWeights. FuelGal = %f, fuelWeight = %f, fuelArm = %f, fuelMoment = %f", fuelGal, fuelWeight, fuelArm, fuelMoment);
        
    }
    if (!_taxiFuelGal) {
        _taxiFuelGal = defaultTaxiFuelGal;
        _taxiFuelGalField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelGal];
        _taxiFuelWeight = _taxiFuelGal * weightOfAvGas;
        _taxiFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelWeight];
        _taxiFuelMoment = _taxiFuelWeight * fuelArm;
        _taxiFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelMoment];
    }
    if (!_flightFuelGal) {
        _flightFuelGal = defaultFlightFuelGal;
        _flightFuelGalField.text = [NSString stringWithFormat:@"%.1f", _flightFuelGal];
        _flightFuelWeight = _flightFuelGal * weightOfAvGas;
        _flightFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _flightFuelWeight];
        _flightFuelMoment = _flightFuelWeight * fuelArm;
        _flightFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _flightFuelMoment];
    }
    if (!_station3Weight) {
        _station3Weight = defaultStation3Weight;
        _station3WeightField.text = [NSString stringWithFormat:@"%.1f", _station3Weight];
        _station3Moment = _station3Weight * station3Arm;
        _station3MomentField.text = [NSString stringWithFormat:@"%.1f", _station3Moment];
    }
    if (!_station4Weight) {
        _station4Weight = defaultStation4Weight;
        _station4WeightField.text = [NSString stringWithFormat:@"%.1f", _station4Weight];
        _station4Moment = _station4Weight * station4Arm;
        _station4MomentField.text = [NSString stringWithFormat:@"%.1f", _station4Moment];
    }

    [self summation];
}

- (void) maneuveringSpeed {
    float va = mgva * sqrt(_totalWeight/maxGross);
    _vaSpeedLabel.text = [NSString stringWithFormat:@"Va = %.1f KIAS", va];
}

- (void) limitsCheck {
    bool weightUnderLimit, momentWithinLimits;
    
    if (_totalWeight <= maxGross) {
        _totalWeightLabel.textColor = [UIColor greenColor];
        weightUnderLimit = true;
    }
    else {
        _totalWeightLabel.textColor = [UIColor redColor];
        weightUnderLimit = false;
    }
    
    if ( _totalMoment <=  _totalWeight * (70500/1500) ) {
        _totalMomentLabel.textColor = [UIColor greenColor];
        momentWithinLimits = true;
    }
    else {
        _totalMomentLabel.textColor = [UIColor redColor];
        momentWithinLimits = false;
    }
    if ( weightUnderLimit == true & momentWithinLimits == true ) {
        _totalArmField.textColor = [UIColor greenColor];
    }
    else {
        _totalArmField.textColor = [UIColor redColor];
    }
}


- (void)getData {
    
    Singleton *data = [Singleton sharedInput];
    
    acDescription = data.acDescription;
    acID = data.acID;
    maxGross = data.maxGross;
    mgva = data.mgva;
    emptyWeight = data.emptyWeight;
    emptyWeightArm = data.emptyWeightArm;
    maxFuelGal = data.maxFuelGal;
    defaultFuelGal = data.defaultFuelGal;
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
}




- (void)shareData {
    
    Singleton *data = [Singleton sharedInput];
    
    data.fuelWeight = fuelWeight;
    data.fuelMoment = fuelMoment;
    data.station1Weight = _station1Weight;
    data.station1Moment = _station1Moment;
    data.station2Weight = _station2Weight;
    data.station2Moment = _station2Moment;
    data.station3Weight = _station3Weight;
    data.station3Moment = _station3Moment;
    data.station4Weight = _station4Weight;
    data.station4Moment = _station4Moment;
    data.taxiFuelWeight = _taxiFuelWeight;
    data.taxiFuelMoment = _taxiFuelMoment;
    data.totalMoment = _totalMoment;
    data.flightFuelWeight = _flightFuelWeight;
    data.flightFuelMoment = _flightFuelMoment;
    data.totalWeight = _totalWeight;
    data.totalARM = _totalARM;
    data.acList = _acList;
}

- (void) copyData
{
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSArray *mainBundleFileList = [NSArray alloc];
    NSError *error = nil;
    mainBundleFileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mainBundlePath error:&error];
    if(error)
    {
        NSLog(@"error getting contents of folder %@ - %@", mainBundlePath, [error localizedDescription]);
    }
    NSLog(@"The contents of array allFiles is %@", mainBundleFileList);
    
    NSMutableArray *defaultACList = [[NSMutableArray alloc] init];
    int fileCount = (int)[mainBundleFileList count];
    for( int i = 0 ; i < fileCount ; i++ ) {
        NSString *stringFromFileName = mainBundleFileList[i];
        
        if ([stringFromFileName containsString:@"acinfo"]) {
            NSLog(@"aircraft found: %@", stringFromFileName);
            [defaultACList addObject:stringFromFileName];
        }
    }
    
    //NSLog(@"the contents of defaultACList is %@", defaultACList);
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectoryPath = [pathsArray objectAtIndex:0];
    NSString *dataPath = [documentDirectoryPath stringByAppendingPathComponent:@"/ACData"];
    
    int count = (int)[defaultACList count];
    for ( int i = 0 ; i < count ; i++ )
    {
        NSString *destinationPath = [dataPath stringByAppendingPathComponent:defaultACList[i]];
        //NSLog(@"plist path %@",destinationPath);
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:defaultACList[i]];
        [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    }
    
    _acList = [[NSArray alloc] init];
    _acList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&error];
    NSLog(@"The contents of _acList is %@", _acList);
}


@end
