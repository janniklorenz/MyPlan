//
//  HTMLObject.m
//  MyPlan
//
//  Created by Jannik Lorenz on 22.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTMLObject.h"

@implementation HTMLObject

+ (NSString *)MakeHTMLTable:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header {
	int FinalValue = (int)[Datensatze count];
	
	NSString *t1 = @"<table border='1' cellspacing='0' cellpadding='5'>";
	NSString *t2 = @"<tr>";
	NSString *t = @"";
	NSString *t3 = @"</tr>";
	NSString *t4 = @"</table>";
		
	int x = 0;
	while (x < FinalValue) {
		int y = 0;
		while (y < Spalten) {
			NSString *titleToAdd = @"";
			if (y <[[Datensatze objectAtIndex:x] count]) titleToAdd = [[Datensatze objectAtIndex:x] objectAtIndex:y];
			else titleToAdd = @"";
			
			NSString *TagType;
			if (y == 0) TagType = @"th";
			else if (x == 0) TagType = @"th";
			else TagType = @"td";
			t = [NSString stringWithFormat:@"%@\n<%@ style='background-color:#FFFFFF; min-width:30px;'><font size='4' align='center' face='helvetica' >%@</%@>", t, TagType, titleToAdd, TagType];
			y++;
		}
		t = [NSString stringWithFormat:@"%@%@%@", t, t3, t2];
		
		x++;
	}
	NSString *Final = [NSString stringWithFormat:@"<h2>%@</h2>\n%@\n%@\n%@\n%@\n%@", Header, t1, t2, t, t3, t4];
	return Final;
}

+ (NSString *)MakeCSVTable:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header {
	int FinalValue = [Datensatze count];
	
	NSString *t = @"";
	
	int x = 0;
	while (x < FinalValue) {
		int y = 0;
		while (y < Spalten) {
			NSString *titleToAdd = @"";
			if (y <[[Datensatze objectAtIndex:x] count]) titleToAdd = [[Datensatze objectAtIndex:x] objectAtIndex:y];
			else titleToAdd = @"";
			
			if (y == Spalten - 1) t = [NSString stringWithFormat:@"%@%@", t, titleToAdd];
			else t = [NSString stringWithFormat:@"%@%@;", t, titleToAdd];
			
			y++;
		}
		t = [NSString stringWithFormat:@"%@\n", t];
		x++;
	}
	NSString *Final = [NSString stringWithFormat:@"%@", t];
	return Final;
}










+ (void)drawLineFromPoint:(CGPoint)from ToPoint:(CGPoint)to {
    CGContextRef   currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 1);
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blackColor].CGColor);
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, from.x, from.y);
    CGContextAddLineToPoint(currentContext, to.x, to.y);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

+ (void)drawTableWithData:(NSMutableArray *)Datensatze Spalten:(int)Spalten {
    int TableStartX = 10;
    int TableStartY = 70;
    
    CGContextRef   currentContext = UIGraphicsGetCurrentContext();
    
    for (int Zeile = 0; Zeile < [Datensatze count]; Zeile++) {
        for (int Spalte = 0; Spalte < Spalten; Spalte++) {
            [self drawLineFromPoint:CGPointMake(TableStartX + 60*Spalte, TableStartY + 20*Zeile) ToPoint:CGPointMake(TableStartX + 60*Spalte + 60, TableStartY + 20*Zeile)]; // Oberkante
            [self drawLineFromPoint:CGPointMake(TableStartX + 60*Spalte, TableStartY + 20*Zeile + 20) ToPoint:CGPointMake(TableStartX + 60*Spalte + 60, TableStartY + 20*Zeile + 20)]; // Unterkante
            [self drawLineFromPoint:CGPointMake(TableStartX + 60*Spalte, TableStartY + 20*Zeile) ToPoint:CGPointMake(TableStartX + 60*Spalte, TableStartY + 20*Zeile + 20)]; // Rechts
            [self drawLineFromPoint:CGPointMake(TableStartX + 60*Spalte + 60, TableStartY + 20*Zeile) ToPoint:CGPointMake(TableStartX + 60*Spalte + 60, TableStartY + 20*Zeile + 20)]; // Links
            
            CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
            
            NSString *textToDraw = @"";
            if ([[Datensatze objectAtIndex:Zeile] count] > Spalte) textToDraw = [[Datensatze objectAtIndex:Zeile] objectAtIndex:Spalte];
            
            UIFont *font = [UIFont systemFontOfSize:10.0];
            if(Spalte == 0) font = [UIFont systemFontOfSize:8];
            if(Zeile == 0) font = [UIFont systemFontOfSize:11.0];
            
            CGRect renderingRect = CGRectMake(TableStartX + 60*Spalte + 3, TableStartY + 20*Zeile + 3, 54, 14);
            
            if (Zeile == 0) [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
            else [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        }
    }
}




+ (NSString *)MakePDF:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header {
    
    int h = 100 + 20 * (int)[Datensatze count];
    int w = 20 + 60*Spalten;
    
    CGSize pageSize = CGSizeMake(w, h );
    NSString *fileName = [NSString stringWithFormat:@"MyPlan Export - PDF (%@).pdf", Header];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
    
    CGContextRef   currentContext = UIGraphicsGetCurrentContext();
    
    // BORDER
    UIColor *borderColor = [UIColor blackColor];
    CGRect rectFrame = CGRectMake(10, 10, w - 20, 50);
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, 1.0);
    CGContextStrokeRect(currentContext, rectFrame);
    
    // HEADER
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    NSString *textToDraw = Header;
    UIFont *font = [UIFont systemFontOfSize:24.0];
    CGRect renderingRect = CGRectMake(18, 22, w - 36, 36);
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    [self drawTableWithData:Datensatze Spalten:Spalten];
    
    
    
    UIGraphicsEndPDFContext();
    
    return pdfFileName;
}







+ (NSString *)uploadContend:(NSString *)Contend andName:(NSString *)Name {
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jlproduction.de/MyPlan5/addPlan.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
	[request setHTTPMethod:@"POST"];
	NSString *post =[[NSString alloc] initWithFormat:@"name=%@&contend=%@&submit=", Name, Contend];
	
	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLResponse *response;
	NSError *err;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *respo = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    return respo;
}



@end