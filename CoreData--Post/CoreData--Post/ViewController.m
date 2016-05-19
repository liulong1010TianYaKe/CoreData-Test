//
//  ViewController.m
//  CoreData--Post
//
//  Created by long on 5/19/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ViewController.h"
#import "YKCoreDataManager.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) YKCoreDataManager *coreManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setScrollIndicatorInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    [self.view addSubview:_tableView];
    
    _coreManager = [[YKCoreDataManager alloc] init];
    [_coreManager loadPostCodeData];
    
    [self readData];
    
    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)readData{
    
    NSArray *tempArr = [_coreManager selectPost];
    if (!tempArr || tempArr.count <=0) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              
              [_coreManager loadPostCodeData];
             NSArray * a = [_coreManager selectPost];
              if (tempArr&& tempArr.count > 0) {
                  _dataSource = [[NSMutableArray alloc] initWithArray:a];
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [_tableView reloadData];
                  });
                  
              }
             
          });
    }else{
        _dataSource = [[NSMutableArray alloc] initWithArray:tempArr];
        [_tableView reloadData];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"POSTCODE";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    PostCode *postcode = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@   %@", postcode.province, postcode.city, postcode.district];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@   %@   %@   %@   %@   %@", postcode.id, postcode.province, postcode.city, postcode.district, postcode.cityId, postcode.postCode];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (!searchText.length) {
        [self readData];
        return;
    }

    _dataSource = [[NSMutableArray alloc] initWithArray:[_coreManager searchPost:searchText]];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PostCode *postcode = [_dataSource objectAtIndex:indexPath.row];
//    Alert *alert = [[Alert alloc] initWithTitle:@"详细" message:[NSString stringWithFormat:@"数据ID   :%@\n省份  :%@\n市  :%@\n区  :%@\n区号 :%@\n邮编 :%@\n", postcode.id, postcode.province, postcode.city, postcode.district, postcode.cityId, postcode.postCode] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
//    [alert setContentAlignment:NSTextAlignmentLeft];
//    [alert setLineSpacing:5];
//    [alert setFont:[UIFont systemFontOfSize:17]];
//    [alert show];
}

#pragma mark - 键盘显示/隐藏
/**
 *  键盘显示
 *
 *  @param note
 */
- (void)keyBoardWillShow:(NSNotification *)note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        _tableView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-rect.size.height);
    }completion:^(BOOL finished) {
    }];
}

/**
 *  键盘隐藏
 *
 *  @param note
 */
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        _tableView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
