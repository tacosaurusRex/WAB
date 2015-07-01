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

@property NSDictionary *aircraftInfo, *acID;
@property NSArray * acList;
@property NSString * acDescription;
@property float emptyWeight, emptyMoment;
@property float fuelGal, fuelWeight, fuelMoment;
@property float frontSeatWeight, frontSeatMoment;
@property float rearSeatWeight, rearSeatMoment;
@property float bag1Weight, bag1Moment;
@property float bag2Weight, bag2Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@end
