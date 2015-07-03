//
//  Singleton.h
//  WAB
//
//  Created by Robert Mahoney on 5/22/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

+(id) sharedInput;


@property NSArray * acList;

//Aircraft Properties
@property NSString * acDescription, *acID;
@property float mgva; //maneuvering speed (va) at max gross weight (mg)
@property float maxGross;
@property float emptyWeight, emptyWeightArm, emptyWeightMoment;
@property float maxFuelGal, defaultFuelGal, defaultTaxiFuelGal, defaultFlightFuelGal, fuelArm;
@property float defaultStation1Weight, station1Arm;
@property float defaultStation2Weight, station2Arm;
@property float defaultStation3Weight, station3Arm;
@property float defaultStation4Weight, station4arm;
@property NSString *station1Name;
@property NSString *station2Name;
@property NSString *station3Name;
@property NSString *station4Name;
@property NSArray *momentArray1, *momentArray2, *balanceArray;

//User Entered & Calculated Data
@property float emptyMoment;
@property float fuelGal, fuelWeight, fuelMoment;
@property float station1Weight, station1Moment;
@property float station2Weight, station2Moment;
@property float station3Weight, station3Moment;
@property float station4Weight, station4Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@end
