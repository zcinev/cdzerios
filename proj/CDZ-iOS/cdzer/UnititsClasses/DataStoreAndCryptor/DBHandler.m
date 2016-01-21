	//
//  DBHandler.m
//  frp_test
//
//  Created by KEns0n on 4/15/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#import "DBHandler.h"
#import <FMDB/FMDB.h>
#import "UserInfosDTO.h"
#import "AddressDTO.h"
#import "KeyCityDTO.h"
#import "BDPushConfigDTO.h"
#import "UserAutosInfoDTO.h"
#import "UserSelectedAutosInfoDTO.h"
#import "OrderStatusDTO.h"

@interface DBHandler ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DBHandler

#define kDBFileName @"cdzer.sqlite"
static DBHandler *_dbHandleInstance = nil;
static FMDatabase *_fmdb = nil;

+ (DBHandler *)shareInstance {
    
    if (!_dbHandleInstance) {
        _dbHandleInstance = [DBHandler new];
        [_dbHandleInstance setFMDBInstance];
        _dbHandleInstance.dateFormatter = [NSDateFormatter new];
        [_dbHandleInstance.dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
    }
    
    return _dbHandleInstance;
}

- (FMDatabase *)setFMDBInstance {
    
    if (_fmdb) {
        BOOL closeSuccess = [_fmdb close];
        NSLog(@"FMDBClose:::::%d",closeSuccess);
    }
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kDBFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"cdzer" ofType:@"sqlite"] toPath:filePath error:nil];
    }
    
    _fmdb = [FMDatabase databaseWithPath:filePath];
    
    [_fmdb open];
    
    return _fmdb;
}

- (void)resetDBController {
    [_dbHandleInstance setFMDBInstance];
}

- (NSArray *)queryData:(NSString *)querySql withTableKeyList:(NSArray *)keyLists {
    
    if (!querySql||(!keyLists && [keyLists count]==0)) {
        return nil;
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    FMResultSet *set = [_fmdb executeQuery:querySql];
    
    while ([set next]) {
        
    }
    return arrM;
}

#pragma mark- User Token
- (BOOL)updateUserToken:(NSString *)token userID:(NSString*)uid userType:(NSNumber *)type typeName:(NSString *)typeName csHotline:(NSNumber *)csHotline {
    NSString *encryptedToken = [[SecurityCryptor shareInstance] tokenEncryption:token];
    NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO user_ident_data(id, uid, type_id, type_name, user_token_id, cs_hotline, last_datetime) VALUES(1, '%@', '%@', '%@', '%@', '%@', CURRENT_TIMESTAMP);",uid, type, typeName, encryptedToken, csHotline];
    BOOL isDone = [_fmdb executeUpdate:querySql];
    return isDone;
}

- (BOOL)clearUserIdentData {
    NSString *querySql = @"DELETE FROM user_ident_data WHERE id=1;";
    BOOL isDone = [_fmdb executeUpdate:querySql];
    if (isDone) {
        [self executeVACUUMCommand];
    }
    return isDone;
}

- (NSDictionary *)getUserIdentData {
    NSDictionary *userIdentData = nil;
    NSString * querySql = @"SELECT uid, type_id, type_name, user_token_id, cs_hotline FROM user_ident_data;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        userIdentData = @{@"uid":[result stringForColumn:@"uid"],
                          @"token":[result stringForColumn:@"user_token_id"],
                          @"type":@([result intForColumn:@"type_id"]),
                          @"typeName":[result stringForColumn:@"type_name"],
                          @"csHotline":@([result intForColumn:@"cs_hotline"])};
    }

    return userIdentData;
    
}


#pragma mark- User Info
- (BOOL)updateUserInfo:(UserInfosDTO *)dto {
    @autoreleasepool {
        NSDictionary * arguments = [dto processObjectToDBData];
        
        NSArray *key = [arguments allKeys];
        if ([key indexOfObject:@"id"] == NSNotFound) {
            NSLog(@"Key ID Was Not Found");
            return NO;
        }
        __block NSMutableString *tableKey = [NSMutableString string];
        __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
        [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [tableKey appendString:obj];
            [valueKey appendString:obj];
            if (![[key lastObject] isEqual:obj]) {
                [tableKey appendString:@", "];
                [valueKey appendString:@", :"];
            }
        }];
        
        NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO user_info(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey,valueKey];
        
        return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
    }
}

