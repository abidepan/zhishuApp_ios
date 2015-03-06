//
//  ITSettingAboutViewController.m
//  MatchApp
//
//  Created by mt on 15-3-5.
//  Copyright (c) 2015年 itrace. All rights reserved.
//

#import "ITSettingAboutViewController.h"

@interface ITSettingAboutViewController ()

@end

@implementation ITSettingAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"关于公司";
    
    NSString * bundleFile = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"bundle"];
    NSString * htmlFile = [bundleFile stringByAppendingPathComponent:@"/about.html"];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [_aboutWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL fileURLWithPath:bundleFile]];

    [self.view addSubview:_aboutWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
