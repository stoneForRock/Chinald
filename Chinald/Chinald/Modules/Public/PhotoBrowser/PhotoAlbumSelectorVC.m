//
//  PhotoAlbumSelectorVC.m
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//
#define MAXCACHEASSETCOUNT 100
#define MAXCACHEIMAGECOUNT 20
#import "PhotoAlbumSelectorVC.h"

#import "PhotoAlbumBrowser.h"

@interface PhotoAlbumSelectorVC ()<UICollectionViewDelegate, UICollectionViewDataSource, PhotoSelectorCellDelegate, PhotoAlbumBrowserDelegate>
{
    IBOutlet UICollectionView *_collectionView;
    IBOutlet UIButton *_doneBtn;
    
    BOOL _viewDidLayout;
    NSInteger _selectedIndex;
    NSMutableArray *_selectedImageIndexs;
    
    PHCachingImageManager *_cacheManager;
    PHImageRequestOptions *_thumbCacheOption;
    CGSize _thumbCacheSize;
    PHImageContentMode _thumbContentMode;
    PHImageRequestOptions *_fullPhotoCacheOption;
    CGSize _fullPhotoCacheSize;
    PHImageContentMode _fullPhotoContentMode;
    NSMutableArray<PHAsset *> *_cachingAssets;
    NSInteger _maxCacheCount;
    NSMutableDictionary *_cachingImages;
    NSMutableDictionary *_cachingRequests;
    NSMutableArray *_cachingIndexes;
}
@end

@implementation PhotoAlbumSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
    _selectedImageIndexs = [[NSMutableArray alloc] init];
    [self refreshDoneBtn];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!_viewDidLayout)
    {
        _viewDidLayout = YES;
        if (_result.count > 0)
        {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_result.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        }
    }
}

#pragma mark - 初始化

- (void)initView
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initData
{
    if (!_cacheManager)
    {
        _cacheManager = [[PHCachingImageManager alloc] init];
    }
    if (!_thumbCacheOption)
    {
        _thumbCacheOption = [[PHImageRequestOptions alloc] init];
        _thumbCacheOption.networkAccessAllowed = YES;
        _thumbCacheOption.synchronous = YES;
        _thumbCacheOption.resizeMode = PHImageRequestOptionsResizeModeExact;
    }
    if (!_fullPhotoCacheOption)
    {
        _fullPhotoCacheOption = [[PHImageRequestOptions alloc] init];
        _fullPhotoCacheOption.networkAccessAllowed = YES;
        _fullPhotoCacheOption.synchronous = YES;
        _fullPhotoCacheOption.resizeMode = PHImageRequestOptionsResizeModeFast;
        _fullPhotoCacheOption.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    }
    _thumbCacheSize = CGSizeMake(200, 200);
    _fullPhotoCacheSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height * 2);
    _thumbContentMode = PHImageContentModeAspectFill;
    _fullPhotoContentMode = PHImageContentModeDefault;
    
    _cachingImages = [[NSMutableDictionary alloc] init];
    _cachingRequests = [[NSMutableDictionary alloc] init];
    _cachingIndexes = [[NSMutableArray alloc] init];
    
    _maxCacheCount = MAXCACHEASSETCOUNT;
    NSMutableArray<PHAsset *> *list = [NSMutableArray array];
    int count = 0;
    for (NSInteger i = _result.count - 1; i >= 0; i--)
    {
        if (count >= _maxCacheCount)
        {
            break;
        }
        [list addObject:_result[i]];
        count++;
    }
    
    [_cacheManager startCachingImagesForAssets:list targetSize:_thumbCacheSize contentMode:_thumbContentMode options:_thumbCacheOption];
    _cachingAssets = [[NSMutableArray alloc] initWithArray:list];
}

#pragma mark - 内部方法

