//
//  SMFoodSelectViewController.h
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMFoodSelectViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *b0iv;
@property (strong, nonatomic) IBOutlet UIImageView *b1iv;
@property (strong, nonatomic) IBOutlet UIImageView *b2iv;

@property (strong, nonatomic) IBOutlet UIImageView *l0iv;
@property (strong, nonatomic) IBOutlet UIImageView *l1iv;
@property (strong, nonatomic) IBOutlet UIImageView *l2iv;


@property (strong, nonatomic) IBOutlet UIImageView *s0iv;
@property (strong, nonatomic) IBOutlet UIImageView *s1iv;
@property (strong, nonatomic) IBOutlet UIImageView *s2iv;

@property (strong, nonatomic) IBOutlet UIImageView *d0iv;
@property (strong, nonatomic) IBOutlet UIImageView *d1iv;
@property (strong, nonatomic) IBOutlet UIImageView *d2iv;

@property (strong, nonatomic) IBOutlet UIImageView *ds0iv;
@property (strong, nonatomic) IBOutlet UIImageView *ds1iv;
@property (strong, nonatomic) IBOutlet UIImageView *ds2iv;

@property (strong, nonatomic) IBOutlet UIImageView *completionOverlayImage;

@property (nonatomic, strong) NSArray* categoryPrefixes;

-(BOOL) isCompleted;

-(void) highlightSelectionsByVirtueForCategory:(NSString*)category;
-(void) resetHighlightsForCategory:(NSString*)category;

-(NSString*) categoryForImageView:(UIView*)selectedView;

@end
