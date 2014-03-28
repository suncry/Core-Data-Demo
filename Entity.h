//
//  Entity.h
//  dataTest
//
//  Created by niko on 14-3-27.
//  Copyright (c) 2014年 Cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * name;

@end
