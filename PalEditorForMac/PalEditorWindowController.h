//
//  PalEditorWindowController.h
//  PalEditorForMac
//
//  Created by Huang Kent on 12/2/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "PalDataStructure.h"

@interface PalEditorWindowController : NSWindowController <NSComboBoxDelegate,NSTextFieldDelegate>
{
    NSString *fileName;
    struct PalExp *role;
    struct PalMoney *moneyPtr;
    
    IBOutlet NSComboBox  *roleSelecter;
    IBOutlet NSTextField *needExp;
    IBOutlet NSTextField *exp;
    IBOutlet NSTextField *money;
    IBOutlet NSButton    *applyButton;
}

- (id)initWithWindowNibName:(NSString *)nibName fileName:(NSString*)name;

- (void)loadExpInfoFromRole:(NSInteger)rid;
- (void)loadMoneyInfo:(NSInteger)value;

- (IBAction)applyButtonDidClick:(id)sender;


@end
