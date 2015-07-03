//
//  AircraftMenuTableViewController.h
//  WAB
//
//  Created by Robert Mahoney on 6/3/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightsVC.h"
#import "Singleton.h"

@interface AircraftMenuTableViewController : UITableViewController

@property NSArray * acList;

//Aircraft Properties
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

/*
@property float fuelGal, fuelWeight, fuelMoment;

@property float station3Weight, station3Moment;
@property float station4Weight, station4Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;
*/

@end
