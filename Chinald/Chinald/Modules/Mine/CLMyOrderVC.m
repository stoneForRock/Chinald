//
//  CLMyOrderVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMyOrderVC.h"
#import "CLOrderCollectionViewCell.h"
#import "CLOrderDetailViewController.h"
@interface CLMyOrderVC ()

@end

@implementation CLMyOrderVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationCustomStyleWithColor:[UIColor whiteColor]];
    [self.navigationController setNavigationStyle:ZNTNavigationStyleCustom];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的订单";
    // Do any additional setup after loading the view.
}

#pragma mark =========== UICollectionViewDataSource ===========
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *orderCollectionViewCellString = @"orderCollectionViewCell";
    CLOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:orderCollectionViewCellString forIndexPath:indexPath];
    cell.orderCellClickBlock = ^(id orderInfo) {
      //跳转到订单详情页
        [self performSegueWithIdentifier:@"orderListToOrderDetailVC" sender:nil];
    };

    
    return cell;
}

#pragma mark =========== UIScrollViewDelegate ===========
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenFullWidth - 1, ScreenFullHeight - 108);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(0, 0.001f);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.000f;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0,0, 0, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
