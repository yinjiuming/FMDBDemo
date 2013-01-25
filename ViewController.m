//
//  ViewController.m
//  FMDBDemo
//
//  Created by baxiang on 13-1-25.
//  Copyright (c) 2013年 com.baxiang. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
  //保存数据
- (IBAction)editEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)saveDate:(id)sender {

    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
         
          NSString *dbpath  =[path stringByAppendingPathComponent:@"user.db"];
          NSLog(@"数据库路径地址 %@",dbpath);
           FMDatabase *database=[FMDatabase databaseWithPath:dbpath];
      if (![database open]) {
          NSLog(@"数据库打开失败");
       } 
    
      [database  executeUpdate:@"create table user (name text,sex text,age integer)"];
      
      BOOL insert  =[database executeUpdate:@"insert into user values (?,?,?)",_name.text,_sex.text,_age.text];
    if (insert) {
        UIAlertView *alter =[[UIAlertView alloc] initWithTitle:@"提示" message:@"数据保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    else{
        NSLog(@"数据保存失败");
    }
    [database close];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder];
    [_sex resignFirstResponder];
    [_age resignFirstResponder];

}



//数据查询
- (IBAction)queryDate:(id)sender {
    
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
   NSString *dbpath =[path stringByAppendingPathComponent:@"user.db"];
       FMDatabase *database=[FMDatabase databaseWithPath:dbpath];
    if (![database open]) {
        NSLog(@"数据库打开失败");
    }
         FMResultSet *result =[database executeQuery:@"select * from user"];
    while ([result next]) {
            NSString *name =[result stringForColumn:@"name"];
            NSLog(@"用户姓名%@",name);
            NSString  *sex=[result stringForColumn:@"sex"];
            NSLog(@"用户性别%@",sex);
             int age =[result intForColumn:@"age"];
             NSLog(@"用户年龄%d",age);
    }
}


   //根据条件查询
- (IBAction)queryBycondition:(id)sender {
           
    
    NSString *documentpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
    NSString *dbpath=[documentpath stringByAppendingPathComponent:@"user.db"];
    
    FMDatabase *userdata=[FMDatabase databaseWithPath:dbpath];
    if (![userdata open]) {
        NSLog(@"数据库打开失败");
    }
               
     FMResultSet *result=[ userdata executeQuery:@"select name from user where age = ? ", [NSNumber numberWithInt:23]];
    while ([result next]) {
       
        NSLog(@"查询结果%@", [result stringForColumn:@"name"] );
    }
        
    
}
// 删除数据
- (IBAction)deleteDate:(id)sender {
    
    NSString *documentpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
    NSString *dbpath=[documentpath stringByAppendingPathComponent:@"user.db"];
    
    FMDatabase *userdata=[FMDatabase databaseWithPath:dbpath];
    if (![userdata open]) {
        NSLog(@"数据库打开失败");
    }
    //NSNumber *agenumber =[NSNumber numberWithInt:23];
    BOOL update = [userdata executeUpdate:@"delete from user  where name = ?",@""];
    if(update){
        NSLog(@"数据删除成功");
    }else{
        NSLog(@"数据删除失败");
    }
}


- (IBAction)upDate:(id)sender {
    
    //获取数据更新
    NSString *documentpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
       NSString *dbpath=[documentpath stringByAppendingPathComponent:@"user.db"];
    
        FMDatabase *userdata=[FMDatabase databaseWithPath:dbpath];
    if (![userdata open]) {
        NSLog(@"数据库打开失败");
    }
       //NSNumber *agenumber =[NSNumber numberWithInt:23];
       BOOL update = [userdata executeUpdate:@"update user set name = ? where age = ?",@"bx",[NSNumber numberWithInt:24]];
            if(update){
                NSLog(@"数据修改成功");
            }else{
                NSLog(@"数据修改失败");            }

}
@end
