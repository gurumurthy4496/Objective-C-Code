//
//  ModelForVehicleHistory.m
//  ASRPro
//
//  Created by GuruMurthy on 04/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForVehicleHistory.h"

@implementation ModelForVehicleHistory
@synthesize mVehicleHistoryArray_;

@synthesize mCustomerRoInformationArray_;
@synthesize mCustomerRoInformationLeftSideStaticNamesArray_;
@synthesize mRODetailsArray_;

#pragma mark --
#pragma mark Private Methods

- (void)setCustomerRoInformationStaticNamesArray {
    NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"RO Number",@"Mode",@"Year",@"Make",@"Model",@"Mileage",@"Prms Time",@"Prms Date",@"VIN",@"Advisor",@"Technician",@"Parts Emp", nil], kROInformation, nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Number",@"First Name",@"Last Name",@"Email",@"Cell Phone",@"Home Phone",@"Work Phone",@"Address1",@"Address2",@"City",@"State",@"ZIP", nil],kCustomerInformation, nil],[NSDictionary dictionaryWithObjectsAndKeys:self.mVehicleHistoryArray_,kVehicleHistory, nil], nil];
    [self setMCustomerRoInformationLeftSideStaticNamesArray_:lTempArray];
    RELEASE_NIL(lTempArray);
}

- (id)setROInformationMethod :(id)aObject {
    NSArray *lRoInfoArray = [NSArray arrayWithObjects:aObject, nil];
    return lRoInfoArray;
}

- (id)setCustomerInformationMethod :(id)aObject {
    NSArray *lRoInfoArray = [NSArray arrayWithObjects:aObject, nil];
    return lRoInfoArray;
}

- (id)setVehicleInformationMethod {
    NSArray *lRoInfoArray = [NSArray arrayWithObjects:self.mVehicleHistoryArray_, nil];
    return lRoInfoArray;
}

- (void)methodForCustomerROInformation :(id)aCustomerObject ROInFormation :(id)aROInformationObject {
    [self setCustomerRoInformationStaticNamesArray];
    NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[self setROInformationMethod:aROInformationObject ], kROInformation, nil],[NSDictionary dictionaryWithObjectsAndKeys:[self setCustomerInformationMethod:aCustomerObject] ,kCustomerInformation, nil],[NSDictionary dictionaryWithObjectsAndKeys:[self setVehicleInformationMethod] ,kVehicleHistory, nil], nil];
    [self setMCustomerRoInformationArray_:lTempArray];
    RELEASE_NIL(lTempArray);
    DLog(@"CUSTOMER RO INFO :-%@",self.mCustomerRoInformationArray_);
}

