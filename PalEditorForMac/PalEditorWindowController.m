//
//  PalEditorWindowController.m
//  PalEditorForMac
//
//  Created by Huang Kent on 12/2/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PalEditorWindowController.h"

@implementation PalEditorWindowController

- (id)initWithWindowNibName:(NSString *)nibName fileName:(NSString*)name
{
    self = [super initWithWindowNibName:nibName];
    if (self) {
        // Initialization code here.
        fileName = name;
        self.window.title = name;
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"Open %@",fileName);
    
    role = malloc(sizeof(struct PalExp)*5);
    moneyPtr = malloc(sizeof(struct PalMoney));
    
    int fd = open([fileName cStringUsingEncoding:NSUTF8StringEncoding], O_RDONLY);
    lseek(fd, EXP_OFFSET, SEEK_SET);
    
    read(fd, role, sizeof(struct PalExp)*5);
    
    for (int i = 0 ; i < 5 ; i++) {
        NSLog(@"Role%d: %d, %d",i,role[i].nowExp,role[i].needExp);
    }
    
    lseek(fd, MONEY_OFFSET, SEEK_SET);
    read(fd, moneyPtr, sizeof(struct PalMoney));
    NSLog(@"Money: %d",moneyPtr->money);
    // Init the editor
    NSInteger rid = 0;
    [roleSelecter selectItemAtIndex:rid];
    [self loadMoneyInfo:moneyPtr->money];
    close(fd);
}

#pragma mark - Role level Delegate
- (void)controlTextDidChange:(NSNotification *)obj
{
    //NSLog(@"TextField did end editing: %@",[[obj object] identifier]);
    NSString *textFieldIdentifier = [[obj object] identifier];
    int roleId = (int)[roleSelecter indexOfSelectedItem];
    uint32 value  = [[obj object] intValue];
    
    if ([textFieldIdentifier isEqualToString:@"NeedExp"]) {
        role[roleId].needExp = value;
    } else if ([textFieldIdentifier isEqualToString:@"Exp"]) {
        role[roleId].nowExp = value;
    }
    //NSLog(@"Role%d: %d, %d",roleId,role[roleId].nowExp,role[roleId].level);
}

#pragma mark - NSComboBox Delegate
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSLog(@"%@ is selected",[roleSelecter objectValueOfSelectedItem]);
    NSInteger rid = [roleSelecter indexOfSelectedItem];
    [self loadExpInfoFromRole:rid];
}

#pragma mark - Pal Editor Core Module
- (void)loadExpInfoFromRole:(NSInteger)index
{
    [needExp setStringValue:[NSString stringWithFormat:@"%d",role[index].needExp]];
    [exp setStringValue:[NSString stringWithFormat:@"%d",role[index].nowExp]];
}

- (void)loadMoneyInfo:(NSInteger)value
{
    [money setStringValue:[NSString stringWithFormat:@"%d",value]];
}

- (void)applyButtonDidClick:(id)sender
{
    NSLog(@"Write back to RPG file.");
    int fd = open([fileName cStringUsingEncoding:NSUTF8StringEncoding], O_WRONLY);
    lseek(fd, MONEY_OFFSET, SEEK_SET);
    uint32 moneyWriteBack = [money intValue];
    moneyPtr->money = moneyWriteBack;
    write(fd, moneyPtr, sizeof(struct PalMoney));
    
    
    lseek(fd, EXP_OFFSET, SEEK_SET);
    write(fd, role, sizeof(struct PalExp)*5);
    
    close(fd);
}
@end