- (void)refreshDoneBtn
{
    if (_selectedImageIndexs.count <= 0)
    {
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _doneBtn.enabled = NO;
    }
    else
    {
        [_doneBtn setTitle:[NSString stringWithFormat:@"完成(%lu)", (unsigned long)_selectedImageIndexs.count] forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.enabled = YES;
    }
}

- (void)refreshCache
{
    NSArray<NSIndexPath *> *indexes = _collectionView.indexPathsForVisibleItems;
    if (indexes.count <= 0)
    {
        return;
    }
    if (indexes.count > _maxCacheCount)
    {
        _maxCacheCount = indexes.count;
    }
    else if (_result.count <= _maxCacheCount)
    {
        return;
    }
    
    NSInteger first = indexes[0].row;
    NSInteger last = first;
    for (NSIndexPath *index in indexes)
    {
        first = index.row < first ? index.row : first;
        last = index.row > last ? index.row : last;
    }
    
    NSInteger other = _maxCacheCount - indexes.count;
    NSInteger before = other / 2;
    NSInteger after = other / 2 + other % 2;
    NSInteger min = first - before;
    NSInteger max = last + after;
    if (min < 0)
    {
        NSInteger temp = 0 - min;
        min = 0;
        max += temp;
        if (max >= _result.count)
        {
            max = _result.count - 1;
        }
    }
    else if (max >= _result.count)
    {
        NSInteger temp = max - _result.count + 1;
        max = _result.count - 1;
        min -= temp;
        if (min < 0)
        {
            min = 0;
        }
    }
    
    NSMutableArray *newAssets = [NSMutableArray array];
    for (NSInteger i = min; i <= max; i++)
    {
        [newAssets addObject:_result[i]];
    }
    NSMutableArray *addAssets = [newAssets mutableCopy];
    [addAssets filterUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", _cachingAssets]];
    NSMutableArray *removeAssets = [_cachingAssets mutableCopy];
    [removeAssets filterUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", newAssets]];
    if (removeAssets.count > 0)
    {
        [_cacheManager stopCachingImagesForAssets:removeAssets targetSize:_thumbCacheSize contentMode:_thumbContentMode options:_thumbCacheOption];
    }
    if (addAssets.count > 0)
    {
        [_cacheManager startCachingImagesForAssets:addAssets targetSize:_thumbCacheSize contentMode:_thumbContentMode options:_thumbCacheOption];
    }
    _cachingAssets = [[NSMutableArray alloc] initWithArray:newAssets];
}

- (void)refreshImageWithIndex:(NSInteger)index
{
    NSInteger min = index - MAXCACHEIMAGECOUNT / 2;
    NSInteger max = index + MAXCACHEIMAGECOUNT / 2;
    if (min < 0)
    {
        NSInteger temp = 0 - min;
        min = 0;
        max += temp;
        if (max >= _result.count)
        {
            max = _result.count - 1;
        }
    }
    else if (max >= _result.count)
    {
        NSInteger temp = max - _result.count + 1;
        max = _result.count - 1;
        min -= temp;
        if (min < 0)
        {
            min = 0;
        }
    }
    
    NSMutableArray *newRequests = [NSMutableArray array];
    for (NSInteger i = min; i <= max; i++)
    {
        [newRequests addObject:@(i)];
    }
    NSMutableArray *addRequests = [newRequests mutableCopy];
    [addRequests filterUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", _cachingIndexes]];
    NSMutableArray *removeRequests = [_cachingIndexes mutableCopy];
    [removeRequests filterUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", newRequests]];
    for (NSNumber *index in removeRequests)
    {
        if ([_cachingRequests.allKeys containsObject:index])
        {
            [_cacheManager cancelImageRequest:[_cachingRequests[index] intValue]];
            [_cachingRequests removeObjectForKey:index];
        }
        if ([_cachingImages.allKeys containsObject:index])
        {
            [_cachingImages removeObjectForKey:index];
        }
    }
    for (NSNumber *index in addRequests)
    {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        PHImageRequestID requestId = [_cacheManager requestImageForAsset:_result[index.intValue] targetSize:_fullPhotoCacheSize contentMode:_fullPhotoContentMode options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result)
            {
                [_cachingImages setObject:result forKey:index];
                [_cachingRequests removeObjectForKey:index];
            }
        }];
        [_cachingRequests setObject:@(requestId) forKey:index];
    }
    _cachingIndexes = [[NSMutableArray alloc] initWithArray:newRequests];
}

- (UIImage *)getImageWithIndex:(NSInteger)index
{
    [self refreshImageWithIndex:index];
    
    if (_cachingImages[@(index)])
    {
        return _cachingImages[@(index)];
    }
    else
    {
        __block UIImage *image = nil;
        [_cacheManager requestImageForAsset:_result[index] targetSize:_fullPhotoCacheSize contentMode:_fullPhotoContentMode options:_fullPhotoCacheOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            image = result;
        }];
        if (!image)
        {
            CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0 alpha:1] CGColor]);
            CGContextFillRect(context, rect);
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        return image;
    }
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

- (IBAction)doneBtnClick:(id)sender
{
    NSMutableArray *list = [NSMutableArray array];
    for (NSNumber *index in _selectedImageIndexs)
    {
        PHAsset *asset = _result[index.integerValue];
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.synchronous = YES;
        option.networkAccessAllowed = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(1000, CGFLOAT_MAX) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result)
            {
                [list addObject:result];
            }
        }];
    }
    void(^completion)(void) = ^{
        if (_completion)
        {
            _completion(list);
        }
    };
    if (self.navigationController)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:completion];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:completion];
    }
}

