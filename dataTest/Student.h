//
//  Student.h
//  dataTest
//
//  Created by niko on 14-3-27.
//  Copyright (c) 2014年 Cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * title;

@end