- (BOOL)clearUserInfo {
    NSString *querySql = @"DELETE FROM user_info WHERE `id`= 1";
    // @"INSERT OR REPLACE INTO user_info(id, birthday, email, face_img, nichen, credits, qq, sex, spec_name, telphone, last_datetime) VALUES(1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, CURRENT_TIMESTAMP);";
    BOOL isDone = [_fmdb executeUpdate:querySql];
    return isDone;
}

- (UserInfosDTO *)getUserInfo{
    NSDictionary *historyDic = nil;
    NSString *querySql = @"SELECT * FROM user_info WHERE `id`= 1;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        historyDic = @{@"id":@([result intForColumn:@"id"]),
                       @"birthday":[result stringForColumn:@"birthday"],
                       @"email":[result stringForColumn:@"email"],
                       @"face_img":[result stringForColumn:@"face_img"],
                       @"nichen":[result stringForColumn:@"nichen"],
                       @"credits":[result stringForColumn:@"credits"],
                       @"qq":[result stringForColumn:@"qq"],
                       @"sex":@([result intForColumn:@"sex"]),
                       @"spec_name":[result stringForColumn:@"spec_name"],
                       @"telphone":[result stringForColumn:@"telphone"],
                       @"last_datetime":@([result intForColumn:@"last_datetime"])
                       };
    }
    UserInfosDTO *dto = nil;
    
    if (historyDic) {
        dto = [UserInfosDTO new];
        [dto processDataToObjectWithData:historyDic isFromDB:YES];
    }
    return dto;
    
    
}

#pragma mark- User Autos Selected History
- (BOOL)updateAutoSelectedHistory:(UserSelectedAutosInfoDTO *)dto {
    @autoreleasepool {
        NSDictionary *arguments = [dto processObjectToDBData];
        NSArray *key = [arguments allKeys];
        if ([key indexOfObject:@"id"] == NSNotFound) {
            NSLog(@"Key ID Was Not Found");
            return NO;
        }
        __block NSMutableString *tableKey = [NSMutableString string];
        __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
        [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [tableKey appendString:obj];
            [valueKey appendString:obj];
            if (![[key lastObject] isEqual:obj]) {
                [tableKey appendString:@", "];
                [valueKey appendString:@", :"];
            }
        }];
        
        NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO auto_selected_history(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey,valueKey];
        
        return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
    }
}

- (UserSelectedAutosInfoDTO *)getAutoSelectedHistory {
    UserSelectedAutosInfoDTO *dto = nil;
    NSDictionary *historyDic = nil;
    NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
    NSString *querySql = [@"SELECT * FROM auto_selected_history " stringByAppendingFormat:@" WHERE `id`= \"%@\";",userID];
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        historyDic = @{@"id":[result stringForColumn:@"id"],
                       CDZAutosKeyOfBrandID:@([result intForColumn:CDZAutosKeyOfBrandID]),
                       CDZAutosKeyOfBrandName:[result stringForColumn:CDZAutosKeyOfBrandName],
                       CDZAutosKeyOfBrandIcon:[result stringForColumn:CDZAutosKeyOfBrandIcon],
                       CDZAutosKeyOfDealershipID:@([result intForColumn:CDZAutosKeyOfDealershipID]),
                       CDZAutosKeyOfDealershipName:[result stringForColumn:CDZAutosKeyOfDealershipName],
                       CDZAutosKeyOfSeriesID:@([result intForColumn:CDZAutosKeyOfSeriesID]),
                       CDZAutosKeyOfSeriesName:[result stringForColumn:CDZAutosKeyOfSeriesName],
                       CDZAutosKeyOfModelID:@([result intForColumn:CDZAutosKeyOfModelID]),
                       CDZAutosKeyOfModelName:[result stringForColumn:CDZAutosKeyOfModelName],
                       @"last_datetime":@([result intForColumn:@"last_datetime"])
                       };
    }
    
    if (historyDic) {
        dto = [UserSelectedAutosInfoDTO new];
        [dto processDBDataToObjectWithDBData:historyDic];
    }
    return dto;
    
    
}


