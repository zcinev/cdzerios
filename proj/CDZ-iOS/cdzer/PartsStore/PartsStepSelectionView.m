//
//  PartsStepSelectionView.m
//  cdzer
//
//  Created by KEns0n on 5/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define kObjID @"id"
#define kObjName @"name"
#define kObjImage @"imgurl"
#define NotificationKey @"NotificationKey"



#import "PartsStepSelectionView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InsetsLabel.h"
#import "PartsSearchReferenceObject.h"

@interface FixedImageTVCell : UITableViewCell
@property (nonatomic, assign) BOOL fixedImage;
@end
@implementation FixedImageTVCell


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.fixedImage) {
        self.imageView.frame = CGRectMake(15.0f , 5.0f, 60.0f, 60.0f);
        CGRect textFrame = self.textLabel.frame;
        textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
        self.textLabel.frame = textFrame;
        
        CGRect detailTextFrame = self.detailTextLabel.frame;
        detailTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
        self.detailTextLabel.frame = detailTextFrame;
        
        [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
    }
}

- (void)setFixedImage:(BOOL)fixedImage {
    _fixedImage = fixedImage;
    [self layoutIfNeeded];
}

@end


@interface PartsStepSelectionView ()<UINavigationBarDelegate>

@property (nonatomic, strong) NSMutableArray *stepList;

@property (nonatomic, strong) NSMutableArray *selectedIndexPath;

- (void)updateTitleStatus;

@end

@interface StepTableView : UITableViewController

@property (nonatomic, assign) NSInteger currentStep;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, assign) NSIndexPath *indexPathForSelectedRow;
@end

@implementation StepTableView
- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([SupportingClass isOS7Plus]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    [self initializationUI];
    [self componentSetting];
    [self setReactiveRules];
    
    // Do any additional setup after loading the view.
}

- (void)componentSetting {
    if (!_dataList) {
        self.dataList = @[];
    }
}

- (void)setReactiveRules {
    @weakify(self);
    [RACObserve(self, dataList) subscribeNext:^(NSArray *dataList) {
        if (dataList) {
            @strongify(self)
            [self.tableView reloadData];
        }
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.view.frame;
//    if (self.currentStep==0) {
//        frame.size.height = CGRectGetHeight(self.navigationController.view.frame);
//    }else {
//        frame.size.height = CGRectGetHeight(self.navigationController.view.frame)-CGRectGetHeight(self.navigationController.navigationBar.frame);
//    }
    frame.size.height = CGRectGetHeight(self.navigationController.view.frame)-CGRectGetHeight(self.navigationController.navigationBar.frame);
    self.view.frame = frame;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    super.navigationController.navigationBarHidden = (_currentStep==0);
    if ([self.navigationController isKindOfClass:PartsStepSelectionView.class]) {
        [(PartsStepSelectionView *)self.navigationController updateTitleStatus];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    FixedImageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[FixedImageTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        UIImage *arrowImage = ImageHandler.getRightArrow;
        cell.accessoryView = [[UIImageView alloc] initWithImage:arrowImage];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:CDZColorOfWhite];
        cell.fixedImage = NO;
    }
    // Configure the cell...
    NSString *imageUrl = [_dataList[indexPath.row] objectForKey:kObjImage];
    if (imageUrl) {
        cell.fixedImage = YES;
        cell.imageView.image = [ImageHandler getWhiteLogo];
        if ([imageUrl rangeOfString:@"http"].location!=NSNotFound) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[ImageHandler getWhiteLogo]];
        }
    }
    cell.textLabel.text = [_dataList[indexPath.row] objectForKey:kObjName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageUrl = [_dataList[indexPath.row] objectForKey:kObjImage];
    if (imageUrl) {
        return 70;
    }
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __unsafe_unretained StepTableView *tmpSTV = self;
    self.indexPathForSelectedRow = indexPath;
    [NSNotificationCenter.defaultCenter postNotificationName:NotificationKey object:tmpSTV];
}

@end

@implementation PartsStepSelectionView

- (instancetype)init {
    @autoreleasepool {
        StepTableView *vc = [StepTableView new];
        vc.currentStep = 0;
        vc.dataList = @[];
        vc.title = @"请选择汽车部件";
        self = [super initWithRootViewController:vc];
        if (self) {
            
        }
        return self;
    }
}

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setReactiveRules];
    [self componentSetting];
    [self getPartsFirstLevelList];
    self.navigationBar.tintColor = CDZColorOfBlack;

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(updateSelection:) name:NotificationKey object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
    
}

- (void)setReactiveRules {

}

- (void)componentSetting {
    @autoreleasepool {
        self.view.clipsToBounds = YES;
        self.stepList = [@[@[],@[],@[]] mutableCopy];
        self.stepStringList = [@[@"",@"",@""] mutableCopy];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        self.selectedIndexPath = [@[indexPath, indexPath, indexPath] mutableCopy];
    }
}

