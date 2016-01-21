//
//  PersonalDataVC.m
//  cdzer
//
//  Created by KEns0n on 3/24/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vStartSpace vAdjustByScreenRatio(16.0f)
#import "PersonalDataVC.h"
#import "InsetsLabel.h"
#import "NetProgressImageView.h"
#import "InsetsTextField.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIView+Borders/UIView+Borders.h>
#import <GPUImage/GPUImage.h>
#import "PersonalDataInputView.h"
#import "UserInfosDTO.h"

@interface PersonalDataVC ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NetProgressImageView *portraitView;

@property (nonatomic, strong) UserInfosDTO *userInfo;

@property (nonatomic, strong) UserInfosDTO *userInfoChanged;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *settingArray;

@property (nonatomic, strong) PersonalDataInputView *pdInputView;

@end

@implementation PersonalDataVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"personal_data")];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, tableView.contentSize) subscribeNext:^(id theSize) {
        @strongify(self)
        CGSize size = [theSize CGSizeValue];
        CGRect frame = self.tableView.frame;
        frame.size.height = size.height+self.tableView.rowHeight;
        self.tableView.frame = frame;
    }];
}

- (void)componentSetting {
    
    self.userInfo = DBHandler.shareInstance.getUserInfo;
    
    [self updateSettingArrayWithIsNeedReload:NO];
}

- (void)updateSettingArrayWithIsNeedReload:(BOOL)isNeed {
    @autoreleasepool {
        
        NSString *notDefine = getLocalizationString(@"not_define");
        NSString *moblie = (![_userInfo.telphone isEqualToString:@""])?_userInfo.telphone:notDefine;
        NSString *user_name = (![_userInfo.nichen isEqualToString:@""])?_userInfo.nichen:notDefine;
//        NSString *dob = (isInfoExist&&![_userInfo[@"birthday"] isEqualToString:@""])?_userInfo[@"birthday"]:notDefine;
//        NSString *qq = (isInfoExist&&![_userInfo[@"qq"] isEqualToString:@""])?_userInfo[@"qq"]:notDefine;
//        NSString *email = (isInfoExist&&![_userInfo[@"email"] isEqualToString:@""])?_userInfo[@"email"]:notDefine;
        NSString *gender = getLocalizationString(_userInfo.gender.boolValue?@"male":@"female");
        
        self.settingArray = nil;
        self.settingArray = @[@{@"title":@"mobile",
                                @"extData":@{@"type":@"string",@"data":moblie},
                                @"isArrow":@NO},
                              
                              @{@"title":@"user_name",
                                @"extData":@{@"type":@"string",@"data":user_name},
                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfUserNameChange)},
                              @{@"title":@"pwd_change",
                                @"extData":@{@"type":@""},
                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfPasswordChange)},
                              
                              @{@"title":@"gender",
                                @"extData":@{@"type":@"string",@"data":gender},
                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfGenderSelection)},
//                              @{@"title":@"dob",
//                                @"extData":@{@"type":@"string",@"data":dob},
//                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfDOBChange)},
//                              
//                              @{@"title":@"qq",
//                                @"extData":@{@"type":@"string",@"data":qq},
//                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfQQChange)},
//                              @{@"title":@"email",
//                                @"extData":@{@"type":@"string",@"data":email},
//                                @"isArrow":@YES,@"inputType":@(PDInputTypeOfEmailChange)}
                              ];
        if (isNeed) {
            [_tableView reloadData];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializationUI {
    @autoreleasepool {
        NSString *image = _userInfo.portrait;
        CGFloat imageSize = 100.0f;
        
        UIView *portraitContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), imageSize+30.0f)];
        portraitContainerView.backgroundColor = CDZColorOfDefaultColor;
        [self.contentView addSubview:portraitContainerView];
        
        UIControl *portraitBorderView = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageSize+10.0f, imageSize+10.0f)];
        portraitBorderView.backgroundColor = CDZColorOfWhite;
        portraitBorderView.center = CGPointMake(CGRectGetWidth(portraitContainerView.frame)/2.0f, CGRectGetHeight(portraitContainerView.frame)/2.0f);
        portraitBorderView.layer.masksToBounds = YES;
        portraitBorderView.layer.allowsEdgeAntialiasing = YES;
        portraitBorderView.layer.cornerRadius = CGRectGetWidth(portraitBorderView.frame)/2.0f;
        [portraitBorderView addTarget:self action:@selector(showImageTypeActionSheet) forControlEvents:UIControlEventTouchUpInside];
        [portraitContainerView addSubview:portraitBorderView];
        
        self.portraitView = [[NetProgressImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageSize, imageSize)];
        _portraitView.center = CGPointMake(CGRectGetWidth(portraitBorderView.frame)/2.0f, CGRectGetHeight(portraitBorderView.frame)/2.0f);
        _portraitView.layer.masksToBounds = YES;
        _portraitView.layer.allowsEdgeAntialiasing = YES;
        _portraitView.layer.cornerRadius = CGRectGetWidth(_portraitView.frame)/2.0f;
        _portraitView.userInteractionEnabled = NO;
        [_portraitView setImageURL:image];
        [portraitBorderView addSubview:_portraitView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(portraitContainerView.frame),
                                                                       CGRectGetWidth(self.contentView.frame),
                                                                       CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(portraitContainerView.frame))];
        [_tableView setBounces:YES];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.bounces = NO;
        [self.contentView addSubview:_tableView];
        
        self.pdInputView = [[PersonalDataInputView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_pdInputView];
        @weakify(self)
        [_pdInputView setPDCompletionBlock:^(PDInputType type, NSDictionary *result) {
            @strongify(self)
            if (type==PDInputTypeOfNone) return;
            if (type==PDInputTypeOfPasswordChange) {
                
            }
            [self getUserDetail];
        }];
    
    }
}

