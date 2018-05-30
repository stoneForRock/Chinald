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
@property(nonatomic, strong)UIView *articleView;  //!<
@property (strong, nonatomic) IBOutlet UIButton *allOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *forPayOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *forSendOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *forGoodsButton;
@property (strong, nonatomic) IBOutlet UIButton *afterSalesButton;
@property (strong, nonatomic) IBOutlet UICollectionView *orderCollectionView;

@property(nonatomic, strong)UIButton *selectButton;  //!<
@property(nonatomic, strong)UIButton *nowButton;  //!<

@end

@implementation CLMyOrderVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationStyle:ZNTNavigationStyleCustom];
    [self.navigationController setNavigationCustomStyleWithColor:[UIColor whiteColor]];

//    _articleView.frame = CGRectMake(_selectButton.frame.origin.x + 5, _selectButton.frame.origin.y + _selectButton.frame.size.height - 1,_selectButton.frame.size.width - 10 , 2);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_orderType inSection:0];
    [self orderTypeButtonClick:_selectButton collectionScrollToIndexPath:indexPath];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的订单";
    // Do any additional setup after loading the view.
//    _articleView = [UIView alloc]initWithFrame:<#(CGRect)#>
    switch (_orderType) {
        case 0:
            _selectButton = _allOrderButton;
            break;
        case 1:
            _selectButton = _forPayOrderButton;
            break;
        case 2:
            _selectButton = _forSendOrderButton;
            break;
        case 3:
            _selectButton = _forGoodsButton;
            break;
        case 4:
            _selectButton = _afterSalesButton;
            break;
        default:
            break;
    }
    [self addArticleView];
}
-(void)addArticleView{
    _articleView = [[UIView alloc]init];
    _articleView.backgroundColor = [UIColor zntThemeTintColor];
    [self.view addSubview:_articleView];
}
- (IBAction)allOrderButtonClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self orderTypeButtonClick:sender collectionScrollToIndexPath:indexPath];}
- (IBAction)forPayOrderButtonClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self orderTypeButtonClick:sender collectionScrollToIndexPath:indexPath];
}
- (IBAction)forSendOrderButtonClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self orderTypeButtonClick:sender collectionScrollToIndexPath:indexPath];
    
}
- (IBAction)forGoodsButtonClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self orderTypeButtonClick:sender collectionScrollToIndexPath:indexPath];
}
- (IBAction)afterSalesButtonClick:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    [self orderTypeButtonClick:sender collectionScrollToIndexPath:indexPath];
    
}
-(void)orderTypeButtonClick:(id)sender collectionScrollToIndexPath:(NSIndexPath *)indexPath{
    UIButton *button = (UIButton *)sender;
    [self orderTypeButtonChange:button];

    [_orderCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}
-(void)orderTypeButtonChange:(UIButton *)button{
    [_selectButton setTitleColor:Color7 forState:0];
    
    [button setTitleColor:[UIColor zntThemeTintColor] forState:0];
    _selectButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        _articleView.frame = CGRectMake(button.frame.origin.x + 5, button.frame.origin.y + button.frame.size.height,button.frame.size.width - 10 , 2);
        
    }];
}
#pragma mark =========== UICollectionViewDataSource ===========
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 5;
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

    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger indexRow = offsetX / ScreenFullWidth;
    if (indexRow == 0) {
        UIButton *button = [self.view viewWithTag:100];
        [self orderTypeButtonChange:button];
    }
    if (indexRow == 1) {
        UIButton *button = [self.view viewWithTag:101];
        [self orderTypeButtonChange:button];
    }
    if (indexRow == 2) {
        UIButton *button = [self.view viewWithTag:102];
        [self orderTypeButtonChange:button];
    }
    if (indexRow == 3) {
        UIButton *button = [self.view viewWithTag:103];
        [self orderTypeButtonChange:button];
    }
    if (indexRow == 4) {
        UIButton *button = [self.view viewWithTag:104];
        [self orderTypeButtonChange:button];
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenFullWidth, ScreenFullHeight - 108);
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