#pragma mark- User Selected Autos Data
- (BOOL)updateSelectedAutoData:(UserSelectedAutosInfoDTO *)dto {
    @autoreleasepool {
        NSDictionary *arguments = [dto processObjectToDBData];
        NSArray *key = [arguments allKeys];
        if ([key indexOfObject:@"id"] == NSNotFound) {
            NSLog(@"Key ID Was Not Found");
            return NO;
        }
        __block NSMutableString *tableKey = [NSMutableString string];
        __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
        [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [tableKey appendString:obj];
            [valueKey appendString:obj];
            if (![[key lastObject] isEqual:obj]) {
                [tableKey appendString:@", "];
                [valueKey appendString:@", :"];
            }
        }];
        
        NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO selected_auto(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey,valueKey];
        
        return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
    }
}

- (UserSelectedAutosInfoDTO *)getSelectedAutoData {
    UserSelectedAutosInfoDTO *dto = nil;
    NSDictionary *autoDataDic = nil;
    NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
    NSString *querySql = [@"SELECT * FROM selected_auto " stringByAppendingFormat:@" WHERE `id`= \"%@\";",userID];
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        autoDataDic = @{@"id":[result stringForColumn:@"id"],
                        @"select_from_online":@([result intForColumn:@"select_from_online"]),
                        CDZAutosKeyOfBrandID:@([result intForColumn:CDZAutosKeyOfBrandID]),
                        CDZAutosKeyOfBrandName:[result stringForColumn:CDZAutosKeyOfBrandName],
                        CDZAutosKeyOfBrandIcon:[result stringForColumn:CDZAutosKeyOfBrandIcon],
                        CDZAutosKeyOfDealershipID:@([result intForColumn:CDZAutosKeyOfDealershipID]),
                        CDZAutosKeyOfDealershipName:[result stringForColumn:CDZAutosKeyOfDealershipName],
                        CDZAutosKeyOfSeriesID:@([result intForColumn:CDZAutosKeyOfSeriesID]),
                        CDZAutosKeyOfSeriesName:[result stringForColumn:CDZAutosKeyOfSeriesName],
                        CDZAutosKeyOfModelID:@([result intForColumn:CDZAutosKeyOfModelID]),
                        CDZAutosKeyOfModelName:[result stringForColumn:CDZAutosKeyOfModelName],
                        @"last_datetime":@([result intForColumn:@"last_datetime"])
                       };
    }
    dto = [UserSelectedAutosInfoDTO new];
    if (autoDataDic) {
        [dto processDBDataToObjectWithDBData:autoDataDic];
    }
    return dto;
    
    
}

- (BOOL)clearSelectedAutoData {
    NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
    NSString *querySql = [@"DELETE FROM selected_auto " stringByAppendingFormat:@" WHERE `id`= \"%@\";",userID];
    BOOL isDone = [_fmdb executeUpdate:querySql];
    return isDone;
}

#pragma mark- Repair Shop Type Data
- (BOOL)updateRepairShopTypeList:(NSArray *)argumentList {
    if (!argumentList||argumentList.count==0) return NO;
    __block BOOL isSuccess = YES;
    NSString *querySql = @"";
    if ([self getRepairShopTypeList]) {
        querySql = @"DELETE FROM repair_shop_type;";
        if ([_fmdb executeUpdate:querySql]) {
            NSLog(@"Clear All Records is Done");
            [self executeVACUUMCommand];
        }
    }
    
    [argumentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *querySql = [NSString stringWithFormat:@"INSERT INTO repair_shop_type(id, name) VALUES(:id, :name);"];
            if (![_fmdb executeUpdate:querySql withParameterDictionary:obj]) {
                isSuccess = NO;
            }
        }else {
            isSuccess = NO;
        }
    }];
    return isSuccess;
}

