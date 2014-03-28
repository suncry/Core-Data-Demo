//
//  CyViewController.h
//  dataTest
//
//  Created by niko on 14-3-27.
//  Copyright (c) 2014年 Cy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CyAppDelegate.h"

@interface CyViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *titleTextField;
@property (retain, nonatomic) IBOutlet UITextField *contentTextField;
@property (strong,nonatomic) CyAppDelegate *myDelegate;
@property (strong,nonatomic) NSMutableArray *entries;

//单击按钮后执行数据保存操作
- (IBAction)addToDB:(id)sender;

//单击按钮后执行查询操作
- (IBAction)queryFromDB:(id)sender;

@end
