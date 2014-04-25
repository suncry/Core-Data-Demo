//
//  CyViewController.m
//  dataTest
//
//  Created by niko on 14-3-27.
//  Copyright (c) 2014年 Cy. All rights reserved.
//

#import "CyViewController.h"
#import "Entity.h"
#import "Student.h"
@interface CyViewController ()

@end

@implementation CyViewController
@synthesize titleTextField;
@synthesize contentTextField;
@synthesize myDelegate = _myDelegate;
@synthesize entries = _entries;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (CyAppDelegate *)[[UIApplication sharedApplication] delegate];


}
- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setContentTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
//单击按钮后执行数据保存操作
- (IBAction)addToDB:(id)sender {
    
    //让CoreData在上下文中创建一个新对象(托管对象)
    Student *entry = (Student *)[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.myDelegate.managedObjectContext];
    
    [entry setTitle:self.titleTextField.text];
    [entry setName:self.contentTextField.text];
    
    NSError *error;
    
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];

    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
    }
}

//单击按钮后执行查询操作
- (IBAction)queryFromDB:(id)sender {
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student"inManagedObjectContext:self.myDelegate.managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
#pragma mark --条件查询--
#pragma mark --1、>,<,>=,<=,= 比较运算符--
    // NSPredicate * qcondition= [NSPredicate predicateWithFormat:@"salary >= 10000"];
#pragma mark --2、字符串操作(包含)：BEGINSWITH、ENDSWITH、CONTAINS--
    //@"employee.name BEGINSWITH[cd] '李'" //姓李的员工
    //@"employee.name ENDSWITH[c] '梦'"   //以梦结束的员工
    //@"employee.name CONTAINS[d] '宗'"   //包含有"宗"字的员工
    //注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
#pragma mark --3、范围：IN,BWTEEN--
    //@"salary BWTEEN {5000,10000}"
    //@"em_dept IN '开发'"
#pragma mark --4、自身:SELF，这个只针对字符数组起作用--
    //NSArray * test = =[NSArray arrayWithObjects: @"guangzhou", @"beijing", @"shanghai", nil];
    //@"SELF='beijing'"
#pragma mark --5、通配符：LIKE--
    //LIKE 使用?表示一个字符，*表示多个字符，也可以与c、d 连用。如：
    //@"car.name LIKE '?he?'" //四个字符中，中间为he
    //@"car.name LIKE '*jp'"  //以jp结束
#pragma mark --6、正则表达式：MATCHES--
    //NSString *regex = @"^E.+e$";//以E 开头，以e 结尾的字符。
    //NSPredicate *pre= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //if([pre evaluateWithObject: @"Employee"]){
    //    NSLog(@"matches YES");
    //}else{
    //    NSLog(@"matches NO");
    //}
#pragma mark --7、逻辑运算符：AND、OR、NOT--
    //@"employee.name = 'john' AND employee.age = 28"
#pragma mark --8、占位符--
//    NSPredicate *preTemplate = [NSPredicate predicateWithFormat:@"name==$NAME"];
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
//                       @"Name1", @"NAME",nil];
//    NSPredicate *pre=[preTemplate predicateWithSubstitutionVariables: dic];
//    占位符就是字典对象里的key，因此你可以有多个占位符，只要key 不一样就可以了。
//    
//    query by page
//    [fetchRequest setFetchLimit:20];
//    [fetchRequest setFetchOffset: page * 20];
//    
//    query by date:
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [dateFormatter dateFromString:@"2013-06-19 18:10:00"];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date<%@)",date];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title = %@)",@"123"];
    [request setPredicate:predicate];
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"ascending:YES];
    //排序条件 数组，可以多个条件排序
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    self.entries = mutableFetchResult;
    NSLog(@"The count of entry:%i",[self.entries count]);
    for(Student *entry in self.entries)
    {
        NSLog(@"Title:%@---name:%@",entry.title,entry.name);
    }
}

//更新操作
-(void)updateEntry:(Student *)entry
{
    [entry setTitle:self.titleTextField.text];
    [entry setName:self.contentTextField.text];
    
    NSError *error;
    BOOL isUpdateSuccess = [self.myDelegate.managedObjectContext save:&error ];
    if (!isUpdateSuccess) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
}

//删除操作
-(void)deleteEntry:(Student *)entry
{
    [self.myDelegate.managedObjectContext deleteObject:entry];
    [self.entries removeObject:entry];
    
    NSError *error;
    if (![self.myDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
}

// 删除操作---给力版本
- (void) deleteAllObjects: (NSString *)entityDescription
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.myDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [self.myDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
    	[self.myDelegate.managedObjectContext deleteObject:managedObject];
    	NSLog(@"%@ object deleted",entityDescription);
    }
    if (![self.myDelegate.managedObjectContext save:&error]) {
    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
}



@end