- (NSArray *)getRepairShopTypeList {
    NSMutableArray *storeTypeList = [NSMutableArray array];
    NSString *querySql = @"SELECT * FROM repair_shop_type;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        [storeTypeList addObject:@{@"id":@([result intForColumn:@"id"]),
                                   @"name":[result stringForColumn:@"name"]}];
    }
    
    if(storeTypeList.count == 0)return nil;
    
    return storeTypeList;
    
    
}

#pragma mark- Repair Shop Service Type Data
- (BOOL)updateRepairShopSerivceTypeList:(NSArray *)argumentList {
    if (!argumentList||argumentList.count==0) return NO;
    __block BOOL isSuccess = YES;
    NSString *querySql = @"";
    if ([self getRepairShopTypeList]) {
        querySql = @"DELETE FROM repair_shop_service_type;";
        if ([_fmdb executeUpdate:querySql]) {
            NSLog(@"Clear All Records is Done");
            [self executeVACUUMCommand];
        }
    }
    
    [argumentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *querySql = [NSString stringWithFormat:@"INSERT INTO repair_shop_service_type(id, name) VALUES(:id, :name);"];
            if (obj[@"imgurl"]) {
                querySql = [NSString stringWithFormat:@"INSERT INTO repair_shop_service_type(id, name, imgurl) VALUES(:id, :name, :imgurl);"];
            }
            if (![_fmdb executeUpdate:querySql withParameterDictionary:obj]) {
                isSuccess = NO;
            }
        }else {
            isSuccess = NO;
        }
    }];
    return isSuccess;
}

- (NSArray *)getRepairShopServiceTypeList {
    NSMutableArray *storeTypeList = [NSMutableArray array];
    NSString *querySql = @"SELECT * FROM repair_shop_service_type;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        NSString *icon = @"";
        if ([result stringForColumn:@"imgurl"]) {
            icon = [result stringForColumn:@"imgurl"];
        }
        [storeTypeList addObject:@{@"id":@([result intForColumn:@"id"]),
                                   @"name":[result stringForColumn:@"name"],
                                   @"imgurl":icon}];
    }
    
    if(storeTypeList.count == 0)return nil;
    
    return storeTypeList;
    
    
}

#pragma mark- Purchase Order Status List Data
- (BOOL)updatePurchaseOrderStatusList:(NSArray *)argumentList {
    if (!argumentList||argumentList.count==0) return NO;
    __block BOOL isSuccess = YES;
    NSString *querySql = @"";
    if ([self getRepairShopTypeList]) {
        querySql = @"DELETE FROM order_status;";
        if ([_fmdb executeUpdate:querySql]) {
            NSLog(@"Clear All Records is Done");
            [self resetTableSequence:@"order_status"];
            [self executeVACUUMCommand];
        }
    }
    
    [argumentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *querySql = [NSString stringWithFormat:@"INSERT INTO order_status(id, name) VALUES(:id, :name);"];
            if (![_fmdb executeUpdate:querySql withParameterDictionary:obj]) {
                isSuccess = NO;
            }
        }else {
            isSuccess = NO;
        }
    }];
    return isSuccess;
}

- (NSArray *)getPurchaseOrderStatusList {
    NSMutableArray *storeTypeList = [NSMutableArray array];
    NSString *querySql = @"SELECT * FROM order_status;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        @autoreleasepool {
            OrderStatusDTO *dto = [OrderStatusDTO new];
            [dto processDataToObjectWithData:[result resultDictionary]];
            [storeTypeList addObject:dto];
        }
    }
    
    if(storeTypeList.count == 0)return nil;
    
    return storeTypeList;
    
    
}

#pragma mark- Repair Shop Service List Data
- (BOOL)updateRepairShopServiceList:(NSArray *)argumentList {
    if (!argumentList||argumentList.count==0) return NO;
    __block BOOL isSuccess = YES;
    NSString *querySql = @"";
    if ([self getRepairShopTypeList]) {
        querySql = @"DELETE FROM service_maintenance_list;";
        if ([_fmdb executeUpdate:querySql]) {
            NSLog(@"Clear All Records is Done");
            [self resetTableSequence:@"service_maintenance_list"];
            [self executeVACUUMCommand];
        }
    }
    
    [argumentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *querySql = [NSString stringWithFormat:@"INSERT INTO service_maintenance_list(id, main_name, imgurl, main_type) VALUES(:id, :main_name, :imgurl, :main_type);"];
            if (![_fmdb executeUpdate:querySql withParameterDictionary:obj]) {
                isSuccess = NO;
            }
        }else {
            isSuccess = NO;
        }
    }];
    return isSuccess;
}

