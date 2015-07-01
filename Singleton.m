//
//  Singleton.m
//  WAB
//
//  Created by Robert Mahoney on 5/22/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

@synthesize fuelWeight;

static Singleton *sharedData = nil;

#pragma mark Singleton Methods

+ (id)sharedInput {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    return sharedData;
}

- (id)init {
    
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    //Should not be called; here for reference only.
}

@end
