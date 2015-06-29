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
    //NSArray *normalEnvelope;
    
}

@end

@implementation WeightsVC

//float utilityEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 70.92855, 2000.0, 81.1, 2000.0, 60.75, 1500.0};
//float normalEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 88.5, 2300.0, 109.0, 2300.0, 70.5, 1500.0};

- (void) viewDidLoad {
    _eWeightField.text = [NSString stringWithFormat:@"%.1f", emptyWeight];
    _eWeightArmField.text = [NSString stringWithFormat:@"%.1f", emptyWeightArm];
    _eWeightMomentField.text = [NSString stringWithFormat:@"%.1f", emptyWeightMoment];
    _totalMomentLabel.text = [NSString stringWithFormat:@"%.1f", emptyWeightMoment];
    _totalWeightLabel.text = [NSString stringWithFormat:@"%.1f", emptyWeight];
    _totalArmField.text = [NSString stringWithFormat:@"%.1f", emptyWeightArm];
    //NSArray *normalEnvelope = [[NSArray alloc] initWithObjects:@"52.25", @"1500.00", nil];
    [self defaultWeights];
    [super viewDidLoad];
    [self keypadSetup];
}


- (void) viewWillDisappear:(BOOL)animated {
    //NSLog(@"I'm in viewWillDisappear");
    [self shareData];
}

- (void) keypadSetup {
    DoneCancelNumberPadToolbar *fuelToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_fuelGalField];
    fuelToolbar.delegate = self;
    _fuelGalField.inputAccessoryView = fuelToolbar;
    DoneCancelNumberPadToolbar *frontSeatToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_frontSeatsWeightField];
    frontSeatToolbar.delegate = self;
    _frontSeatsWeightField.inputAccessoryView = frontSeatToolbar;
    DoneCancelNumberPadToolbar *rearSeatToolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_rearSeatsWeightField];
    rearSeatToolbar.delegate = self;
    _rearSeatsWeightField.inputAccessoryView = rearSeatToolbar;
    DoneCancelNumberPadToolbar *bag1Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_bag1WeightField];
    bag1Toolbar.delegate = self;
    _bag1WeightField.inputAccessoryView = bag1Toolbar;
    DoneCancelNumberPadToolbar *bag2Toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:_bag2WeightField];
    bag2Toolbar.delegate = self;
    _bag2WeightField.inputAccessoryView = bag2Toolbar;
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
    if (!_fuelGal) {
        if ([sender.text  isEqual: @""] ){
            _fuelGalField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _fuelGalField.text = [NSString stringWithFormat:@"%.1f", _fuelGal];
    }
    _fuelGal = [sender.text floatValue];

    _fuelWeight = _fuelGal * weightOfFuel;
    _fuelMoment = _fuelWeight * fuelArm;
    _fuelGalField.text = [NSString stringWithFormat:@"%.1f", _fuelGal];
    _fuelWeightField.text = [NSString stringWithFormat:@"%.1f", _fuelWeight];
    _fuelMomentField.text = [NSString stringWithFormat:@"%.1f", _fuelMoment];
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
    _taxiFuelWeight = _taxiFuelGal * weightOfFuel;
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
    _flightFuelWeight = _flightFuelGal * weightOfFuel;
    _flightFuelMoment = _flightFuelWeight * fuelArm;
    _flightFuelGalField.text = [NSString stringWithFormat:@"%.1f", _flightFuelGal];
    _flightFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _flightFuelWeight];
    _flightFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _flightFuelMoment];
    [self summation];
}