- (NSDictionary *)getRepairShopServiceList {
    NSMutableArray *storeTypeList = [NSMutableArray array];
    NSString *querySql = @"SELECT * FROM service_maintenance_list;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        [storeTypeList addObject:[result resultDictionary]];
    }
    
    if(storeTypeList.count == 0)return nil;
    NSDictionary *dataDetail = nil;
    NSPredicate *normalPredicate = [NSPredicate predicateWithFormat:@"SELF.main_type LIKE[cd] %@", CDZObjectKeyOfConventionMaintain];
    NSPredicate *deepPredicate = [NSPredicate predicateWithFormat:@"SELF.main_type LIKE[cd] %@", CDZObjectKeyOfDeepnessMaintain];
    
    dataDetail = @{CDZObjectKeyOfConventionMaintain:[storeTypeList filteredArrayUsingPredicate:normalPredicate],
                   CDZObjectKeyOfDeepnessMaintain:[storeTypeList filteredArrayUsingPredicate:deepPredicate]};
    
    return dataDetail;
    
    
}

#pragma mark- Key City List Data
- (BOOL)updateKeyCityList:(NSArray *)argumentList {
    if (!argumentList||argumentList.count==0) return NO;
    __block BOOL isSuccess = YES;
    NSString *querySql = @"";
    if ([self getRepairShopTypeList]) {
        querySql = @"DELETE FROM key_city;";
        if ([_fmdb executeUpdate:querySql]) {
            NSLog(@"Clear All Records is Done");
            [self resetTableSequence:@"key_city"];
            [self executeVACUUMCommand];
        }
    }
    
    [argumentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KeyCityDTO class]]) {
            NSString *querySql = [NSString stringWithFormat:@"INSERT INTO key_city(region_id, region_name, city_name_pinyin, sorted_key) VALUES(:region_id, :region_name, :city_name_pinyin, :sorted_key);"];
            NSDictionary *cityDetail = [(KeyCityDTO*)obj processObjectToDBData];
            isSuccess = [_fmdb executeUpdate:querySql withParameterDictionary:cityDetail];
        }else {
            isSuccess = NO;
        }
    }];
    return isSuccess;
}

- (NSArray *)getKeyCityList {
    NSMutableArray *storeTypeList = [NSMutableArray array];
    NSString *querySql = @"SELECT * FROM key_city;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        [storeTypeList addObject:@{@"id":[result stringForColumn:@"id"],
                                   @"region_id":[result stringForColumn:@"region_id"],
                                   @"region_name":[result stringForColumn:@"region_name"],
                                   @"city_name_pinyin":[result stringForColumn:@"city_name_pinyin"],
                                   @"sorted_key":[result stringForColumn:@"sorted_key"]}
         ];
    }
    if (storeTypeList.count==0) {
        return storeTypeList;
    }
    return [KeyCityDTO handleDataListFromDBToDTOList:storeTypeList];
    
    
}

#pragma mark- Parts Search History Data
- (BOOL)clearPartsSearchHistory {
    NSString *querySql = @"DELETE FROM parts_search_history;";
    BOOL isDone = [_fmdb executeUpdate:querySql];
    if (isDone) {
        [self executeVACUUMCommand];
    }
    return isDone;
}

- (BOOL)updatePartsSearchHistory:(NSString *)keyword {
    if (keyword&&![keyword isEqualToString:@""]) {
        NSDictionary *obj = @{@"keyword":keyword};
        NSString *querySql = [NSString stringWithFormat:@"INSERT INTO parts_search_history(keyword, last_datetime) VALUES(:keyword, CURRENT_TIMESTAMP);"];
        return [_fmdb executeUpdate:querySql withParameterDictionary:obj];
    }
    return NO;
}

