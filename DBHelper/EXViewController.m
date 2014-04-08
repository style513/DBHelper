//
//  EXViewController.m
//  DBHelper
//
//  Created by zhengyj on 14-4-4.
//  Copyright (c) 2014年 zhengyj. All rights reserved.
//
#import "EXDBHelper.h"
#import "EXDBBase.h"
#import "EXViewController.h"
#import "EXCarDB.h"
#import "EXCarModel.h"
#import "EXUser.h"
#import "EXDBCenter.h"

@interface EXViewController ()

@property (weak, nonatomic) EXDBHelper * dbHelper;
@property (weak, nonatomic) EXDBHelper * dbHelper2;

@end

@implementation EXViewController

@synthesize dbHelper = _dbHelper;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dbHelper = [EXDBCenter sharedInstance].dbHelper;
    self.dbHelper2 =  [EXDBCenter sharedInstance].dbHelper;
    
	NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [cachesDirectory stringByAppendingPathComponent:@"db2.sqlite"];
    NSLog(@"%@",dbPath);
//    [self.dbHelper openWithDBPath:dbPath];

    
    NSArray *users = [self.dbHelper getObjectWithClassName:@"EXUser" condition:nil];
    NSLog(@"---------------- %s %d -----------------",__FUNCTION__,__LINE__);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < users.count; i++) {
            EXUser *user = [users objectAtIndex:i];
//            user.name = [NSString stringWithFormat:@"user_%d",i];
            
            [self.dbHelper updateObject:user condition:[NSDictionary  dictionaryWithObject:user.userId forKey:@"userId"]];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 10000; i < 100000; i++) {
            EXUser *user = [[EXUser alloc] init];
            user.name = [NSString stringWithFormat:@"user_%d",i];
            user.userId = [NSString stringWithFormat:@"userID_%d",i];
            [self.dbHelper insertObject:user];
        }
    });
    
    [self.dbHelper deleteObject:@"EXUser" condition:[NSDictionary  dictionaryWithObject:@"9" forKey:@"userId"]];
    
    EXCarModel *car = [[EXCarModel alloc] init];
    car.uuid = @1;
    car.name = @"奥迪";
    [self.dbHelper insertObject:car];
    
    NSLog(@"%@",car);
     
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insert1Action:(id)sender {
    static int i = 1100;
    EXCarModel *car = [[EXCarModel alloc] init];
    car.uuid = [NSNumber numberWithInt:i];
    car.name = self.nameTextField.text;
    
    NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [cachesDirectory stringByAppendingPathComponent:@"db22.sqlite1"];
    NSLog(@"%@",dbPath);
//    [[EXDBCenter sharedInstance].dbHelper openWithDBPath:dbPath];
    [[EXDBCenter sharedInstance].dbHelper insertObject:car];
    
    i++;
}

- (IBAction)insertAction2:(id)sender {
    static int i = 1000;
    EXCarModel *car = [[EXCarModel alloc] init];
    car.uuid = [NSNumber numberWithInt:i];
    car.name = self.nameTextField.text;
    
    NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [cachesDirectory stringByAppendingPathComponent:@"yesdb.sqlite2"];
    NSLog(@"%@",dbPath);
    
    
    [self.dbHelper2 openWithDBPath:dbPath];
    [self.dbHelper2 insertObject:car];

    i++;
}
@end
