//
//  MMComBoxView.m
//  Box
//
//  Created by Nicholas on 17/2/13.
//  Copyright © 2017年 Mr.zhang. All rights reserved.
//

#import "MMComBoxView.h"
@interface MMComBoxView ()
{
    BOOL _isOpen;
    
}
@end
@implementation MMComBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)defaultSettings
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor = kBorderColor.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.clipsToBounds = YES;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, self.frame.size.width-imgW - 5 - 2, self.frame.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = kTextColor;
    [btn addSubview:titleLabel];
    
    _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width - imgW - 2, (self.frame.size.height-imgH)/2.0, imgW, imgH)];
    _arrow.image = [UIImage imageNamed:_arrowImgName];
    [btn addSubview:_arrow];
    
    //默认不展开
    _isOpen = NO;
    _listTable = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.layer.borderWidth = 0.5;
    _listTable.layer.borderColor = kBorderColor.CGColor;
    
    [_supView addSubview:_listTable];
    
    titleLabel.text = [_titlesList objectAtIndex:_defaultIndex];

}
//刷新视图
- (void)reloadData
{
    [_listTable reloadData];
    titleLabel.text = [_titlesList objectAtIndex:_defaultIndex];
    
}
//关闭
- (void)coloseOtherCombox
{
    for (UIView *subView in _supView.subviews)
    {
       
        if ([subView isKindOfClass:[MMComBoxView class]] &&subView!=self) {
            
         MMComBoxView *otherCombox = (MMComBoxView *)subView;
        if (otherCombox.isOpen) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = otherCombox.listTable.frame;
                frame.size.height = 0;
                [otherCombox.listTable setFrame:frame];
                
            } completion:^(BOOL finished) {
                [otherCombox.listTable removeFromSuperview];
                otherCombox.isOpen = NO;
                otherCombox.arrow.transform = CGAffineTransformRotate(otherCombox.arrow.transform, DEGREES_TO_RADIANS(180));
            }];
        }
        
    }
    }
}
//点击事件
- (void)tapAction
{
    //关闭其他combox
    [self coloseOtherCombox];
    if (_isOpen)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _listTable.frame;
            frame.size.height = 0;
            [_listTable setFrame:frame];
        } completion:^(BOOL finished) {
            [_listTable removeFromSuperview];
            _isOpen = NO;
            [UIView animateWithDuration:0.25 animations:^{
               _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
            }];
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            if (_titlesList.count > 0) {
                [_listTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            [_supView addSubview:_listTable];
            [_supView bringSubviewToFront:_listTable];
            CGRect frame = _listTable.frame;
            frame.size.height = _tableHeight > 0 ? _tableHeight:tableH;
            [_listTable setFrame:frame];
        } completion:^(BOOL finished) {
            
            NSLog(@"%@",NSStringFromCGRect(_listTable.frame));
            _isOpen = YES;
            [UIView animateWithDuration:0.25 animations:^{
                _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));

            }];
    }];
    }
}
#pragma mark -tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIndentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, self.frame.size.width, self.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:11.0];
        label.textColor = kTextColor;
        label.tag = 1000;
        [cell addSubview:label];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = kBorderColor;
        [cell addSubview:line];
        
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [_titlesList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    titleLabel.text = [_titlesList objectAtIndex:indexPath.row];
    _isOpen = YES;
    [self tapAction];
    if ([self.delegate respondsToSelector:@selector(comBoxView:selectAtIndex:)]) {
        [self.delegate comBoxView:self selectAtIndex:indexPath.row];
    }
    
    
}




@end
