//
//  AppDelegate.m
//  PalEditorForMac
//
//  Created by Huang Kent on 12/2/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self openDocument:self];
}

- (void)openDocument:(id)sender
{
    // Oepn RPG file
    NSOpenPanel *openRpgFile = [NSOpenPanel openPanel];
    NSURL *fileUrl;
    [openRpgFile setCanCreateDirectories:NO];
    [openRpgFile setAllowsMultipleSelection:NO];
    [openRpgFile setDelegate:self];
    [openRpgFile setAllowedFileTypes:[NSArray arrayWithObject:@"rpg"]];
    if ([openRpgFile runModal]) {
        fileUrl = [[openRpgFile URLs] objectAtIndex:0];
    }
    
    windowController = [[PalEditorWindowController alloc] initWithWindowNibName:@"PalEditorWindowController"fileName:[fileUrl path]];
    [windowController showWindow:self];
}

@end
