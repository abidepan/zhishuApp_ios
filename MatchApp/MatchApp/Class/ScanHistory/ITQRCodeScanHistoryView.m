//
//  ITQRCodeScanHistoryView.m
//  MatchApp
//
//  Created by fuyiming on 14/12/14.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITQRCodeScanHistoryView.h"
#import "ITScanHistoryCell.h"
#import "Constants.h"
#import "ITScanDetailViewController.h"
#import "ITDataStore.h"
#import "UIImageView+WebCache.h"


@implementation ITQRCodeScanHistoryView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.title = @"二维码";
    }
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    [_tableView registerNib:[UINib nibWithNibName:@"ITScanHistoryCell" bundle:nil] forCellReuseIdentifier:@"QRCodeScanHistoryCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setBackgroundColor:kRGB(235, 239, 242)];
    [self addSubview:_tableView];
    
    return self;
}


-(void) onHistoryViewAppear{

    [self showNoResult];
}

-(void) onHistoryViewDisappear{}


-(void) showNoResult{

    if([[ITDataStore instance] qrCodeHistoryRecords].count == 0)
        self.tableView.tableFooterView = self.noRecordsLbl;
    else
        [self.noRecordsLbl removeFromSuperview ];
}

#pragma marks === tableView Delegate Methods===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray * arr = [[ITDataStore instance] qrCodeHistoryRecords];
    
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ITScanHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QRCodeScanHistoryCell" forIndexPath:indexPath];
    
    // 从数据库中读取
    id data = [[[ITDataStore instance] qrCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    cell.nameLbl.text = [data objectForKey:@"product_name"];
    cell.timeLbl.text = [data objectForKey:@"produce_time"];
    
    // 图片
    id urlList = [data objectForKey:@"product_img_url_list"];
    if (urlList != nil && ![urlList isEqual: @""]) {
        
        NSString * strUrl;
        if ([urlList isKindOfClass:[NSArray class]] ) {
            strUrl = [urlList objectAtIndex:0];
        }else if([urlList isKindOfClass:[NSString class]]){
            strUrl = urlList;
        }
        
        if (strUrl) {
            if (![strUrl hasPrefix:@"http://"]) {
                strUrl = kAppApi(strUrl);
            }
            [cell.infoImgView sd_setImageWithURL:[NSURL URLWithString:strUrl]];
        }
        
    } else {
        
       // 如果没有图片，显示本地图片
       [cell.infoImgView setImage:[UIImage imageNamed:@"history_merchant_img.png"]];
    }
    
    return cell;
}

// cell点击事件，跳转到详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.dataInfo = [[[ITDataStore instance] qrCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    [self.parentNav pushViewController:scanDetail animated:YES];
}

// 右滑事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id data = [[[ITDataStore instance] qrCodeHistoryRecords] objectAtIndex:indexPath.row];
    [[ITDataStore instance] removeQrRecord:data];
    
    [self.tableView reloadData];
    [self showNoResult];
}

// 原生为 @“delete”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



@end
