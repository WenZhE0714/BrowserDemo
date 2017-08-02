//
//  HistoryViewController.m
//  BrowserDemo
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@end

@implementation HistoryViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.cancelButton addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanButton addTarget:self action:@selector(cleanDictionary) forControlEvents:UIControlEventTouchUpInside];
    //接受前一个页面传来的_dictionary
    NSLog(@"thisControllerdsfasdf:%@",self.mutableArray);
    
}
//返回主页面
- (void)turnBack{
    if ([self.delegate respondsToSelector:@selector(sendArray:)]) {
        [self.delegate sendArray:self.mutableArray];
//        NSLog(@"%d",_cleanFlag);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//清空历史记录
- (void)cleanDictionary{
    [self.mutableArray removeAllObjects];
//    NSLog(@"thisControllerdClean:%@",self.mutableDictionary);
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%lu",(unsigned long)_mutableDictionary.count);
    return self.mutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
//    NSLog(@"indexDictionary:%@",[_mutableDictionary objectForKey:[NSNumber numberWithInteger:indexPath.row]]);
    cell.textLabel.text = [self.mutableArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
//    NSLog(@"cell:%@",cell.textLabel.text);
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//右划删除操作
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.mutableArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    
    return @[deleteAction];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
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
