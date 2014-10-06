//
//  MHEditNameWindowController.m
//  MongoHub
//
//  Created by Syd on 10-4-28.
//  Copyright 2010 ThePeppersStudio.COM. All rights reserved.
//

#import "MHEditNameWindowController.h"


@interface MHEditNameWindowController ()
@property (nonatomic, readwrite, strong) IBOutlet NSTextField *editedNameTextField;
@property (nonatomic, readwrite, strong) IBOutlet NSTextField *nameTitleTextField;

@end

@implementation MHEditNameWindowController

@synthesize editedNameTextField = _editedNameTextField;
@synthesize nameTitleTextField = _nameTitleTextField;

- (NSString *)windowNibName
{
    return @"MHEditNameWindow";
}

- (IBAction)cancel:(id)sender
{
    [NSApp endSheet:self.window];
}

- (IBAction)add:(id)sender
{
    if (self.editedName.length == 0) {
        NSRunAlertPanel(@"Error", @"Collection name can not be empty", @"OK", nil, nil);
    } else {
        [self retain];
        // the delegate will release this instance in this notification, so we need to make sure we keep ourself arround to close the window
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewCollectionWindowWillClose object:self];
        [NSApp endSheet:self.window];
        [self autorelease];
    }
}

- (void)modalForWindow:(NSWindow *)window
{
    [NSApp beginSheet:self.window modalForWindow:window modalDelegate:self didEndSelector:@selector(didEndSheet:returnCode:contextInfo:) contextInfo:nil];
}

- (void)didEndSheet:(NSWindow *)window returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    [self.window orderOut:self];
}

- (void)setNameTitle:(NSString *)nameTitle
{
    self.nameTitleTextField.stringValue = nameTitle;
}

- (NSString *)nameTitle
{
    return self.nameTitleTextField.stringValue;
}

- (void)setEditedName:(NSString *)editedName
{
    self.editedNameTextField.stringValue = editedName;
}

- (NSString *)editedName
{
    return self.editedNameTextField.stringValue;
}

@end