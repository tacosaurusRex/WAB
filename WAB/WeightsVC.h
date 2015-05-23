//
//  WeightsVC.h
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneCancelNumberPadToolbar.h"
#import "UserInput.h"

@class MomentEnvelopeVC;
@class  MomentEnvelopeView;

@interface WeightsVC : UIViewController <DoneCancelNumberPadToolbarDelegate>

#define emptyWeight 1564.0
#define emptyWeightArm 40.9
#define emptyWeightMoment 62366.72
#define defaultTaxiFuelGallons 1
#define weightOfFuel 6.02
#define fuelArm 46.0
#define frontSeatArm 37.0
#define rearSeatArm 73.0
#define bag1Arm 95.0
#define bag2Arm 123.0

@property NSInteger test;
@property NSString* testString;

@property (weak, nonatomic) IBOutlet UITextField *eWeightField;
- (IBAction)fuelGalField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *fuelGalField;
@property (weak, nonatomic) IBOutlet UITextField *fuelWeightField;
- (IBAction)frontSeatsWeightField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *frontSeatsWeightField;
- (IBAction)rearSeatsWeightField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *rearSeatsWeightField;
- (IBAction)bag1WeightField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *bag1WeightField;
- (IBAction)bag2WeightField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *bag2WeightField;
- (IBAction)taxiFuelGalField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelGalField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelWeightField;

@property (weak, nonatomic) IBOutlet UITextField *eWeightArmField;
@property (weak, nonatomic) IBOutlet UITextField *fuelArmField;
@property (weak, nonatomic) IBOutlet UITextField *frontSeatArmField;
@property (weak, nonatomic) IBOutlet UITextField *rearSeatArmField;
@property (weak, nonatomic) IBOutlet UITextField *bag1ArmField;
@property (weak, nonatomic) IBOutlet UITextField *bag2ArmField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelArmField;

@property (weak, nonatomic) IBOutlet UITextField *eWeightMomentField;
@property (weak, nonatomic) IBOutlet UITextField *fuelMomentField;
@property (weak, nonatomic) IBOutlet UITextField *frontSeatMomentField;
@property (weak, nonatomic) IBOutlet UITextField *rearSeatMomentField;
@property (weak, nonatomic) IBOutlet UITextField *bag1MomentField;
@property (weak, nonatomic) IBOutlet UITextField *bag2MomentField;
@property (weak, nonatomic) IBOutlet UITextField *taxiFuelMomentField;

@property (weak, nonatomic) IBOutlet UILabel *totalMomentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWeightLabel;
@property (weak, nonatomic) IBOutlet UITextField *totalArmField;

@property float fuelGal, fuelWeight, fuelMoment;
@property float frontSeatWeight, frontSeatMoment;
@property float rearSeatWeight, rearSeatMoment;
@property float bag1Weight, bag1Moment;
@property float bag2Weight, bag2Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float totalMoment, totalWeight, totalARM;

- (IBAction)doneButton:(UIButton *)sender;

@end