- (void)updateValueWithInputType:(PDInputType)inputType andResult:(NSDictionary *)result {
    if (inputType==PDInputTypeOfPasswordChange&&inputType==PDInputTypeOfNone) return;
    @weakify(self)
    [self.settingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @strongify(self)
        PDInputType theInputType = [obj[@"inputType"] integerValue];
        if (theInputType == inputType) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            cell.detailTextLabel.text = result[PDInputKeyFirstValue];
        }
        
    }];
}

- (void)actionForActiveEditUserInfo:(NSIndexPath *)indexPath {
    @autoreleasepool {
        if (indexPath.row == 0) return;
        NSDictionary *settingDetail = _settingArray[indexPath.row];
        PDInputType inputType = [settingDetail[@"inputType"] integerValue];
        NSString *originalValue = [settingDetail[@"extData"] objectForKey:@"data"];
        if ([originalValue isEqualToString:getLocalizationString(@"not_define")]) {
            originalValue = @"";
        }
        [_pdInputView setInputType:inputType withOriginalValue:originalValue];
        [_pdInputView showView];
    }
}

- (void)showImageTypeActionSheet {
    @autoreleasepool {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择图片来源"
                                      delegate:nil
                                      cancelButtonTitle:getLocalizationString(@"cancel")
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拍照", @"相册",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
        [actionSheet.rac_buttonClickedSignal subscribeNext:^(NSNumber *buttonIndex) {
            if (buttonIndex.integerValue<=1) {
                [self showImagePicker:(buttonIndex.boolValue)?UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
            }
        }];
    }
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType {
    
    if (sourceType==UIImagePickerControllerSourceTypeCamera&&IS_SIMULATOR) {
        [SupportingClass showAlertViewWithTitle:@"alert_remind"
                                        message:@"本机不支援相机功能!"
                                isShowImmediate:YES cancelButtonTitle:@"ok"
                              otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        return;
    }
    @autoreleasepool {
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (*stop) {
                    NSLog(@"Allow");
                    return;
                }
                *stop = TRUE;
                
            } failureBlock:^(NSError *error) {
                NSLog(@"Not Allow");
                [self dismissViewControllerAnimated:YES completion:nil];
                [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"车队长没有被授权访问的照片数据。\n请检查私隐控制权限／家长控制权限！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
                
            }];  
        }else if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted ||[ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied ){
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"车队长没有被授权访问的照片数据。\n请检查私隐控制权限／家长控制权限！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
               
            }];
            return;
        }
    
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.sourceType = sourceType;
        if (sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
            imagePicker.allowsEditing = YES;
        }
        [self presentViewController:imagePicker animated:YES completion:^{}];
    }
}

#pragma -mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    @weakify(self)
    [ProgressHUDHandler showHUDWithTitle:@"更新资料中...." onView:nil];
        [[APIsConnection shareConnection] personalCenterAPIsPostUseryPortraitImage:info[UIImagePickerControllerEditedImage] imageName:@"userImage" imageType:ConnectionImageTypeOfJPEG success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:@"更新头像失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        NSString *url = responseObject[@"url"];
        @strongify(self)
        [self updateUserPortraitURL:url];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"更新头像失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
    }];
    
}

- (void)updateUserPortraitURL:(NSString *)url {
    if (!self.accessToken) return;
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPatchUserPersonalInformationWithAccessToken:self.accessToken byPortraitPath:url autoInfo:nil mobileNumber:nil nickName:nil sexual:nil bod:nil  qqNumber:nil email:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [ProgressHUDHandler showSuccessWithStatus:@"更新成功"  onView:nil completion:^{
            [self.portraitView setImageURL:url];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"更新资料失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    return _settingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    // Configure the cell...
    NSDictionary *settingDetail = _settingArray[indexPath.row];
    cell.textLabel.text = getLocalizationString(settingDetail[@"title"]);
    cell.textLabel.font = systemFontBoldWithoutRatio(16.0f);
    
    BOOL isArrow = [settingDetail[@"isArrow"] boolValue];
    cell.accessoryType = isArrow?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    
    cell.detailTextLabel.text = nil;
    cell.accessoryView = nil;
    NSDictionary *extData = settingDetail[@"extData"];
    if (extData) {
        if ([extData[@"type"] isEqualToString:@"string"]) {
            cell.detailTextLabel.text = extData[@"data"];
            cell.detailTextLabel.textColor = CDZColorOfDefaultColor;
            cell.detailTextLabel.font = systemFontWithoutRatio(15.0f);
        }
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self actionForActiveEditUserInfo:indexPath];
}

#pragma mark- gender Action Code Section
- (void)getUserDetail {
    if (!self.accessToken) {
        return;
    }
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsGetPersonalInformationWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            return;
        }
        [ProgressHUDHandler dismissHUD];
        
        [_userInfo processDataToObjectWithData:[responseObject objectForKey:CDZKeyOfResultKey] isFromDB:NO];
        [DBHandler.shareInstance updateUserInfo:_userInfo];
        [self updateSettingArrayWithIsNeedReload:YES];
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

@end
