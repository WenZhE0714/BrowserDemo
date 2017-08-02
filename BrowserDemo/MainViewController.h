//
//  ViewController.h
//  BrowserDemo
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface MainViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *webIcon;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) NSURL *url;
@property (strong,nonatomic) NSURLRequest *request;
@property (strong,nonatomic) NSMutableArray *array;
- (void)goToWeb;




@end

