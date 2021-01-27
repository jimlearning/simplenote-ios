#import <UIKit/UIKit.h>
#import <Simperium/Simperium.h>


@class InterlinkProcessor;
@class Note;
@class SPBlurEffectView;
@class SPEditorTextView;
@class SPTagView;
@class SearchMapView;

@interface SPNoteEditorViewController : UIViewController  <SPBucketDelegate>

// Navigation Bar
@property (nonatomic, strong, readonly) SPBlurEffectView * _Nonnull navigationBarBackground;

// Navigation Buttons
@property (nonatomic, strong) UIBarButtonItem * _Nonnull actionButton;
@property (nonatomic, strong) UIBarButtonItem * _Nonnull checklistButton;
@property (nonatomic, strong) UIBarButtonItem * _Nonnull keyboardButton;
@property (nonatomic, strong) UIBarButtonItem * _Nonnull createNoteButton;
@property (nonatomic, strong) UIBarButtonItem * _Nonnull informationButton;

@property (nonatomic, strong, readonly) Note * _Nonnull note;
@property (nonatomic, strong) SPEditorTextView * _Nonnull noteEditorTextView;

@property (nonatomic, strong) SPTagView * _Nonnull tagView;


// History
@property (nonatomic, weak) UIViewController * _Nullable historyViewController;

// Information
@property (nonatomic, weak) UIViewController * _Nullable informationViewController;

// Interlinks
@property (nonatomic, strong) InterlinkProcessor * _Nonnull interlinkProcessor;

// Voiceover
@property (nonatomic, strong) UIView * _Nonnull bottomView;

// Keyboard!
@property (nonatomic, strong) NSArray * _Nullable keyboardNotificationTokens;
@property (nonatomic) BOOL isKeyboardVisible;

@property (nonatomic, strong) SearchMapView * _Nullable searchMapView;

// State
@property (nonatomic, getter=isEditingNote) BOOL editingNote;
@property (nonatomic, getter=isPreviewing) BOOL previewing;
@property (nonatomic, assign) BOOL modified;

- (instancetype _Nonnull)initWithNote:(Note * _Nonnull)note;

- (void)dismissEditor:(id _Nullable )sender;
- (void)insertChecklistAction:(id _Nullable )sender;
- (void)keyboardButtonAction:(id _Nullable )sender;

- (void)endEditing;
- (void)bounceMarkdownPreview;

- (void)ensureSearchIsDismissed;
- (void)highlightSearchResultAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)willReceiveNewContent;
- (void)didReceiveNewContent;
- (void)didDeleteCurrentNote;

- (void)save;
- (void)saveIfNeeded;

// TODO: We can't use `SearchQuery` as a type here because it doesn't work from swift code (because of SPM) :-(
- (void)updateWithSearchQuery:(id _Nullable )query;

@end
