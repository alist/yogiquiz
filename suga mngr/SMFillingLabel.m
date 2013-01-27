//
//  SMFillingLabel.m
//  suga mngr
//
//  Created by Alexander List on 1/27/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMFillingLabel.h"

@interface SMFillingLabel ()
@property (nonatomic, strong) NSString * endText;
@end


@implementation SMFillingLabel
@synthesize endText;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setText:(NSString *)text{
	self.endText = text;
	[super setText:nil];
	
	[self displayNextTextChunk];
}

-(void)displayNextTextChunk{
	NSInteger endLength = endText.length;
	NSInteger currentLength = self.text.length;
	
	if (currentLength >= endLength)
		return;
	
	NSString * remainderString = [self.endText substringFromIndex:currentLength];
	NSRange nextWordRange = [remainderString rangeOfString:@"\n"];
	NSInteger nextChunkLength = 0;
	if (nextWordRange.location == NSNotFound){
		nextChunkLength = endLength-currentLength;
	}else{
		nextChunkLength = nextWordRange.location+nextWordRange.length;
	}
	
	NSInteger newLength = currentLength + nextChunkLength ;
	NSString * newString = [self.endText substringToIndex:newLength];
	
	[super setText:newString];
	
	[self performSelector:@selector(displayNextTextChunk) withObject:nil afterDelay:0.2];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