#pragma mark --
#pragma mark Public Methods
- (void)setRoAndCustomerInformation {
    
    __block NSMutableDictionary *lCustomerTempArray = [[NSMutableDictionary alloc] init];
    __block NSMutableDictionary *lROInfoTempArray = [[NSMutableDictionary alloc] init];
    
    [[self mRODetailsArray_] enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop1) {
        
        if ([key isEqualToString:@"Customer"]) {
            [object enumerateKeysAndObjectsUsingBlock:^(id key1, id object1, BOOL *stop1) {
                if ([key1 isEqualToString:@"Number"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Number"];
                }else if ([key1 isEqualToString:@"FirstName"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"First Name"];
                }else if ([key1 isEqualToString:@"LastName"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Last Name"];
                }else if ([key1 isEqualToString:@"Email"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Email"];
                }else if ([key1 isEqualToString:@"CellPhone"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Cell Phone"];
                }else if ([key1 isEqualToString:@"HomePhone"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Home Phone"];
                }else if ([key1 isEqualToString:@"WorkPhone"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Work Phone"];
                }else if ([key1 isEqualToString:@"Address1"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Address1"];
                }else if ([key1 isEqualToString:@"Address2"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"Address2"];
                }else if ([key1 isEqualToString:@"City"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"City"];
                }else if ([key1 isEqualToString:@"State"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"State"];
                }else if ([key1 isEqualToString:@"Zip"]) {
                    [lCustomerTempArray setValue:[NSString stringWithFormat:@"%@",object1] forKey:@"ZIP"];
                }
            }];
        }
        
        if ([key isEqualToString:@"RONumber"]) {
            [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object] forKey:@"RO Number"];
        }else if ([key isEqualToString:@"PromisedDate"]) {
            [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object] forKey:@"Prms Date"];
        }else if ([key isEqualToString:@"PromisedTime"]) {
            [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object] forKey:@"Prms Time"];
        }else if ([key isEqualToString:@"CurrentMode"]) {
            [lROInfoTempArray setValue:[self methodToReturnTheUpdatedModeName:[object integerValue]] forKey:@"Mode"];
            DLog(@"CURRENT MODE %d:-",[object integerValue]);
            
        }else if ([key isEqualToString:@"PartsNumber"]) {
            [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object] forKey:@"Parts Emp"];
        }
        
        if ([key isEqualToString:@"Vehicle"]) {
            [object enumerateKeysAndObjectsUsingBlock:^(id key2, id object2, BOOL *stop1) {
                
                if ([key2 isEqualToString:@"Year"]) {
                    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object2] forKey:@"Year"];
                }else if ([key2 isEqualToString:@"Make"]) {
                    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object2] forKey:@"Make"];
                }else if ([key2 isEqualToString:@"Model"]) {
                    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object2] forKey:@"Model"];
                }else if ([key2 isEqualToString:@"Mileage"]) {
                    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@",object2] forKey:@"Mileage"];
                }else if ([key2 isEqualToString:@"VIN"]) {
                    NSString *trimmedString = [object2 substringFromIndex:MAX((int)[object2 length]-8, 0)]; //in case string is less than 8 characters long.
                    [lROInfoTempArray setValue:trimmedString forKey:@"VIN"];
                }
            }];
        }
    }];
    
    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@ %@",([[[self mRODetailsArray_] objectForKey:@"Advisor"] objectForKey:@"FirstName"])!= nil ?[[[self mRODetailsArray_] objectForKey:@"Advisor"] objectForKey:@"FirstName"] :@"",([[[[self mRODetailsArray_] objectForKey:@"Advisor"] objectForKey:@"EmployeeType"] objectForKey:@"Name"])!= nil ?[[[[self mRODetailsArray_] objectForKey:@"Advisor"] objectForKey:@"EmployeeType"] objectForKey:@"Name"] :@""] forKey:@"Advisor"];
    
    [lROInfoTempArray setValue:[NSString stringWithFormat:@"%@ %@",([[[self mRODetailsArray_] objectForKey:@"Technician"] objectForKey:@"FirstName"])!= nil ?[[[self mRODetailsArray_] objectForKey:@"Technician"] objectForKey:@"FirstName"] :@"",([[[[self mRODetailsArray_] objectForKey:@"Technician"] objectForKey:@"EmployeeType"] objectForKey:@"Name"])!= nil ?[[[[self mRODetailsArray_] objectForKey:@"Technician"] objectForKey:@"EmployeeType"] objectForKey:@"Name"] :@""] forKey:@"Technician"];
    
    [self methodForCustomerROInformation:lCustomerTempArray ROInFormation:lROInfoTempArray];
    
}

// ----------------------------;
// Method to show The Updated Mode Name;
// ----------------------------;
- (NSString *)methodToReturnTheUpdatedModeName :(int)mode {
    NSString *modeName= @"";
    switch (mode) {
            
        case 2: // Row 0;
        {
            modeName = @"Dispatch";
            break;
        }
            
        case 3: // Row 1;
        {
            modeName = @"Inspection";
            break;
        }
            
        case 4: // Row 2;
        {
            modeName = @"Pending Approval";
            break;
        }
            
        case 6: // Row 3;
        {
            modeName = @"Repair";
            break;
        }
            
        case 7: // Row 4;
        {
            modeName = @"Review";
            break;
        }
            
        default:
            modeName = @"PRE-RO";
            break;
    }
    return modeName;
}

@end
