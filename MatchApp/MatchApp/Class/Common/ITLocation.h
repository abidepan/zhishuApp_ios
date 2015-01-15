//
//  ITLocation.h
//  testLocation
//
//  Created by fuyiming on 14/12/22.
//  Copyright (c) 2014年 unionpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h> 

@interface ITLocation : NSObject<CLLocationManagerDelegate>

@property (nonatomic,retain)CLLocationManager* locationManager;


@property (nonatomic,assign) CLLocationCoordinate2D currentLocation;
+(ITLocation*) instance;

@end