- (void)updateSelection:(NSNotification *)notifObj {
    @autoreleasepool {
        if ([notifObj.object isKindOfClass:StepTableView.class]) {
            StepTableView *tmpSTV = (StepTableView *)notifObj.object;
            NSIndexPath *indexPathForSelectedRow = tmpSTV.tableView.indexPathForSelectedRow;
            if (!indexPathForSelectedRow) {
                indexPathForSelectedRow = [NSIndexPath indexPathForRow:-1 inSection:0];
            }
            [self.selectedIndexPath replaceObjectAtIndex:tmpSTV.currentStep withObject:indexPathForSelectedRow];
            NSString *currentLevelID = [tmpSTV.dataList[indexPathForSelectedRow.row] objectForKey:kObjID];
            NSString *nameTitle = [tmpSTV.dataList[indexPathForSelectedRow.row] objectForKey:kObjName];
            if ([currentLevelID isKindOfClass:NSNumber.class]) {
                currentLevelID = [[tmpSTV.dataList[indexPathForSelectedRow.row] objectForKey:kObjID] stringValue];
            }
            if (tmpSTV.currentStep==2) {
                self.lastStepID = currentLevelID;
                self.searchReference = tmpSTV.dataList[indexPathForSelectedRow.row];
            }
            NSMutableArray *titleArray = [self mutableArrayValueForKey:@"stepStringList"];
            [titleArray replaceObjectAtIndex:tmpSTV.currentStep withObject:nameTitle];
            if (tmpSTV.currentStep==0) {
                [self getPartsSecondLevelList:currentLevelID withTitleName:nameTitle];
            }
            
            if (tmpSTV.currentStep==1) {
                [self getPartsThirdLevelList:currentLevelID withTitleName:nameTitle];
            }
        }
    }
   
}

- (void)updateTitleStatus {
    @autoreleasepool {
        StepTableView *stv = (StepTableView *)self.visibleViewController;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        if (stv.currentStep==0) {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)];
            [_stepList replaceObjectsAtIndexes:indexSet withObjects:@[@[],@[]]];
            [_selectedIndexPath replaceObjectsAtIndexes:indexSet withObjects:@[indexPath, indexPath]];
            self.lastStepID = nil;
            self.searchReference = nil;
            NSMutableArray *titleArray = [self mutableArrayValueForKey:@"stepStringList"];
            [titleArray replaceObjectAtIndex:1 withObject:@""];
            [titleArray replaceObjectAtIndex:2 withObject:@""];
        }
        
        
        if (stv.currentStep==1) {
            [_stepList replaceObjectAtIndex:2 withObject:@[]];
            [_selectedIndexPath replaceObjectAtIndex:2 withObject:indexPath];
            NSMutableArray *titleArray = [self mutableArrayValueForKey:@"stepStringList"];
            [titleArray replaceObjectAtIndex:2 withObject:@""];
            self.lastStepID = nil;
            self.searchReference = nil;
        }
        
        
//        if (stv.currentStep==2) {
//            [_stepList replaceObjectAtIndex:2 withObject:@[]];
//            [_selectedIndexPath replaceObjectAtIndex:2 withObject:indexPath];
//            self.lastStepID = nil;
//            self.lastStepString = nil;
//        }
    }
}

- (void)setStepStringList:(NSMutableArray *)stepStringList {
    _stepStringList = stepStringList;
}

- (void)setLastStepID:(NSString *)lastStepID {
    _lastStepID = lastStepID;
}

- (void)setSearchReference:(NSDictionary *)searchReference {
    _searchReference = searchReference;
}

#pragma mark- Data Receive Handle
- (void)handleReceivedData:(id)responseObject withIdent:(NSNumber *)ident withTitleName:(NSString *)title{
    if (!responseObject) {
        NSLog(@"Data Error!");
        return;
    }
    @autoreleasepool {
        [ProgressHUDHandler dismissHUD];
        [self.stepList replaceObjectAtIndex:ident.intValue withObject:responseObject];
        if ([self.visibleViewController isKindOfClass:StepTableView.class]&&ident.intValue==0) {
            [(StepTableView *)self.visibleViewController setDataList:responseObject];
        }
        
        if (ident.intValue==1||ident.intValue==2) {
            @autoreleasepool {
//                NSString *partString = (ident.intValue==1)?@"部件":@"零件";
                StepTableView *vc = [StepTableView new];
                vc.currentStep = ident.intValue;
                vc.dataList = responseObject;
                vc.title = title;//[title stringByAppendingString:partString];
                [self.visibleViewController setNavBarBackButtonTitleOrImage:@"上一步" titleColor:CDZColorOfBlack];
                [self pushViewController:vc animated:YES];
            }
        }
        
    }
}

#pragma mark- API Access Code Section

- (void)getPartsFirstLevelList {
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] autosPartsAPIsGetPartsFirstLevelListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(0)};
        [self requestResultHandle:operation responseObject:responseObject andTitleName:nil withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@(0)};
        [self requestResultHandle:operation responseObject:nil andTitleName:nil withError:error];
    }];
}

- (void)getPartsSecondLevelList:(NSString *)levelOneID withTitleName:(NSString *)title {
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] autosPartsAPIsGetPartsSecondLevelListWithFirstLevelID:levelOneID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(1)};
        [self requestResultHandle:operation responseObject:responseObject andTitleName:title withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@(1)};
        [self requestResultHandle:operation responseObject:nil andTitleName:title withError:error];
    }];
}

- (void)getPartsThirdLevelList:(NSString *)levelTwoID withTitleName:(NSString *)title {
    [ProgressHUDHandler showHUD];
        [[APIsConnection shareConnection] autosPartsAPIsGetPartsThirdLevelListWithSecondLevelID:levelTwoID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(2)};
        [self requestResultHandle:operation responseObject:responseObject andTitleName:title withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@(2)};
        [self requestResultHandle:operation responseObject:nil andTitleName:title withError:error];
    }];
}


- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject andTitleName:(NSString *)title withError:(NSError *)error {
    NSNumber * ident = operation.userInfo[@"ident"];
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self handleReceivedData:responseObject[CDZKeyOfResultKey] withIdent:ident withTitleName:title];
        
    }
    
}
@end
