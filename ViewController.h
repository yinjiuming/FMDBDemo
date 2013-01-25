//
//  ViewController.h
//  FMDBDemo
//
//  Created by baxiang on 13-1-25.
//  Copyright (c) 2013年 com.baxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController  <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UITextField *sex;
- (IBAction)editEnd:(id)sender;

- (IBAction)saveDate:(id)sender;

- (IBAction)queryDate:(id)sender;

- (IBAction)queryBycondition:(id)sender;

- (IBAction)deleteDate:(id)sender;
- (IBAction)upDate:(id)sender;

@end
