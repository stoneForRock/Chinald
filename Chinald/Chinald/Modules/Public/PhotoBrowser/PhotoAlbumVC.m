//
//  PhotoAlbumVC.m
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//

#import "PhotoAlbumVC.h"
#import "PhotoAlbumSelectorVC.h"
@interface PhotoAlbumVC () <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *_tableView;

}
@property (nonatomic, strong) NSArray<PHAssetCollection *> *collections;
@property (nonatomic, strong) NSArray<NSArray<PHAsset *> *> *results;
@end

@implementation PhotoAlbumVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self checkAuthorization];
}

#pragma mark - 初始化

- (void)initView
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
}

- (void)initData
{
    NSMutableArray<PHAssetCollection *> *list1 = [NSMutableArray array];
    //相机胶卷
    [list1 addObjectsFromArray:[self getList:PHAssetCollectionTypeSmartAlbum subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary]];
    //用户相册
    [list1 addObjectsFromArray:[self getList:PHAssetCollectionTypeAlbum subType:PHAssetCollectionSubtypeAlbumRegular]];
    
    NSMutableArray<NSArray<PHAsset *> *> *list2 = [NSMutableArray array];
    for (PHAssetCollection *collection in list1)
    {
        [list2 addObject:[self getResult:collection]];
    }
    
    //过滤掉空相册
    NSInteger i = 0;
    while (i < list2.count)
    {
        if (list2[i].count <= 0)
        {
            [list1 removeObjectAtIndex:i];
            [list2 removeObjectAtIndex:i];
        }
        else
        {
            i++;
        }
    }
    
    self.collections = [NSArray arrayWithArray:list1];
    self.results = [NSArray arrayWithArray:list2];
    
    [_tableView reloadData];
}

- (void)checkAuthorization
{
    switch ([PHPhotoLibrary authorizationStatus])
    {
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(status == PHAuthorizationStatusAuthorized)
                    {
                        [self initData];
                    }
                    else
                    {
                        //showPromptView(@"请在手机设置中打开照片权限");
                    }
                });
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            [self initData];
            break;
        }
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
        {
            //showPromptView(@"请在手机设置中打开照片权限");
            break;
        }
    }
}

#pragma mark - 外部静态方法

//弹出相册
+ (void)showFromViewController:(UIViewController *)controller maxCount:(int)maxCount completion:(PhotoSelectCompletion)completion
{
    PhotoAlbumVC *vc = [[UIStoryboard storyboardWithName:@"PhotoBrowser" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoAlbumVC"];
    vc.maxCount = maxCount;
    vc.completion = completion;
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:vc];
    [controller presentViewController:nvg animated:YES completion:nil];
}

#pragma mark - 控件事件

- (void)close:(id)sender
{
    if (self.navigationController)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 内部方法

- (NSArray<PHAssetCollection *> *)getList:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType
{
    NSMutableArray<PHAssetCollection *> *list = [NSMutableArray array];
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:subType options:nil];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [list addObject:obj];
    }];
    return list;
}

- (NSArray<PHAsset *> *)getResult:(PHAssetCollection *)collection
{
    NSMutableArray<PHAsset *> *list = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:option];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((PHAsset *)obj).mediaType == PHAssetMediaTypeImage)
        {
            [list addObject:obj];
        }
    }];
    return list;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _collections.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PhotoAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoAlbumCell" forIndexPath:indexPath];
    
    __block UIImage *image = nil;
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.networkAccessAllowed = YES;
    option.synchronous = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    [[PHImageManager defaultManager] requestImageForAsset:_results[indexPath.row].lastObject targetSize:CGSizeMake(120, 120) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    
    [cell setTitle:_collections[indexPath.row].localizedTitle desc:[NSString stringWithFormat:@"(%lu)", (unsigned long)_results[indexPath.row].count] image:image];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoAlbumSelectorVC *vc = [[UIStoryboard storyboardWithName:@"PhotoBrowser" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoAlbumSelectorVC"];
    vc.maxCount = _maxCount;
    vc.completion = _completion;
    vc.title = _collections[indexPath.row].localizedTitle;
    vc.result = _results[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
@implementation PhotoAlbumCell

- (void)setTitle:(NSString *)title desc:(NSString *)desc image:(UIImage *)image
{
    _titleLabel.text = title;
    _descLabel.text = desc;
    _iconImageView.image = image;
}

@end
