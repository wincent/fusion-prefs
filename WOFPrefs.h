// WOFPrefs.h
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

#import <Cocoa/Cocoa.h>

#import "Fusion/Fusion.h"

@interface WOFPrefs : NSObject <WOFPlugInProtocol> {

}

#pragma mark Extension points

//! Registers the plug-in identified by \p identifier, indicating that it
//! contains a preference pane for display in the preferences window.
//!
//! Upon receiving the registration request, WOFPrefs searches the identified
//! plug-in's "Contents/PreferencePanes/" directory for preference pane bundles
//! with the "prefPane" extension.
- (void)registerPreferencePaneForPlugIn:(NSString *)identifier;

#pragma mark Info.plist keys

//! An integer indicating the position (sort order) of the preference pane.
//!
//! If unset, defaults to zero.
//!
//! To make a pane appear further to the left, use a smaller (or negative)
//! number.
//!
//! To make a pane appear further to the right, use a larger number.
extern NSString *WOFPositionIndex;

@end