#pragma mark - PhotoSelectorCellDelegate

- (void)didSelected:(PhotoSelectorCell *)cell
{
    if (_selectedImageIndexs.count < _maxCount)
    {
        [_selectedImageIndexs addObject:@([_collectionView indexPathForCell:cell].row)];
        [self refreshDoneBtn];
    }
    else
    {
        cell.choosed = NO;
        NSString *message = [NSString stringWithFormat:@"你最多可以选择%d张图片", _maxCount];
        //showPromptView(message);
    }
}

- (void)didUnSelected:(PhotoSelectorCell *)cell
{
    [_selectedImageIndexs removeObject:@([_collectionView indexPathForCell:cell].row)];
    [self refreshDoneBtn];
}

#pragma mark - PhotoAlbumBrowserDelegate

- (int)numberOfImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser
{
    return (int)_result.count;
}

- (int)indexOfCurrent:(PhotoAlbumBrowser *)PhotoAlbumBrowser
{
    return (int)_selectedIndex;
}

- (UIImage *)imageForIndex:(int)index sender:(PhotoAlbumBrowser *)PhotoAlbumBrowser
{
    return [self getImageWithIndex:index];
}

- (CGRect)rectOfDisappear:(PhotoAlbumBrowser *)PhotoAlbumBrowser currentIndex:(int)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if ([_collectionView.indexPathsForVisibleItems containsObject:indexPath])
    {
        PhotoSelectorCell *cell = (PhotoSelectorCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        return [cell convertRect:cell.photoImageView.frame toView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        return CGRectZero;
    }
}

- (void)didSelectImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser imageIndexs:(NSArray *)list
{
    [_selectedImageIndexs removeAllObjects];
    for (NSNumber *index in list)
    {
        [_selectedImageIndexs addObject:index];
    }
    [self refreshDoneBtn];
    [_collectionView reloadData];
}

- (void)didSendImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser
{
    [self doneBtnClick:nil];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _result.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PhotoSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoSelectorCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    __block UIImage *image = nil;
    [_cacheManager requestImageForAsset:_result[indexPath.row] targetSize:_thumbCacheSize contentMode:_thumbContentMode options:_thumbCacheOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    
    cell.image = image;
    cell.choosed = [_selectedImageIndexs containsObject:@(indexPath.row)];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex = indexPath.row;
    PhotoSelectorCell *cell = (PhotoSelectorCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    PhotoAlbumBrowser *browser = [[PhotoAlbumBrowser alloc] init];
    browser.delegate = self;
    browser.isSendMode = YES;
    browser.maxCount = _maxCount;
    for (NSNumber *index in _selectedImageIndexs)
    {
        [browser addSelectedIndex:index.intValue];
    }
    [browser showInRect:[cell convertRect:cell.photoImageView.frame toView:[UIApplication sharedApplication].keyWindow]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //最小间距,在collectionView已设置
    CGFloat minSpace = 2;
    //优先至少3列
    int minColumn = 3;
    //其次图片最小100x100
    CGFloat minSize = 100;
    
    int column = (collectionView.frame.size.width + minSpace) / (minSize + minSpace);
    column = column < minColumn ? minColumn : column;
    CGFloat size = (collectionView.frame.size.width + minSpace) / column - minSpace;
    
    return CGSizeMake(size, size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshCache];
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
@implementation PhotoSelectorCell

- (void)setImage:(UIImage *)image
{
    _photoImageView.image = image;
}

- (void)setChoosed:(BOOL)choosed
{
    _choosed = choosed;
    
    if (_choosed)
    {
        [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }
    else
    {
        [_selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    }
}

- (IBAction)selectBtnClicked:(UIButton *)sender
{
    self.choosed = !_choosed;
    
    if (_choosed)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelected:)])
        {
            [_delegate didSelected:self];
        }
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didUnSelected:)])
        {
            [_delegate didUnSelected:self];
        }
    }
}

@end