- (NSArray *)getPartsSearchHistory {
    NSMutableArray *historyArray = [NSMutableArray array];
    NSString *querySql = @"SELECT DISTINCT keyword FROM parts_search_history ORDER BY last_datetime DESC;";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    while ([result next]) {
        [historyArray addObject:[result stringForColumn:@"keyword"]];
    }
    
    return historyArray;
}

#pragma mark- Autos GPS Realtime Data
- (BOOL)updateAutoRealtimeData:(NSDictionary *)arguments {
    @autoreleasepool {
        
        NSArray *key = [arguments allKeys];
        if ([key indexOfObject:@"id"] == NSNotFound) {
            NSLog(@"Key ID Was Not Found");
            return NO;
        }
        __block NSMutableString *tableKey = [NSMutableString string];
        __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
        [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [tableKey appendString:obj];
            [valueKey appendString:obj];
            if (![[key lastObject] isEqual:obj]) {
                [tableKey appendString:@", "];
                [valueKey appendString:@", :"];
            }
        }];
        
        NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO auto_gps_realtime_data(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey, valueKey];
        
        return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
    }
}

- (BOOL)clearAutoRealtimeData {
    NSString *querySql = @"INSERT OR REPLACE INTO auto_gps_realtime_data"
    "(id, acc, direction, gpsNum, gsm, imei, lat, lon, mileage, speed, time, last_datetime) VALUES"
    "(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, CURRENT_TIMESTAMP);";
    BOOL isDone = [_fmdb executeUpdate:querySql];
    return isDone;
}

- (NSDictionary *)getAutoRealtimeDataWithDataID:(NSInteger)dataID {
    NSDictionary *historyDic = nil;
    if (dataID<=1) dataID = 1;
    NSString *querySql = [@"SELECT * FROM auto_gps_realtime_data;" stringByAppendingFormat:@" WHERE `id`= %ld;",(long)dataID];
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        historyDic = @{@"id":@([result intForColumn:@"id"]),
                       @"acc":@([result intForColumn:@"acc"]),
                       @"direction":@([result doubleForColumn:@"direction"]),
                       @"gpsNum":@([result intForColumn:@"gpsNum"]),
                       @"gsm":@([result intForColumn:@"gsm"]),
                       @"imei":@([result intForColumn:@"imei"]),
                       @"lat":@([result doubleForColumn:@"lat"]),
                       @"lon":@([result doubleForColumn:@"lon"]),
                       @"mileage":@([result doubleForColumn:@"mileage"]),
                       @"speed":@([result doubleForColumn:@"speed"]),
                       @"time":[result stringForColumn:@"time"],
                       @"last_datetime":@([result intForColumn:@"last_datetime"])
                       };
    }
    
    return historyDic;
    
    
}

#pragma mark- User Autos Detail Data
- (BOOL)updateUserAutosDetailData:(NSDictionary *)arguments {
    @autoreleasepool {
        
        NSArray *key = [arguments allKeys];
        if ([key indexOfObject:@"id"] == NSNotFound) {
            NSLog(@"Key ID Was Not Found");
            return NO;
        }
        __block NSMutableString *tableKey = [NSMutableString string];
        __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
        [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [tableKey appendString:obj];
            [valueKey appendString:obj];
            if (![[key lastObject] isEqual:obj]) {
                [tableKey appendString:@", "];
                [valueKey appendString:@", :"];
            }
        }];
        
        NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO user_autos_detail(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey, valueKey];
        
        return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
    }
}

- (BOOL)clearUserAutosDetailData {
    NSString *querySql = @"INSERT OR REPLACE INTO user_autos_detail"
    "(db_uid, uid, id, car_number, brand_name, brand_img, factory_name, fct_name, spec_name, brandId, factoryId, fctId, specId, imei, color, mileage, insure_time, annual_time, maintain_time, registr_time, frame_no, engine_code, last_datetime)  VALUES"
    "(1, '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '', '', CURRENT_TIMESTAMP);";
    BOOL isDone = [_fmdb executeUpdate:querySql];
    return isDone;
}

