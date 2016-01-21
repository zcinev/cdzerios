//
//  ItemsTabView.m
//  cdzer
//
//  Created by KEns0n on 3/21/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define defaultBtnTagID 9000
#define defaultContentViewTagID 9100
#define defaultCSubViewTagID 9110

#define minHeight 150.0f

#import "ItemsTabView.h"
#import "InsetsLabel.h"
#import "ItemsTabViewCell.h"
@interface ItemsTabView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tvDataSource;

@property (nonatomic, strong) NSArray *tabsTitileList;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) InsetsLabel *noDataLabel;
@end

@implementation ItemsTabView

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.tvDataSource = [@[] mutableCopy];
        [self setTabsTitileList:@[@{@"title":@"用户评论"},
                                  @{@"title":@"服务承诺"},]];
    }
    
    return self;
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, tableView.contentSize) subscribeNext:^(id size) {
        @strongify(self)
        CGSize theSize = [size CGSizeValue];
        CGRect rect = self.frame;
        rect.size.height = 36.0f+theSize.height;
        if (rect.size.height<minHeight) {
            rect.size.height = minHeight;
        }
        self.frame = rect;
    }];
}

- (void)setFrame:(CGRect)frame {
    if (minHeight>CGRectGetHeight(frame)) frame.size.height = minHeight;
    [super setFrame:frame];
}

- (void)initializationUI {
    @autoreleasepool {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setBorderWithColor:nil borderWidth:(0.5f)];
        if (!_tabsTitileList || [_tabsTitileList count]==0) return;
        @weakify(self)
        NSInteger tagCount = [_tabsTitileList count];
        CGFloat btnWidth = CGRectGetWidth(self.frame)/tagCount;
        [_tabsTitileList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *text = [obj objectForKey:@"title"];
            CGRect btnRect = CGRectMake(btnWidth*idx, 0.0f, btnWidth, 36.0f);
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:btnRect];
            
            UIImage *selectedImage = [ImageHandler createImageWithColor:[UIColor colorWithRed:0.396f green:0.396f blue:0.396f alpha:1.00f]
                                                               withRect:btn.bounds];
            if ([obj[@"content"] isKindOfClass:NSArray.class]) {
                text = [text stringByAppendingFormat:@"(%d)",[obj[@"content"] count]];
            }
            [btn setTitle:text forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted|UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:selectedImage forState:UIControlStateHighlighted|UIControlStateSelected];
            [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
            [btn setBackgroundImage:[ImageHandler createImageWithColor:[UIColor whiteColor] withRect:btn.bounds] forState:UIControlStateNormal];
            [btn setBorderWithColor:nil borderWidth:(0.5f)];
            [btn setTag:defaultBtnTagID+idx];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            CGRect contentViewRect = CGRectZero;
            contentViewRect.origin.y = CGRectGetMaxY(btnRect);
            contentViewRect.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(btnRect));
            UIView *contentView = [[UIView alloc] initWithFrame:contentViewRect];
            [contentView setBackgroundColor:CDZColorOfWhite];
            [contentView setBorderWithColor:nil borderWidth:(0.5f)];
            [contentView setHidden:YES];
            [contentView setTag:defaultContentViewTagID+idx];
            contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
            contentView.translatesAutoresizingMaskIntoConstraints = YES;
            [self addSubview:contentView];
            
            if (idx == 0) {
                [btn setSelected:YES];
                [contentView setHidden:NO];
                [btn setUserInteractionEnabled:NO];
            }
            if (idx==0) {
                @strongify(self)
                
                self.tableView = [[UITableView alloc] initWithFrame:contentView.bounds];
                self.tableView.tag = defaultCSubViewTagID;
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                self.tableView.hidden = YES;
                self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                self.tableView.translatesAutoresizingMaskIntoConstraints = YES;
                [contentView addSubview:self.tableView];
                
                self.noDataLabel = [[InsetsLabel alloc] initWithFrame:contentView.bounds andEdgeInsetsValue:DefaultEdgeInsets];
                self.noDataLabel.text = @"没更多评论";
                self.noDataLabel.backgroundColor = CDZColorOfWhite;
                self.noDataLabel.textAlignment = NSTextAlignmentCenter;
                self.noDataLabel.tag = defaultCSubViewTagID+1;
                self.noDataLabel.hidden = YES;
                self.noDataLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                self.noDataLabel.translatesAutoresizingMaskIntoConstraints = YES;
                [contentView addSubview:self.noDataLabel];
                
            }else {
                InsetsLabel *noDataLabel = [[InsetsLabel alloc] initWithFrame:contentView.bounds andEdgeInsetsValue:DefaultEdgeInsets];
                noDataLabel.text = @"";
                noDataLabel.tag = defaultCSubViewTagID;
                noDataLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                noDataLabel.translatesAutoresizingMaskIntoConstraints = YES;
                [contentView addSubview:noDataLabel];
                
                if ([noDataLabel.text isEqualToString:@""]) {
                    noDataLabel.text = @"没有数据";
                    noDataLabel.textAlignment = NSTextAlignmentCenter;
                }
            }
        }];
    }
    [self setReactiveRules];
    [self getAutosPatsCommentList];
    
}
#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_tvDataSource.count>3) {
        return 4;
    }
    return _tvDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    ItemsTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[ItemsTabViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell initializationUI];
        
    }
    // Configure the cell...
    cell.textLabel.text =@"";
    cell.detailTextLabel.text =@"";
    if (indexPath.row==3&&_tvDataSource.count>3) {
        cell.textLabel.text = @"点击取得更多评论！";
    }else {
        [cell updateUIDataWithData:_tvDataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 52.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)btnAction:(UIButton *)button {
    for (int i=0; i<[_tabsTitileList count]; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:defaultBtnTagID+i];
        UIView *contentView = (UIView*)[self viewWithTag:defaultContentViewTagID+i];
        [btn setUserInteractionEnabled:YES];
        [btn setSelected:NO];
        [contentView setHidden:YES];
    }
    UIView *contentView = (UIView*)[self viewWithTag:defaultContentViewTagID+(button.tag-defaultBtnTagID)];
    [button setSelected:YES];
    [contentView setHidden:NO];
    [button setUserInteractionEnabled:NO];
}

- (void)getAutosPatsCommentList {
    @weakify(self)
    if (!_partsID) return
    NSLog(@"%@ accessing network change parts favorite request",NSStringFromClass(self.class));
    
    [[APIsConnection shareConnection] autosPartsAPIsGetAutosPartsCommnetListWithProductID:_partsID pageNums:@(1) pageSize:@(10) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [self.tvDataSource addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        
        if (errorCode!=0||self.tvDataSource.count==0) {
            self.tableView.hidden = YES;
            self.noDataLabel.hidden = NO;
            return ;
        }
        self.tableView.hidden = NO;
        self.noDataLabel.hidden = YES;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
    }];
}
@end
