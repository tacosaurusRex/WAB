//
//  WeightsVC.h
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneCancelNumberPadToolbar.h"
#import "Singleton.h"

@class MomentEnvelopeVC;
@class  MomentEnvelopeView;

@interface WeightsVC : UIViewController <DoneCancelNumberPadToolbarDelegate>

#define weightOfAvGas 6.02

/*
#define mgva 97.0
#define maxGross 2300.0
#define emptyWeight 1564.0
#define emptyWeightArm 40.9
#define emptyWeightMoment 62366.72
#define defaultFuelGallons 40
#define defaultTaxiFuelGallons 1
#define defaultFlightFuelGallons 5
#define defaultstation3Weight 25
#define defaultstation4Weight 5
#define weightOfFuel 6.02
#define fuelArm 46.0
#define station1Arm 37.0
#define station2Arm 73.0
#define station3Arm 95.0
#define station4Arm 123.0
*/

- (IBAction)fuelGalField:(UITextField *)sender;
- (IBAction)station1WeightField:(UITextField *)sender;
- (IBAction)station2WeightField:(UITextField *)sender;
- (IBAction)station3WeightField:(UITextField *)sender;
- (IBAction)station4WeightField:(UITextField *)sender;
- (IBAction)taxiFuelGalField:(UITextField *)sender;
- (IBAction)flightFuelGalField:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UITextField *eWeightField;
@property (weak, nonatomic) IBOutlet UITextField *fuelGalField;
@property (weak, nonatomic) IBOutlet UITextField *fuelWeightField;
@property (weak, nonatomic) IBOutlet UITextField *station1WeightField;
@property (weak, nonatomic) IBOutlet UITextField *station2WeightField;
@property (weak, nonatomic) IBOutlet UITextField *station3WeightField;
@property (weak, nonatomic) IBOutlet UITextField *station4WeightField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelGalField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelWeightField;
@property (weak, nonatomic) IBOutlet UITextField *flightFuelGalField;
@property (weak, nonatomic) IBOutlet UITextField *flightFuelWeightField;

@property (weak, nonatomic) IBOutlet UITextField *eWeightArmField;
@property (weak, nonatomic) IBOutlet UITextField *fuelArmField;
@property (weak, nonatomic) IBOutlet UITextField *station1ArmField;
@property (weak, nonatomic) IBOutlet UITextField *station2ArmField;
@property (weak, nonatomic) IBOutlet UITextField *station3ArmField;
@property (weak, nonatomic) IBOutlet UITextField *station4ArmField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelArmField;

@property (weak, nonatomic) IBOutlet UITextField *eWeightMomentField;
@property (weak, nonatomic) IBOutlet UITextField *fuelMomentField;
@property (weak, nonatomic) IBOutlet UITextField *station1MomentField;
@property (weak, nonatomic) IBOutlet UITextField *station2MomentField;
@property (weak, nonatomic) IBOutlet UITextField *station3MomentField;
@property (weak, nonatomic) IBOutlet UITextField *station4MomentField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelMomentField;
@property (weak, nonatomic) IBOutlet UITextField *flightFuelMomentField;

@property (weak, nonatomic) IBOutlet UILabel *totalMomentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWeightLabel;
@property (weak, nonatomic) IBOutlet UITextField *totalArmField;
@property (weak, nonatomic) IBOutlet UILabel *vaSpeedLabel;

@property float fuelGal, fuelWeight, fuelMoment;
@property float station1Weight, station1Moment;
@property float station2Weight, station2Moment;
@property float station3Weight, station3Moment;
@property float station4Weight, station4Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@property NSArray *acList;
@property NSString *acDescription, *acID;
@property float maxGross;
@property float mgva; //maneuvering speed (va) at max gross weight (mg)
@property float emptyWeight;
@property float emptyWeightArm;
@property float emptyWeightMoment;
@property float maxFuelGal;
@property float defaultFuelGal;
@property float defaultTaxiFuelGal;
@property float defaultFlightFuelGal;
@property float fuelArm;
@property float defaultStation1Weight;
@property float defaultStation2Weight;
@property float defaultStation3Weight;
@property float defaultStation4Weight;
@property float station1Arm;
@property float station2Arm;
@property float station3Arm;
@property float station4Arm;
@property NSString *station1Name;
@property NSString *station2Name;
@property NSString *station3Name;
@property NSString *station4Name;
@property NSArray * momentArray1, *momentArray2, *balanceArray;

@end

