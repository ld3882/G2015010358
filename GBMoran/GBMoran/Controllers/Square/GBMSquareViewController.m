//
//  GBMSquareViewController.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMSquareViewController.h"
#import "GBMSquareRequest.h"
#import "GBMGlobal.h"
#import "GBMSquareCell.h"
#import "GBMPictureModel.h"

@interface GBMSquareViewController ()<GBMSquareRequestDelegate>

@end

@implementation GBMSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    [self.navigationController.navigationBar setAlpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
    label.text = @"附近1000米";
    label.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:label];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self getSquareNotes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showErrorMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)getSquareNotes
{
    
    GBMSquareRequest *request = [[GBMSquareRequest alloc] init];
    GBMUserModel *user = [GBMGlobal shareGlobal].user;
    
    [request sendSquareRequestWithUserid:user.user_id distance:@"1000" latitude:user.latitude longitude:user.longitude token:user.token delegate:self];
    
}

#pragma mark - GBMSquareRequestDelegate method

- (void)requestSuccess:(GBMSquareRequest *)request squareModelArray:(NSMutableArray *)modelarray
{
    self.squareModelArray = modelarray;
}

- (void)requestFailed:(GBMSquareRequest *)request error:(NSError *)error
{
    [self showErrorMessage:@"获取信息列表错误"];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.squareModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GBMSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"squarecell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[GBMSquareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"squarecell"];
    }
    GBMSquareModel *squareModel = self.squareModelArray[indexPath.row];
    cell.attrLabel.text = squareModel.addr;
    for (UIView *view in cell.imageScrollView.subviews) {
        [view removeFromSuperview];
    }
    int i=0;
    for (GBMPictureModel *picModel in squareModel.pictureArray) {
        NSURL *url = [NSURL URLWithString:picModel.pic_link];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*125, 0, 120, 70)];
        imageview.image = image;
        [cell.imageScrollView addSubview:imageview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0+i*125, 75, 120, 20)];
        label.text = picModel.title;
        label.textColor = [UIColor lightGrayColor];
        [cell.imageScrollView addSubview:label];
        i++;
    }
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