- (UserAutosInfoDTO *)getUserAutosDetail {
    @autoreleasepool {
        
        UserAutosInfoDTO *dto = nil;
        NSDictionary *historyDic = nil;
        NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
        NSString *querySql = [@"SELECT * FROM user_autos_detail" stringByAppendingFormat:@" WHERE `id`= \"%@\"",userID];
        FMResultSet *result = [_fmdb executeQuery:querySql];
        
        if ([result next]) {
            historyDic = @{@"db_uid":[result stringForColumn:@"db_uid"],
                           @"uid":[result stringForColumn:@"uid"],
                           @"id":[result stringForColumn:@"id"],
                           @"car_number":[result stringForColumn:@"car_number"],
                           @"brand_name":[result stringForColumn:@"brand_name"],
                           
                           @"brand_img":[result stringForColumn:@"brand_img"],
                           @"factory_name":[result stringForColumn:@"factory_name"],
                           @"fct_name":[result stringForColumn:@"fct_name"],
                           @"spec_name":[result stringForColumn:@"spec_name"],
                           
                           @"brandId":[result stringForColumn:@"brandId"],
                           @"factoryId":[result stringForColumn:@"factoryId"],
                           @"fctId":[result stringForColumn:@"fctId"],
                           @"specId":[result stringForColumn:@"specId"],
                           
                           @"imei":[result stringForColumn:@"imei"],
                           @"color":[result stringForColumn:@"color"],
                           @"mileage":[result stringForColumn:@"mileage"],
                           @"insure_time":[result stringForColumn:@"insure_time"],
                           
                           @"annual_time":[result stringForColumn:@"annual_time"],
                           @"maintain_time":[result stringForColumn:@"maintain_time"],
                           @"registr_time":[result stringForColumn:@"registr_time"],
                           @"frame_no":[result stringForColumn:@"frame_no"],
                           @"engine_code":[result stringForColumn:@"engine_code"]};
            
        }
        if (historyDic) {
            dto = [UserAutosInfoDTO new];
            [dto processDBDataToObjectWithDBData:historyDic];
        }
        
        return dto;
    }
    
    
}

#pragma mark- User Default Address Data
- (BOOL)updateUserDefaultAddress:(AddressDTO *)dto {
    NSDictionary *arguments = [dto processObjectToDBData];
    if (!arguments) {
        return NO;
    }
    NSArray *key = [arguments allKeys];
    if ([key indexOfObject:@"id"] == NSNotFound) {
        NSLog(@"Key ID Was Not Found");
        return NO;
    }
    __block NSMutableString *tableKey = [NSMutableString string];
    __block NSMutableString *valueKey = [NSMutableString stringWithString:@":"];
    [key enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [tableKey appendString:obj];
        [valueKey appendString:obj];
        if (![[key lastObject] isEqual:obj]) {
            [tableKey appendString:@", "];
            [valueKey appendString:@", :"];
        }
    }];
    
    NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO user_default_address(%@, last_datetime) VALUES(%@, CURRENT_TIMESTAMP);", tableKey, valueKey];

    return [_fmdb executeUpdate:querySql withParameterDictionary:arguments];
}

- (BOOL)clearUserDefaultAddress {
    BOOL isSuccess = NO;
    NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
    NSString *querySql = [NSString stringWithFormat:@"DELETE FROM user_default_address WHERE id = %@;",userID];
    isSuccess = [_fmdb executeUpdate:querySql];
    return isSuccess;
}

- (AddressDTO *)getUserDefaultAddress {
    AddressDTO *dto = nil;
    NSString *userID = UserBehaviorHandler.shareInstance.getUserID;
    
    NSDictionary *addressDetail = nil;
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM user_default_address WHERE `id`= \"%@\";",userID];
    FMResultSet *result = [_fmdb executeQuery:querySql];
    
    if ([result next]) {
        addressDetail = @{@"id":[result stringForColumn:@"id"],
                          @"address_id":[result stringForColumn:@"address_id"],
                          @"province_id":[result stringForColumn:@"province_id"],
                          @"province_name":[result stringForColumn:@"province_name"],
                          @"city_id":[result stringForColumn:@"city_id"],
                          @"city_name":[result stringForColumn:@"city_name"],
                          @"region_id":[result stringForColumn:@"region_id"],
                          @"region_name":[result stringForColumn:@"region_name"],
                          @"tel":[result stringForColumn:@"tel"],
                          @"name":[result stringForColumn:@"name"],
                          @"address":[result stringForColumn:@"address"]};
    }
    if (addressDetail) {
        dto = [AddressDTO new];
        [dto processDBDataToObjectWithDBData:addressDetail];
    }
    return dto;
}


