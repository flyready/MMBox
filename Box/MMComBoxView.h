//
//  MMComBoxView.h
//  Box
//
//  Created by Nicholas on 17/2/13.
//  Copyright © 2017年 Mr.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define imgW 10
#define imgH 10
#define tableH 150
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define kBorderColor [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]
#define kTextColor   [UIColor darkGrayColor]
@class MMComBoxView;
@protocol MMComBoxViewDelegate <NSObject>

- (void)comBoxView:(MMComBoxView *)combox selectAtIndex:(NSInteger)index;

@end

@interface MMComBoxView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleLabel;
}
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) UITableView *listTable;
@property (nonatomic,strong) NSMutableArray *titlesList;
@property (nonatomic,assign) NSInteger defaultIndex;
@property (nonatomic,assign) CGFloat tableHeight;
@property (nonatomic,strong) UIImageView *arrow;
//箭头图片名
@property (nonatomic,copy) NSString *arrowImgName;
@property (nonatomic,assign) id<MMComBoxViewDelegate>delegate;
@property (nonatomic,strong) UIView *supView;

- (void)defaultSettings;
- (void)reloadData;
- (void)coloseOtherCombox;
- (void)tapAction;





@end
