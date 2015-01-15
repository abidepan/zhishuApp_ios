//
//  ITLocation.m
//  testLocation
//
//  Created by fuyiming on 14/12/22.
//  Copyright (c) 2014年 unionpay. All rights reserved.
//

#import "ITLocation.h"

@implementation ITLocation

+(ITLocation*) instance{
    static dispatch_once_t itLocationPredicate;
    static ITLocation * itLocation;
    dispatch_once(&itLocationPredicate, ^{
        itLocation = [[ITLocation alloc] init];
    });
    return itLocation;
}

-(instancetype)init{

    self = [super init];
    if (self) {
        
        _locationManager =[[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        [self.locationManager startUpdatingLocation];
    }

    return  self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus---%u",status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didChangeAuthorizationStatus----%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    _currentLocation = newLocation.coordinate;
}

- (void)dealloc
{
    self.locationManager = nil;
}
@end
