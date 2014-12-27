//
//  ITNfcCodeScanHistoryView.m
//  MatchApp
//
//  Created by fuyiming on 14/12/14.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITNfcCodeScanHistoryView.h"
#import "ITScanHistoryCell.h"
#import "Constants.h"
#import "ITDataStore.h"

@implementation ITNfcCodeScanHistoryView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.title =@"NFC";
    }
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    [_tableView registerNib:[UINib nibWithNibName:@"ITScanHistoryCell" bundle:nil] forCellReuseIdentifier:@"NfcCodeScanHistoryCell"];
    _tableView.delegate =  self;
    _tableView.dataSource =  self;
    [_tableView setBackgroundColor:kRGB(235, 239, 242)];
    [self addSubview:_tableView];
    return self;
}

-(void) onHistoryViewAppear{
    
    if([[ITDataStore instance] nfcHistoryRecords].count ==0)
        self.tableView.tableFooterView = self.noRecordsLbl;
    else
        [self.noRecordsLbl removeFromSuperview ];
}

-(void) onHistoryViewDisappear{}

#pragma marks === tableView Delegate Methods===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ITScanHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NfcCodeScanHistoryCell" forIndexPath:indexPath];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
