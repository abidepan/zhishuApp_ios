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


@implementation ITQRCodeScanHistoryView


-(instancetype)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    if (self) {
        self.title =@"二维码";
    }
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    [_tableView registerNib:[UINib nibWithNibName:@"ITScanHistoryCell" bundle:nil] forCellReuseIdentifier:@"QRCodeScanHistoryCell"];
    _tableView.delegate =  self;
    _tableView.dataSource =  self;
    [_tableView setBackgroundColor:kRGB(235, 239, 242)];
    [self addSubview:_tableView];
    
    
    NSArray * arr = [[ITDataStore instance] qrCodeHistoryRecords];
    
    return self;
}


-(void) onHistoryViewAppear{

    if([[ITDataStore instance] qrCodeHistoryRecords].count ==0)
        self.tableView.tableFooterView = self.noRecordsLbl;
    else
        [self.noRecordsLbl removeFromSuperview ];
}

-(void) onHistoryViewDisappear{}


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
    
    id data = [[[ITDataStore instance] qrCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    cell.nameLbl.text = [data objectForKey:@"product_name"];
    cell.timeLbl.text = [data objectForKey:@"produce_time"];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.dataInfo = [[[ITDataStore instance] qrCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    [self.parentNav pushViewController:scanDetail animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}




@end