- (IBAction)frontSeatsWeightField:(UITextField *)sender {
    if (!_frontSeatWeight) {
        if ([sender.text  isEqual: @""] ){
            _frontSeatsWeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _frontSeatsWeightField.text = [NSString stringWithFormat:@"%.1f", _frontSeatWeight];
    }
    _frontSeatWeight = [sender.text floatValue];
    _frontSeatMoment = _frontSeatWeight * frontSeatArm;
    _frontSeatsWeightField.text = [NSString stringWithFormat:@"%.1f", _frontSeatWeight];
    _frontSeatMomentField.text = [NSString stringWithFormat:@"%.1f", _frontSeatMoment];
    [self summation];
}

- (IBAction)rearSeatsWeightField:(UITextField *)sender {
    if (!_rearSeatWeight) {
        if ([sender.text  isEqual: @""] ){
            _rearSeatsWeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _rearSeatsWeightField.text = [NSString stringWithFormat:@"%.1f", _rearSeatWeight];
    }
    _rearSeatWeight = [sender.text floatValue];
    _rearSeatMoment = _rearSeatWeight * rearSeatArm;
    _rearSeatsWeightField.text = [NSString stringWithFormat:@"%.1f", _rearSeatWeight];
    _rearSeatMomentField.text = [NSString stringWithFormat:@"%.1f", _rearSeatMoment];
    [self summation];
}

- (IBAction)bag1WeightField:(UITextField *)sender {
    if (!_bag1Weight) {
        if ([sender.text  isEqual: @""] ){
            _bag1WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _bag1WeightField.text = [NSString stringWithFormat:@"%.1f", _bag1Weight];
    }
    _bag1Weight = [sender.text floatValue];
    _bag1Moment = _bag1Weight * bag1Arm;
    _bag1WeightField.text = [NSString stringWithFormat:@"%.1f", _bag1Weight];
    _bag1MomentField.text = [NSString stringWithFormat:@"%.1f", _bag1Moment];
    [self summation];
}

- (IBAction)bag2WeightField:(UITextField *)sender {
    if (!_bag2Weight) {
        if ([sender.text  isEqual: @""] ){
            _bag2WeightField.text = [NSString stringWithFormat:@"0.0"];
        }
    }
    if ([sender.text  isEqual: @""]) {
        _bag2WeightField.text = [NSString stringWithFormat:@"%.1f", _bag2Weight];
    }
    _bag2Weight = [sender.text floatValue];
    _bag2Moment = _bag2Weight * bag2Arm;
    _bag2WeightField.text = [NSString stringWithFormat:@"%.1f", _bag2Weight];
    _bag2MomentField.text = [NSString stringWithFormat:@"%.1f", _bag2Moment];
    [self summation];
}

- (void) summation
{
    _totalMoment = emptyWeightMoment + _fuelMoment + _frontSeatMoment + _rearSeatMoment + _bag1Moment + _bag2Moment - _taxiFuelMoment;
    _totalWeight = emptyWeight + _fuelWeight + _frontSeatWeight + _rearSeatWeight + _bag1Weight + _bag2Weight - _taxiFuelWeight;
    _totalARM = _totalMoment/_totalWeight;
    _totalMomentLabel.text = [NSString stringWithFormat:@"%.1f", _totalMoment];
    _totalWeightLabel.text = [NSString stringWithFormat:@"%.1f", _totalWeight];
    _totalArmField.text = [NSString stringWithFormat:@"%.1f In.", _totalARM];
    
    [self limitsCheck];
    [self maneuveringSpeed];
}

- (void) defaultWeights
{
    if (!_taxiFuelGal) {
        _fuelGal = defaultFuelGallons;
        _fuelGalField.text = [NSString stringWithFormat:@"%.1f", _fuelGal];
        _fuelWeight = _fuelGal * weightOfFuel;
        _fuelWeightField.text = [NSString stringWithFormat:@"%.1f", _fuelWeight];
        _fuelMoment = _fuelWeight * fuelArm;
        _fuelMomentField.text = [NSString stringWithFormat:@"%.1f", _fuelMoment];
        
    }
    if (!_taxiFuelGal) {
        _taxiFuelGal = defaultTaxiFuelGallons;
        _taxiFuelGalField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelGal];
        _taxiFuelWeight = _taxiFuelGal * weightOfFuel;
        _taxiFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelWeight];
        _taxiFuelMoment = _taxiFuelWeight * fuelArm;
        _taxiFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _taxiFuelMoment];
    }
    if (!_flightFuelGal) {
        _flightFuelGal = defaultFlightFuelGallons;
        _flightFuelGalField.text = [NSString stringWithFormat:@"%.1f", _flightFuelGal];
        _flightFuelWeight = _flightFuelGal * weightOfFuel;
        _flightFuelWeightField.text = [NSString stringWithFormat:@"%.1f", _flightFuelWeight];
        _flightFuelMoment = _flightFuelWeight * fuelArm;
        _flightFuelMomentField.text = [NSString stringWithFormat:@"%.1f", _flightFuelMoment];
    }
    if (!_bag1Weight) {
        _bag1Weight = defaultbag1Weight;
        _bag1WeightField.text = [NSString stringWithFormat:@"%.1f", _bag1Weight];
        _bag1Moment = _bag1Weight * bag1Arm;
        _bag1MomentField.text = [NSString stringWithFormat:@"%.1f", _bag1Moment];
    }
    if (!_bag2Weight) {
        _bag2Weight = defaultbag2Weight;
        _bag2WeightField.text = [NSString stringWithFormat:@"%.1f", _bag2Weight];
        _bag2Moment = _bag2Weight * bag2Arm;
        _bag2MomentField.text = [NSString stringWithFormat:@"%.1f", _bag2Moment];
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

- (void)shareData {
    
    Singleton *data = [Singleton sharedInput];
    
    data.fuelWeight = _fuelWeight;
    data.fuelMoment = _fuelMoment;
    data.frontSeatWeight = _frontSeatWeight;
    data.frontSeatMoment = _frontSeatMoment;
    data.rearSeatWeight = _rearSeatWeight;
    data.rearSeatMoment = _rearSeatMoment;
    data.bag1Weight = _bag1Weight;
    data.bag1Moment = _bag1Moment;
    data.bag2Weight = _bag2Weight;
    data.bag2Moment = _bag2Moment;
    data.taxiFuelWeight = _taxiFuelWeight;
    data.taxiFuelMoment = _taxiFuelMoment;
    data.totalMoment = _totalMoment;
    data.flightFuelWeight = _flightFuelWeight;
    data.flightFuelMoment = _flightFuelMoment;
    data.totalWeight = _totalWeight;
    data.totalARM = _totalARM;
}

@end
