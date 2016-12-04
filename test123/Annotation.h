//
//  Annotation.h
//  test123
//
//  Created by Shay Finkelstein on 12/3/16.
//  Copyright © 2016 Shay Finkelstein. All rights reserved.
//
@import MapKit;
#import <Foundation/Foundation.h>

@interface Annotation : NSObject<MKAnnotation>

@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * subtitle;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;

@end
