//
//  MyOrderTraceDetailVC.m
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vTopMargin vAdjustByScreenRatio(5.0f)
#define vLeftMargin vAdjustByScreenRatio(16.0f)

#import "MyOrderTraceDetailVC.h"
#import "MOTProductDetailView.h"
#import "MyOrderTraceTVCell.h"
#import "InsetsLabel.h"
@interface MyOrderTraceDetailVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MOTProductDetailView *motpDetailView;

@property (nonatomic, strong) NSDictionary *trackingInfo;

@property (nonatomic, strong) NSArray *trackingList;

@property (nonatomic, strong) InsetsLabel *expressNameLabel;

@property (nonatomic, strong) InsetsLabel *expressOrderLabel;

@end

@implementation MyOrderTraceDetailVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"logist_detail")];
    [self setupTrackingInfo];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupTrackingInfo {
    @autoreleasepool {
        
        if (_trackingInfo && [_trackingInfo count]>0) {
            return;
        }
        [self setTrackingInfo:nil];
        [self setTrackingList:nil];
        
        NSDictionary *dictonary = @{@"express_name":@"联邦快递",
                                    @"express_order_num":@"FX24123523213HK2CN",
                                    @"tracking_list":@[@{@"is_passed":@NO,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-25 16:13:50",
                                                         @"eta":@"无法预计",
                                                         @"description":@"货件已经签收"},
                                                       
                                                       @{@"is_passed":@NO,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-25 15:15:18",
                                                         @"eta":@"2015-03-25 15:10:00",
                                                         @"description":@"货件派送中"},
                                                       
                                                       @{@"is_passed":@NO,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-25 11:09:40",
                                                         @"eta":@"2015-03-25 11:00:00",
                                                         @"description":@"货件到达长沙岳麓区派送中心"},
                                                       
                                                       @{@"is_passed":@NO,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-25 10:19:11",
                                                         @"eta":@"2015-03-25 10:15:00",
                                                         @"description":@"货件正在从長沙黃花机场货运中心送往长沙岳麓区派送中心"},
                                                       
                                                       @{@"is_passed":@NO,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-25 02:14:21",
                                                         @"eta":@"2015-03-25 02:08:00",
                                                         @"description":@"货件到达長沙黃花机场货运中心"},
                                                       
                                                       @{@"is_passed":@NO,
                                                         @"is_current_point":@YES,
                                                         @"ata":@"2015-03-24 22:25:00",
                                                         @"eta":@"2015-03-24 22:19:00",
                                                         @"description":@"货件正在从香港国际机场货运中心送往長沙黃花国际机场货运中心"},
                                                       
                                                       @{@"is_passed":@YES,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-24 16:27:18",
                                                         @"eta":@"2015-03-24 17:53:00",
                                                         @"description":@"货件到达香港国际机场货运中心"},
                                                       
                                                       @{@"is_passed":@YES,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-24 17:02:15",
                                                         @"eta":@"2015-03-24 17:00:00",
                                                         @"description":@"货件正在从柴湾集货中心送往香港国际机场货运中心"},
                                                       
                                                       @{@"is_passed":@YES,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-24 16:00:12",
                                                         @"eta":@"2015-03-24 16:05:00",
                                                         @"description":@"货件到达柴湾集散中心"},
                                                       
                                                       @{@"is_passed":@YES,
                                                         @"is_current_point":@NO,
                                                         @"ata":@"2015-03-24 14:20:35",
                                                         @"eta":@"",
                                                         @"description":@"货件已经集收正在送往柴湾集散中心"},
                                                       ]};
        [self setTrackingInfo:dictonary];
        [self setTrackingList:[dictonary objectForKey:@"tracking_list"]];
    }
}


- (void)initializationUI {
    @autoreleasepool {
        
        CGRect motpRect = CGRectZero;
        motpRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), vAdjustByScreenRatio(90.0f));
        [self setMotpDetailView:[[MOTProductDetailView alloc] initWithFrame:motpRect]];
        [_motpDetailView initializationUIWithDetailInfo:@{@"test":@"test"}];
        [self.contentView addSubview:_motpDetailView];
        
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(_motpDetailView.frame);
        tableViewRect.size.height -= CGRectGetMaxY(_motpDetailView.frame);
        
        [self setTableView:[[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:YES];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.contentView addSubview:_tableView];
        
        
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vLeftMargin, 0.0f, vLeftMargin);
        UIFont *font = systemFont(16.0f);
        
        CGRect headerViewRect = _tableView.bounds;
        headerViewRect.size.height = vAdjustByScreenRatio(50.0f);
        UIView *headerView = [[UIView alloc] initWithFrame:headerViewRect];
        [headerView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        [_tableView setTableHeaderView:headerView];
        
        NSString *nameString = [getLocalizationString(@"express_name") stringByAppendingString:[_trackingInfo objectForKey:@"express_name"]];
        CGRect nameLabelRect = headerViewRect;
        nameLabelRect.origin.y = vTopMargin;
        nameLabelRect.size.height = [SupportingClass getStringSizeWithString:nameString
                                                                           font:font
                                                                    widthOfView:CGSizeMake(CGRectGetWidth(headerViewRect),
                                                                                           CGFLOAT_MAX)].height;
        [self setExpressNameLabel:[[InsetsLabel alloc] initWithFrame:nameLabelRect andEdgeInsetsValue:insetsValue]];
        [_expressNameLabel setFont:font];
        [_expressNameLabel setBackgroundColor:CDZColorOfClearColor];
        [_expressNameLabel setNumberOfLines:0];
        [_expressNameLabel setText:nameString];
        [headerView addSubview:_expressNameLabel];
        
        NSString *orderNumString = [getLocalizationString(@"express_order_num") stringByAppendingString:[_trackingInfo objectForKey:@"express_order_num"]];
        CGRect orderNumLabelRect = nameLabelRect;
        orderNumLabelRect.origin.y = CGRectGetMaxY(nameLabelRect);
        orderNumLabelRect.size.height = [SupportingClass getStringSizeWithString:orderNumString
                                                                        font:font
                                                                 widthOfView:CGSizeMake(CGRectGetWidth(headerViewRect),
                                                                                        CGFLOAT_MAX)].height;
        [self setExpressOrderLabel:[[InsetsLabel alloc] initWithFrame:orderNumLabelRect andEdgeInsetsValue:insetsValue]];
        [_expressOrderLabel setFont:font];
        [_expressOrderLabel setBackgroundColor:CDZColorOfClearColor];
        [_expressOrderLabel setNumberOfLines:0];
        [_expressOrderLabel setText:orderNumString];
        [headerView addSubview:_expressOrderLabel];


        
 
    }
}
/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_trackingList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyOrderTraceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyOrderTraceTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:CDZColorOfClearColor];
        
    }
    [cell initializationUIWithDetail:[_trackingList objectAtIndex:indexPath.row]];
    // Configure the cell...
    //    UIImageView *imageView = (UIImageView *)[cell viewWithTag:9090];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return vAdjustByScreenRatio(10.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        NSString *textString = [[_trackingList objectAtIndex:indexPath.row] objectForKey:@"description"];
        return [MyOrderTraceTVCell getContentStringHeight:textString isLastCell:(indexPath.row == ([_trackingList count]-1))];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
