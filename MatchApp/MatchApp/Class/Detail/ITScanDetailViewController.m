//
//  ITScanDetailViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/21.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanDetailViewController.h"
#import "Global.h"
#import "Constants.h"
#import "ITDataStore.h"
#import "UIImageView+WebCache.h"
#import "ITLocation.h"

@interface ITScanDetailViewController ()

@end

NSString * rc_illegal_prompt = nil;

@implementation ITScanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码详情";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void) loadData{

    if (_dataInfo ) {
        [self initComponent4LegalScan:_dataInfo];
    }else
    {
        [self requestDataFromServer];
    }
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    _bgScrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight + 100);
}


-(void) requestDataFromServer{
    
    if (_code==nil || _code.length == 0) { return;}
    
    NSString * url = kAppApi(@"api/product/verify.json");
    // 01L013B001AF907BBG0EJW
    
    CLLocationCoordinate2D location =[ITLocation instance].currentLocation;
    NSString * locationStr = [NSString stringWithFormat:@"%f,%f",location.latitude,location.longitude];
    
    NSDictionary * dic = @{@"data":_code,@"device_id":[Global getDeviceUid],@"location":locationStr};
    
    NSDictionary *failmsg = @{@"title":@"产品查询请求失败!"};
    
    [self callServerWithUrl:url param:dic successCallBack:^(NSInteger code, id data) {
        
        [self showRemoteData:data];        
        
    } loadingOptions:nil failOptions:failmsg];
}

-(void) showRemoteData:(NSDictionary *) data{
    
    if(data == nil){
        return;
    }

    NSString * productStr = [data objectForKey:@"product"];
    NSDictionary * product = nil;
    
    if(productStr != nil){
        
      product = [NSJSONSerialization JSONObjectWithData:[productStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    }
    
    int scan_result_state = [[data objectForKey:@"result"]intValue];
    if (scan_result_state < ScanResultFailed || scan_result_state > ScanResultIllegalOther) {
        scan_result_state = ScanResultFailed;
    }
    
    switch (scan_result_state) {
        case ScanResultLegal :   // 平台合法商品扫描详情
            
            [self initComponent4LegalScan:product];
            [[ITDataStore instance] addQrCodeRecord:product];
            break;
            
        case ScanResultIllegalNoCompany :  // 平台验证失败商品扫描详情
        case ScanResultIllegalNoProduct :
            [self initComponent4Illegal:scan_result_state];
            break;
            
        case ScanResultIllegalError :
            rc_illegal_prompt = [product objectForKey:@"product_name"];
            [self initComponent4Illegal:scan_result_state];
            break;
            
        case ScanResultIllegalOther :       // 非平台商品扫描详情
            rc_illegal_prompt = [product objectForKey:@"product_name"];
            [self initComponent4IllegalOther:scan_result_state];
            break;
            
        case ScanResultFailed:              // 返回 -1
            [self initComponent4IllegalFailed:scan_result_state];
            break;
            
        default:
            break;
    }
}

// 平台合法商品扫描详情
-(void) initComponent4LegalScan:(NSDictionary *) product{
    
    //
    NSString *product_name = [product objectForKey:@"product_name"];
    NSString *resultValidate = [NSString stringWithFormat:@"您查询的 %@ 已被验证为合法正品", product_name];
    
    NSMutableAttributedString *resultValidateAttributedStr = [[NSMutableAttributedString alloc]initWithString:resultValidate];
    [resultValidateAttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(5, product_name.length)];
    
    _resultValidateLabelView.attributedText = resultValidateAttributedStr;
    
    //
    int query_num = [[product objectForKey:@"query_num"]intValue];
    
    if (query_num >= 1) {
        NSString *query_num_s = [NSString stringWithFormat:@"%d",query_num];
        NSString *resultValidateNum = [NSString stringWithFormat:@"该产品已被验证 %d 次",  query_num];
        
        NSMutableAttributedString *resultValidateNumAttributedStr = [[NSMutableAttributedString alloc]initWithString:resultValidateNum];
        [resultValidateNumAttributedStr addAttribute:NSForegroundColorAttributeName
                                               value:[UIColor redColor]
                                               range:NSMakeRange(8, query_num_s.length)];
        
        _resultValidateNumLabelView.attributedText = resultValidateNumAttributedStr;
        _resultValidatePromptLabelView.text = @"若您是购买后首次验证, 请注意假冒风险";
        
    } else {
        
        _resultValidateNumLabelView.hidden = YES;
        _resultValidatePromptLabelView.text = @"该产品为首次验证, 请放心使用";
    }

    _productNameLabelView.text = [NSString stringWithFormat:@"产品名称：%@",  [product objectForKey:@"product_name"]];
    _brandNameLabelView.text = [NSString stringWithFormat:@"品牌名称：%@",  [product objectForKey:@"brand_name"]];
    _produceTimeLabelView.text = [NSString stringWithFormat:@"生产时间：%@",  [product objectForKey:@"produce_time"]];
    _batchNameLabelView.text = [NSString stringWithFormat:@"批次编号：%@",  [product objectForKey:@"batch_name"]];
    
    _factoryNameLabelView.text = [NSString stringWithFormat:@"厂商名称：%@",  [product objectForKey:@"factory_name"]];
    _factoryAddrLabelView.text = [NSString stringWithFormat:@"厂商地址：%@",  [product objectForKey:@"factory_addr"]];
    _factoryContactLabelView.text = [NSString stringWithFormat:@"联系方式：%@",  [product objectForKey:@"company_contact"]];
    
    
    id urlList = [product objectForKey:@"product_img_url_list"];
    if (urlList!=nil && ![urlList isEqual: @""]) {
        
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
            [_productImageView sd_setImageWithURL:[NSURL URLWithString:strUrl]];
        }
    } else {
        
        [_productImageView setImage:[UIImage imageNamed:@"history_merchant_img.png"]];
    }

}

// 平台验证失败商品扫描详情
-(void) initComponent4Illegal:(int)scan_result_state {
    NSString *prompt_text = nil;
    
    // 验证结果
    switch (scan_result_state) {
        case ScanResultIllegalNoCompany:
            prompt_text = @"您查询的产品被验证为伪冒品, 请注意假冒风险";
            break;
            
        case ScanResultIllegalNoProduct:
            prompt_text = @"您查询的产品在平台数据库中不存在, 请注意假冒风险";
            break;
            
        case ScanResultIllegalError:
            prompt_text = rc_illegal_prompt;
            break;
            
        default:
            prompt_text = @"您查询的产品被验证为伪冒品, 请注意假冒风险";
            break;
    }
    
    _resultValidateLabelView.text = prompt_text;

    [self setUIVisibility];
}

// 非平台商品扫描详情
-(void) initComponent4IllegalOther:(int)scan_result_state {
    
    _resultValidateLabelView.text = [NSString stringWithFormat:@"您查询的 %@ 非平台接入产品, 请注意假冒风险", rc_illegal_prompt];
    
    [self setUIVisibility];
}

// 返回 -1
-(void) initComponent4IllegalFailed:(int)scan_result_state {
    
    _resultValidateLabelView.text = [NSString stringWithFormat:@"产品查询请求失败!"];
    
    [self setUIVisibility];
}

-(void) setUIVisibility{
    
    _detailView.hidden = YES;
    _resultValidatePromptLabelView.hidden = YES;
    _resultValidateNumLabelView.hidden = YES;
    _productImageView.hidden = YES;
    _imagePromptLabelView.hidden = YES;
}

-(void)onRetryPageRequest{
    
    [self requestDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
