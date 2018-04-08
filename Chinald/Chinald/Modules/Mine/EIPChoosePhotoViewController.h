//
//  TIBGetEntryInvoiceDataViewController.h
//  taxinvoicebox
//
//  Created by WPFBob on 2017/8/8.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIPChoosePhotoViewController : UIViewController
@property (nonatomic, assign)BOOL isCropperImage;
@property (copy, nonatomic)void(^entryInvoiceDataBlock)(UIImage *image);
-(void)seletTheImageFormAlert:(UIViewController *)viewController AlertTitle:(NSString *)titleString;
@end
