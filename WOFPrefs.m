// WOFPrefs.m
// Copyright 2010 Wincent Colaiuta. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "WOFPrefs.h"

#import "fusion-menu/WOFMenu.h"
#import "WOFPrefsWindowController.h"

@interface WOFPrefs ()

@property(readwrite, assign) NSMutableSet *panePaths;
@property WOFPrefsWindowController *windowController;

@end

@implementation WOFPrefs

- (id)init
{
    if ((self = [super init]))
        self.panePaths = [NSMutableSet set];
    return self;
}

- (void)activate
{
    WOFPlugIn *plugIn = [[WOFPlugInManager sharedManager] plugInForIdentifier:@"com.wincent.fusion.menu"];
    WOFMenu *menuPlugIn = plugIn.instance;
    NSMenuItem *item = [menuPlugIn menuItemForIdentifier:@"com.wincent.fusion.menu.application.preferences"];
    [item setTarget:self];
}

- (void)orderFrontPreferencesPanel:(id)sender
{
    if (!self.windowController)
        self.windowController = [[WOFPrefsWindowController alloc] initWithWindowNibName:@"PrefsWindow"];
    [self.windowController showWindow:self];
}

#pragma mark Extension points

- (void)registerPreferencePaneForPlugIn:(NSString *)identifier
{
    WOFPlugIn *plugIn = [[WOFPlugInManager sharedManager] plugInForIdentifier:identifier];
    NSString *plugInPath = [plugIn bundlePath];
    NSString *contentsPath = [plugInPath stringByAppendingPathComponent:@"Contents"];
    NSString *prefPanesPath = [contentsPath stringByAppendingPathComponent:@"PreferencePanes"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:prefPanesPath];
    NSMutableSet *paths = self.panePaths;
    for (NSString *item in enumerator)
    {
        NSString *ext = [item pathExtension];
        if (ext && [ext isEqualToString:@"prefPane"])
        {
            [paths addObject:[prefPanesPath stringByAppendingPathComponent:item]];
            [enumerator skipDescendants];
        }
    }
}

#pragma mark Properties

@synthesize panePaths;
@synthesize windowController;

@end