#pragma mark- Data Next Update Time

- (NSString *)getTableName:(CDZDBUpdateList)updateTable {
    NSString *tableName = @"";
    
    switch (updateTable) {
        case CDZDBUpdateListOfKeyCity:
            tableName = @"key_city";
            break;
            
        default:
            tableName = @"";
            break;
    }
    
    return tableName;
    
}

- (BOOL)isDataNeedToUpdate:(CDZDBUpdateList)updateTable {
    BOOL isNeedUpdate = NO;
    NSString *tableName = [self getTableName:updateTable];
    if (tableName&&![tableName isEqualToString:@""]) {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM data_update_scheduling WHERE table_name Like \"%@\"", tableName];
        FMResultSet *result = [_fmdb executeQuery:query];
        NSTimeInterval timeInterval = 0;
        if ([result next]) {
            timeInterval = [result doubleForColumn:@"next_update_datetime"];
        }

        NSDate *nextUpdateDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        if ([[NSDate date] compare:nextUpdateDate]==NSOrderedDescending) {
            return YES;
        }
        
    }
    return isNeedUpdate;
}

- (BOOL)updateDataNextUpdateDateTime:(NSDate *)nextUpdateDateTime table:(CDZDBUpdateList)updateTable {
    NSString *tableName = [self getTableName:updateTable];
    BOOL updateSuccess = NO;
    if (tableName&&![tableName isEqualToString:@""]) {
        NSString *query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO data_update_scheduling VALUES (\"%@\", %f )", tableName, [nextUpdateDateTime timeIntervalSince1970]];
        if ([_fmdb executeUpdate:query]) {
            NSLog(@"Update Table:%@ Next Update DateTime Success!", tableName);
        }
    }
    return updateSuccess;
}


#pragma mark- BD APNS Config Data
- (BOOL)updateBDAPNSConfigData:(BDPushConfigDTO *)dto {
    if (!dto) return NO;
    NSString *querySql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO bd_apns_config (id, device_token, channel_id, bdp_user_id) VALUES(1, \"%@\", \"%@\", \"%@\");", dto.deviceToken, dto.channelID, dto.bdpUserID];
    
    return [_fmdb executeUpdate:querySql];
}

- (BOOL)clearBDAPNSConfigData {
    
    NSString *querySql = @"INSERT OR REPLACE INTO bd_apns_config  (id, device_token, channel_id, bdp_user_id) VALUES(1, NULL, NULL, NULL);";
    
    return [_fmdb executeUpdate:querySql];
}

- (BDPushConfigDTO *)getBDAPNSConfigData {

    NSString *querySql = @"SELECT * FROM bd_apns_config WHERE id = 1";
    FMResultSet *result = [_fmdb executeQuery:querySql];
    BDPushConfigDTO *dto = nil;
    dto = [BDPushConfigDTO new];
    if ([result next]) {
        dto.deviceToken = [result stringForColumn:@"device_token"];
        dto.channelID = [result stringForColumn:@"channel_id"];
        dto.bdpUserID = [result stringForColumn:@"bdp_user_id"];
    }
    return dto;
}


- (void)executeVACUUMCommand {
    if ([_fmdb executeUpdate:@"VACUUM;"]) {
        NSLog(@"VACUUM Command Success Executed!");
    }
}

- (void)resetTableSequence:(NSString *)tableName {
    if (!tableName||[tableName isEqualToString:@""]) {
        NSLog(@"tableName is empty");
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"Update sqlite_sequence set seq= \"0\"  WHERE name = \"%@\";", tableName];
    if ([_fmdb executeUpdate:sql]) {
        NSLog(@"Update Table:%@ Sequence Success!", tableName);
    }
}

@end
