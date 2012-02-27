//
//  AppDelegate.h
//  PalEditorForMac
//
//  Created by Huang Kent on 12/2/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PalEditorWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSOpenSavePanelDelegate>
{
    PalEditorWindowController *windowController;
}

@property (assign) IBOutlet NSWindow *window;


- (IBAction)openDocument:(id)sender;

@end
