//
//  ViewController.m
//  BrowserDemo
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "HistoryViewController.h"
@interface MainViewController ()<PassMsgDelegate>

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.array = [[NSMutableArray alloc]init];
    self.webView.delegate=self;
    self.websiteTextField.delegate=self;
    [self.backButton setTintColor:[UIColor grayColor]];
    [self.backButton setEnabled:NO];
    [self.forwardButton setTintColor:[UIColor grayColor]];
    [self.forwardButton setEnabled:NO];
    //点击Go 加载网站
    [self.goButton addTarget:self action:@selector(goToWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.forwardButton addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(turnForward) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:self action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
    [self.historyButton addTarget:self action:@selector(passMsgToHistory) forControlEvents:UIControlEventTouchUpInside];
}

//跳转网站
- (void)goToWeb{
    NSString *websiteString = self.websiteTextField.text;
    if (![websiteString containsString:@"https://"]&&![websiteString containsString:@"http://"]) {
        NSString *webCaptain = @"https://";
        websiteString = [webCaptain stringByAppendingString:websiteString];
    }
    
    self.url = [NSURL URLWithString:websiteString];
//    NSLog(@"%@",self.url);
//    NSLog(@"host:%@",self.url.host);
    //异步获取网站的favicon
    /*
     问题：如果截取网址.com/前一段来获取图片
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:[self.url.host stringByAppendingString:@"/favicon.ico"]];
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"https://",imageUrl]] ;
        if (imageUrl != nil) {
            //主线程更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
                NSLog(@"imageUrl:%@",imageUrl);

                self.webIcon.image = image;
            });
        }
    });
    //请求网站
    self.request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:self.request];
    //按按钮收键盘
    [self.websiteTextField resignFirstResponder];
    
}

//前一页
-(void) turnForward{
    [self.webView goForward];
}

//后一页
-(void) turnBack{
    [self.webView goBack];
}

//停止加载
- (void) stopLoading{
    [self.webView stopLoading];
}

//给历史页面传值
- (void) passMsgToHistory{
    HistoryViewController * historyViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"history"];
    [historyViewController setDelegate:self];
    historyViewController.mutableArray = [NSMutableArray arrayWithArray:self.array];
    NSLog(@"historyViewcontroller:%@",historyViewController.mutableArray);
    [self presentViewController:historyViewController animated:YES completion:nil];
}


-(void)sendArray:(NSMutableArray *)array{
    self.array = [NSMutableArray arrayWithArray:array];
}
//收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self goToWeb];
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (webView.isLoading) {
        return;
    }
    NSLog(@"DidStartLoad");
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (webView.isLoading) {
        return;
    }
    //拼日期与网址 并记录在array里
     NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [self.array addObject:[NSString stringWithFormat:@"%@,%@",[dateFormatter stringFromDate:date],webView.request.URL] ];
    NSLog(@"%@",self.array);
    ;
    NSLog(@"DidFinishLoad");
    
    //如果页面无法前进、后退，则要让相关按钮disable掉。
    if (!self.webView.canGoForward) {
        [self.backButton setTintColor:[UIColor grayColor]];
        [self.backButton setEnabled:NO];
    }else{
        [self.backButton setTintColor:[UIColor blueColor]];
        [self.backButton setEnabled:YES];
    }
    
    if(!self.webView.canGoBack){
        [self.forwardButton setTintColor:[UIColor grayColor]];
        [self.forwardButton setEnabled:NO];
    }else{
        [self.forwardButton setTintColor:[UIColor blueColor]];
        [self.forwardButton setEnabled:YES];
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView stopLoading];
    //无法访问弹提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
