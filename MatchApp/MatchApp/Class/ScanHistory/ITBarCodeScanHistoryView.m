//
//  ITBarCodeScanHistoryView.m
//  MatchApp
//
//  Created by fuyiming on 14/12/14.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITBarCodeScanHistoryView.h"
#import "ITScanHistoryCell.h"
#import "Constants.h"
#import "ITDataStore.h"
#import "ITScanDetailViewController.h"

@implementation ITBarCodeScanHistoryView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.title =@"条码";
    }
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    [_tableView registerNib:[UINib nibWithNibName:@"ITScanHistoryCell" bundle:nil] forCellReuseIdentifier:@"BarCodeScanHistoryCell"];
    _tableView.delegate =  self;
    _tableView.dataSource =  self;
    [_tableView setBackgroundColor:kRGB(235, 239, 242)];
    [self addSubview:_tableView];
    
    return self;
}

#pragma marks === tableView Delegate Methods===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = [[ITDataStore instance] barCodeHistoryRecords];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ITScanHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BarCodeScanHistoryCell" forIndexPath:indexPath];
    
    id data = [[[ITDataStore instance] barCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    cell.nameLbl.text = [data objectForKey:@"product_name"];
    cell.timeLbl.text = [data objectForKey:@"produce_time"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.dataInfo = [[[ITDataStore instance] barCodeHistoryRecords] objectAtIndex:indexPath.row];
    
    [self.parentNav pushViewController:scanDetail animated:YES];
}



@end
