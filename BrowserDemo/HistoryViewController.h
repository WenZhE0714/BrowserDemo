//
//  HistoryViewController.h
//  BrowserDemo
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassMsgDelegate <NSObject>
@required
-(void) sendArray:(NSMutableArray *)array;

@optional

@end

@interface HistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *mutableArray;

@property (weak,nonatomic) id<PassMsgDelegate> delegate;
@property (assign,nonatomic) BOOL cleanFlag;
@end
