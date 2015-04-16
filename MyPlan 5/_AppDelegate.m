//
//  AppDelegate.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//
// test comment

#import "AppDelegate.h"

// Reval View Controller
#import "SWRevealViewController.h"

// MPMenu
#import "MPMenu.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    self.weekViewNav.navigationBar.opaque = NO;
//    self.weekViewNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    MPMenu *menu = [MPMenu new];
    
    _revealViewController = [[SWRevealViewController alloc] initWithRearViewController:nil frontViewController:menu];
    _revealViewController.rearViewRevealWidth = 250;
    _revealViewController.rearViewRevealOverdraw = 0;
    _revealViewController.bounceBackOnOverdraw = YES;
    _revealViewController.stableDragOnOverdraw = YES;
    _revealViewController.delegate = self;
    
    self.window.rootViewController = self.revealViewController;
    
    
    [self.window makeKeyAndVisible];
    
    
//    NSString *currendVersion = @"5.0.1";
//    
//    AppData *appData = [MainData LoadAppData];
//    if (appData == nil) appData = [AppData newAppDataWithVersion:currendVersion];
//	if ([appData checkForFirstStart] || [[MainData LoadMain] count] == 0) { // First Start
//        NSLog(@"First Start");
//        
//        [MainData SaveBackgroundImg:[UIImage imageNamed:@"Holz 1.jpg"]];
//        
//        NSMutableArray *main = [NSMutableArray arrayWithObjects:[Person newPersonWithName:@"Person 1"], nil];
//        [MainData SaveMain:main];
//		appData.selectedPersonID = [[main objectAtIndex:0] PersonID];
//        [MainData SaveAppData:appData];
//        [self.revealSideViewController setFrontViewPosition:FrontViewPositionRight animated:YES];
//        
//        
//        
//        if (self.update == nil) self.update = [[Update alloc] init];
//        self.update.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.update.modalPresentationStyle = UIModalPresentationFormSheet;
//        self.update.isFirst = YES;
//        self.update.delegate = self;
//        [self.weekView presentViewController:self.update animated:YES completion:NULL];
//        
//    }
//    else {
//        
//    }
//    [appData saveStart];
    
    
//    NSMutableArray *Persons = [MainData LoadMain];
//    int index = 0;
//    for (int i = 0; i < [Persons count]; i++) {
//        if ([[[Persons objectAtIndex:i] PersonID] isEqualToString:appData.selectedPersonID]) index = i;
//    }
//    [self.weekView reloadViewsWithIndex:index];
    
    
    
    
    
    
    // ---------- iCloud -----------
    /*
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
        
        self.ubiquitousURL = ubiq;
        self.metadataQuery = [[NSMetadataQuery alloc] init];
        [metadataQuery setPredicate:[NSPredicate predicateWithFormat:@"%K LIKE '*'", NSMetadataItemFSNameKey]];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(queryDidReceiveNotification:)
//                                                 name:NSMetadataQueryDidUpdateNotification
//                                                 object:self.metadataQuery];
        
        [self.metadataQuery startQuery];
        
        
        
        
        
        NSUbiquitousKeyValueStore *keyStore = [[NSUbiquitousKeyValueStore alloc] init];
//        [keyStore setString:@"Savjkhkled String " forKey:@"MyString"];
        [keyStore synchronize];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(ubiquitousKeyValueStoreDidChange:) name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:keyStore];
        
        
        NSString *storedString = [keyStore stringForKey:@"MyString"];
        NSLog(@"(%@)", storedString);
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:@"Main.mp"];
//        
//        NSURL *destinationURL = [self.ubiquitousURL URLByAppendingPathComponent:@"Documents/Main.mp"];
//        [[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:[NSURL fileURLWithPath:DataPath1] destinationURL:destinationURL error:nil];
//        
//        NSLog(@"%@", [[NSURL fileURLWithPath:DataPath1] description]);
//        NSLog(@"%@", destinationURL.description);
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Start "
                              message:@"iCloud key-value store change detected"
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil];
        [alert show];
        
        
        
    } else {
        NSLog(@"No iCloud access");
    }
     */
    // ------------------------------
    
    
//    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]) {
//        NSLog(@"start");
//    }
    
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]];
    
//    // ------- Start Ansicht -------
//    if (appData.StartAnsichtOn) [self.weekView didSelectButton:appData.StartAnsichtIndex andIndex:nil];
    
    return YES;
}





//- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"devToken=%@",deviceToken);
//    
//    NSString *token = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",
//                       [deviceToken.description substringWithRange: NSMakeRange(1, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(10, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(19, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(28, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(37, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(46, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(55, 8)],
//                       [deviceToken.description substringWithRange: NSMakeRange(64, 8)]];
//    
//    
//    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://jlproduction.de/push/add5.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
//	[request setHTTPMethod:@"POST"];
//    
//    NSString *post =[[NSString alloc] initWithFormat:@"token=%@&name=%@&submit=", token, [UIDevice currentDevice].name];
//	
//	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
//	NSURLResponse *response;
//	NSError *err;
//	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    //
//    
//}
//- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
//    NSLog(@"Error in registration. Error: %@", err);
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://jlproduction.de/push/url5.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];
//	[request setHTTPMethod:@"POST"];
//    
//    NSString *post =[[NSString alloc] initWithFormat:@""];
//	
//	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
//	NSURLResponse *response;
//	NSError *err;
//	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    
//    NSString *respo = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    
//    if (![respo isEqualToString:@""]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:respo]];
//    }
//    else {
//        // https://itunes.apple.com/us/app/myplan-5/id620776357?l=de&ls=1&mt=8
//    }
//      
//}



//-(void) ubiquitousKeyValueStoreDidChange: (NSNotification *)notification
//{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Change detected"
//                          message:@"iCloud key-value store change detected"
//                          delegate:nil
//                          cancelButtonTitle:@"Ok"
//                          otherButtonTitles:nil, nil];
//    [alert show];
//}




//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    NSLog(@"Alert message:");
//}


//- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//	
//	
//	return YES;
//}


//- (void)viewWillAppear:(BOOL)animated {
//    [self.weekMenu viewWillAppear:YES];
//    [self.weekView viewWillAppear:YES];
//}




//- (void)doneIsFirst:(BOOL)isFirstStart {
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 150)];
//    
//    CGRect welcomeLabelRect = contentView.bounds;
//    welcomeLabelRect.origin.y = 20;
//    welcomeLabelRect.size.height = 20;
//    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:19];
//    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
//    welcomeLabel.text = @"MyPlan 5.0.1";
//    welcomeLabel.font = welcomeLabelFont;
//    welcomeLabel.textColor = [UIColor whiteColor];
//    welcomeLabel.textAlignment = NSTextAlignmentCenter;
//    welcomeLabel.backgroundColor = [UIColor clearColor];
//    welcomeLabel.shadowColor = [UIColor blackColor];
//    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
//    [contentView addSubview:welcomeLabel];
//    
//    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
//    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
//    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
//    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
//    
//    if (isFirstStart) infoLabel.text = @"Danke für den Download von MyPlan 5. Falls sie noch Fragen haben können Sie im Menü unter Infos den Support kontaktieren.";
//    else infoLabel.text = @"";
//    
//    
//    infoLabel.numberOfLines = 4;
//    infoLabel.textColor = [UIColor whiteColor];
//    infoLabel.textAlignment = NSTextAlignmentCenter;
//    infoLabel.backgroundColor = [UIColor clearColor];
//    infoLabel.shadowColor = [UIColor blackColor];
//    infoLabel.shadowOffset = CGSizeMake(0, 1);
//    [contentView addSubview:infoLabel];
//    
//    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
//}

//- (void)showAdMessage {
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 150)];
//    
//    CGRect welcomeLabelRect = contentView.bounds;
//    welcomeLabelRect.origin.y = 20;
//    welcomeLabelRect.size.height = 20;
//    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:19];
//    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
//    welcomeLabel.text = @"Werbung?";
//    welcomeLabel.font = welcomeLabelFont;
//    welcomeLabel.textColor = [UIColor whiteColor];
//    welcomeLabel.textAlignment = NSTextAlignmentCenter;
//    welcomeLabel.backgroundColor = [UIColor clearColor];
//    welcomeLabel.shadowColor = [UIColor blackColor];
//    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
//    [contentView addSubview:welcomeLabel];
//    
//    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
//    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
//    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
//    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
//    infoLabel.text = @"Sie können die Werbung unter 'Werbung Entfernen' im Menü mit einem In-App-Purchase in Höhe von 0,89 € deaktivieren.";
//    infoLabel.numberOfLines = 4;
//    infoLabel.textColor = [UIColor whiteColor];
//    infoLabel.textAlignment = NSTextAlignmentCenter;
//    infoLabel.backgroundColor = [UIColor clearColor];
//    infoLabel.shadowColor = [UIColor blackColor];
//    infoLabel.shadowOffset = CGSizeMake(0, 1);
//    [contentView addSubview:infoLabel];
//    
//    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
//}


//- (void)didDeletePersonAtIndex:(int)delIndex {
//    
//    NSMutableArray *Persons = [MainData LoadMain];
//    [Persons removeObjectAtIndex:delIndex];
//    [MainData SaveMain:Persons];
//    
//    if ([Persons count] == 0) { // Letzte Person soll gelöscht werden
//        Persons = [NSMutableArray arrayWithObjects:[Person newPersonWithName:@"Person 1"], nil];
//        [MainData SaveMain:Persons];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Letzte Person wurde gelöscht" message:@"Da Sie die letzte Person gelöscht haben, wurde eine neue, leere Person erstellt." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    
//    AppData *appData = [MainData LoadAppData];
//    appData.selectedPersonID = [[Persons objectAtIndex:0] PersonID];
//    [MainData SaveAppData:appData];
//    
//    [self.weekView reloadViewsWithIndex:0];
//    
//    
//}


//- (void)enablePersonAtIndex:(int)index {
//    AppData *appData = [MainData LoadAppData];
//    NSMutableArray *Persons = [MainData LoadMain];
//    appData.selectedPersonID = [[Persons objectAtIndex:index] PersonID];
//    [MainData SaveAppData:appData];
//}
//- (void)didSelectWeekWithRow:(int)row andPersonRow:(int)row2 {
//    NSMutableArray *Persons = [MainData LoadMain];
//    Person *edit = [Persons objectAtIndex:row2];
//    edit.selectedWeekID = [[edit.Weeks objectAtIndex:row] WeekID];
//    [Persons removeObjectAtIndex:row2];
//    [Persons insertObject:edit atIndex:row2];
//    [MainData SaveMain:Persons];
//    [self.weekView reloadViewsWithIndex:row2];
//    [self.revealSideViewController revealToggleAnimated:YES];
//}
//- (void)didSelectWeekEditWithRow:(int)row andPersonRow:(int)row2 {
//    if (self.weekEdit == nil) self.weekEdit = [[WeekEdit alloc] init];
//    [self.weekView presentViewController:self.weekEdit animated:YES completion:NULL];
//    [self.weekEdit prepareForWeekEditWithWeekIndex:row andPersonIndex:row2];
//}
//- (void)didSelectPersonEditWithRow:(int)row {
//    if (self.personEdit == nil) self.personEdit = [[PersonEdit alloc] init];
//    self.personEdit.delegate = self;
//    [self.weekView presentViewController:self.personEdit animated:YES completion:NULL];
//    [self.personEdit prepareForPersonEditWithWeekIndex:row];
//}
//- (void)didSelectCreateWeek {
//    if (self.weekEdit == nil) self.weekEdit = [[WeekEdit alloc] init];
//    [self.weekView presentViewController:self.weekEdit animated:YES completion:NULL];
//    [self.weekEdit prepareForNewWeek];
//}
//- (void)didSelectAddPerson {
//    if (self.personEdit == nil) self.personEdit = [[PersonEdit alloc] init];
//    self.personEdit.delegate = self;
//    [self.weekView presentViewController:self.personEdit animated:YES completion:NULL];
//    [self.personEdit prepareForNewPerson];
//}
//- (void)didSelectSettingsWithRow:(int)row {
//    if (row == 1) {
//        if (self.mainSettings == nil) self.mainSettings = [[MainSettings alloc] init];
//        self.mainSettings.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.mainSettings.modalPresentationStyle = UIModalPresentationFormSheet;
//        self.mainSettings.delegate = self;
//        [self.weekView presentViewController:self.mainSettings animated:YES completion:NULL];
//    }
//    else if (row == 2) {
//        if (self.backgroundSettings == nil) self.backgroundSettings = [[BackgroundSettings alloc] init];
//        self.backgroundSettings.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.backgroundSettings.modalPresentationStyle = UIModalPresentationFormSheet;
//        self.backgroundSettings.delegate = self;
//        [self.weekView presentViewController:self.backgroundSettings animated:YES completion:NULL];
//    }
//    else if (row == 3) { // Benachrichtigungen
//        if (self.notificationsSettings == nil) self.notificationsSettings = [[NotificationsSettings alloc] init];
//        self.notificationsSettings.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.notificationsSettings.modalPresentationStyle = UIModalPresentationFormSheet;
//        self.notificationsSettings.delegate = self;
//        [self.weekView presentViewController:self.notificationsSettings animated:YES completion:NULL];
//    }
//    else if (row == 4) { // Infos
//        if (self.infoVC == nil) self.infoVC = [[InfoVC alloc] init];
//        self.infoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.infoVC.modalPresentationStyle = UIModalPresentationFormSheet;
//        self.infoVC.delegate = self;
//        [self.weekView presentViewController:self.infoVC animated:YES completion:NULL];
//    }
////    else if (row == 5) { // Hilfe
////        if (self.help == nil) self.help = [[Help alloc] init];
////        self.help.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
////        self.help.modalPresentationStyle = UIModalPresentationFormSheet;
////        self.help.delegate = self;
////        [self.weekView presentViewController:self.help animated:YES completion:NULL];
////    }
//}
//- (void)didSelectPerson:(int)row2 {
//    [self.weekView reloadViewsWithIndex:row2];
//}



//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    if ([url.absoluteString hasSuffix:@"MyPlan4Data"]) {
//        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Abbrechen" destructiveButtonTitle:nil otherButtonTitles:@"MyPlan 4 Daten importieren", nil];
//        really.tag = 11;
//        oppenedURL = url;
//        [self.revealSideViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//        [really showInView:self.weekView.view];
//    }
//	else if (url != nil && [url isFileURL]) {
//        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Abbrechen" destructiveButtonTitle:nil otherButtonTitles:@"Person importieren", nil];
//        really.tag = 10;
//        oppenedURL = url;
//        [self.revealSideViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//        [really showInView:self.weekView.view];
//    }
//	return YES;
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (actionSheet.tag == 10 && buttonIndex == 0)  {
//        Person *newPerson = [MainData copyObject:[MainData LoadPersonFormSend:oppenedURL]];
//        [newPerson newID];
//        
//        NSMutableArray *Persons = [MainData LoadMain];
//        [Persons addObject:newPerson];
//        [MainData SaveMain:Persons];
//        
//        AppData *appData = [MainData LoadAppData];
//        appData.selectedPersonID = [newPerson PersonID];
//        [MainData SaveAppData:appData];
//        [self.weekView reloadViewsWithIndex:(int)[Persons indexOfObject:newPerson]];
//    }
//    else if (actionSheet.tag == 11 && buttonIndex == 0)  {
//        
//        
//        NSMutableArray *mp4Data = [NSMutableArray arrayWithContentsOfURL:oppenedURL];
//        
////        NSLog(@"%@", mp4Data);
//        
//        for (int i = 0; i < [[mp4Data objectAtIndex:0] count]; i++) {
//            NSMutableArray *person = [[mp4Data objectAtIndex:1] objectForKey:[[mp4Data objectAtIndex:0] objectAtIndex:i]];
//            Person *personNew = [[Person alloc] init];
//            
//            personNew.PersonName = [person objectAtIndex:2];                                                      // Set name
//            
//            personNew.selectedWeekID = [person objectAtIndex:3];                                                  // Selected Plan
//            
//            NSMutableArray *catchedHomeworks = [NSMutableArray arrayWithObjects:nil];
//            for (int fcount = 0; fcount < [[[person objectAtIndex:1] objectAtIndex:0] count]; fcount++) {
//                NSMutableArray *fach = [[[person objectAtIndex:1] objectAtIndex:1] objectForKey:[[[person objectAtIndex:1] objectAtIndex:0] objectAtIndex:fcount]];
//                Subject *fachNew = [[Subject alloc] init];
//                
//                fachNew.SubjectName = [[fach objectAtIndex:0] objectAtIndex:0];                                   // Name
//                
//                fachNew.SubjectShort = [[fach objectAtIndex:1] objectAtIndex:0];                                  // Short
//                
//                fachNew.SubjectID = [[[person objectAtIndex:1] objectAtIndex:0] objectAtIndex:fcount];            // ID
//                
//                fachNew.SubjectColor = [UIColor colorWithRed:                                                     // Farbe
//                                        [[[fach objectAtIndex:3] objectAtIndex:0] floatValue] green:              // Farbe
//                                        [[[fach objectAtIndex:3] objectAtIndex:2] floatValue] blue:               // Farbe
//                                        [[[fach objectAtIndex:3] objectAtIndex:2] floatValue] alpha:0.8];         // Farbe
//                
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:0 to:[[fach objectAtIndex:4] objectAtIndex:0]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:1 to:[[fach objectAtIndex:4] objectAtIndex:1]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:2 to:[[fach objectAtIndex:4] objectAtIndex:2]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:3 to:[[fach objectAtIndex:4] objectAtIndex:3]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:4 to:[[fach objectAtIndex:4] objectAtIndex:4]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:5 to:[[fach objectAtIndex:4] objectAtIndex:5]]; // Raum
//                [[fachNew.Infos objectAtIndex:0] changeInfoForDay:6 to:[[fach objectAtIndex:4] objectAtIndex:6]]; // Raum
//                
//                NSLog(@"%@", [[fach objectAtIndex:2] objectAtIndex:0]);
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:0 to:[[fach objectAtIndex:2] objectAtIndex:0]]; // Lehrer
//                NSLog(@"%@", [[fachNew.Infos objectAtIndex:1] getInfoForDay:0]);
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:1 to:[[fach objectAtIndex:2] objectAtIndex:1]]; // Lehrer
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:2 to:[[fach objectAtIndex:2] objectAtIndex:2]]; // Lehrer
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:3 to:[[fach objectAtIndex:2] objectAtIndex:3]]; // Lehrer
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:4 to:[[fach objectAtIndex:2] objectAtIndex:4]]; // Lehrer
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:5 to:[[fach objectAtIndex:2] objectAtIndex:5]]; // Lehrer
//                [[fachNew.Infos objectAtIndex:1] changeInfoForDay:6 to:[[fach objectAtIndex:2] objectAtIndex:6]]; // Lehrer
//                
//                [[fachNew.Infos objectAtIndex:2] changeInfoTo:[[fach objectAtIndex:5] objectAtIndex:0]];          // Notiz
//                
//                for (int ncount = 0; ncount < [[[fach objectAtIndex:6] objectAtIndex:1] count] ; ncount++) {      // Noten
//                    NSMutableArray *note = [[[fach objectAtIndex:6] objectAtIndex:1] objectAtIndex:ncount];       // Noten
//                    Note *noteNew = [[Note alloc] init];                                                          // Noten
//                    noteNew.NoteWert = [[note objectAtIndex:0] floatValue];                                       // Noten
//                    noteNew.NoteWertung = [[note objectAtIndex:1] floatValue];                                    // Noten
//                    noteNew.NoteNotiz = [note objectAtIndex:2];                                                   // Noten
//                    [fachNew.Noten addObject:noteNew];                                                            // Noten
//                }
//                
//                for (int homcount = 0; homcount < [[fach objectAtIndex:7] count]; homcount++) {                   // Homework
//                    NSMutableArray *homework = [[fach objectAtIndex:7] objectAtIndex:homcount];                   // Homework
//                    Homework *homeworkNew = [[Homework alloc] init];                                              // Homework
//                    homeworkNew.HomeworkName = [homework objectAtIndex:0];                                        // Homework
//                    homeworkNew.ConnectedSubjectID = fachNew.SubjectID;                                           // Homework
//                    [catchedHomeworks addObject:homeworkNew];                                                     // Homework
//                }                                                                                                 // Homework
//                
//                [personNew.Subjects addObject:fachNew];                                                           // Einfügen
//            }     // Fächer
//            
//            [personNew.Weeks removeAllObjects];
//            for (int pcount = 0; pcount < [[[person objectAtIndex:0] objectAtIndex:0] count]; pcount++) {
//                NSMutableArray *plan = [[[person objectAtIndex:0] objectAtIndex:1] objectForKey:[[[person objectAtIndex:0] objectAtIndex:0] objectAtIndex:pcount]];
//                Week *planNew = [[Week alloc] init];
//                
//                planNew.WeekName = [[plan objectAtIndex:3] objectAtIndex:0];                                            // Name
//                
//                planNew.WeekID = [[[person objectAtIndex:0] objectAtIndex:0] objectAtIndex:pcount];                     // ID
////                if () personNew.selectedWeekID = planNew.WeekID;                                                              // ID
//                
//                planNew.WeekMaxHoures = (int)[[[plan objectAtIndex:2] objectAtIndex:0] count];                          // Zeiten
//                [planNew.WeekMaxHouresTimes removeAllObjects];                                                          // Zeiten
//                for (int tcount = 0; tcount < [[[plan objectAtIndex:2] objectAtIndex:0] count]; tcount++) {             // Zeiten
//                    MPDate *dateNew = [[MPDate alloc] init];                                                            // Zeiten
//                    dateNew.startHoure = [[[[plan objectAtIndex:2] objectAtIndex:0] objectAtIndex:tcount] intValue];    // Zeiten
//                    dateNew.startMinute= [[[[plan objectAtIndex:2] objectAtIndex:1] objectAtIndex:tcount] intValue];    // Zeiten
//                    dateNew.stopHoure = [[[[plan objectAtIndex:2] objectAtIndex:2] objectAtIndex:tcount] intValue];     // Zeiten
//                    dateNew.stopMinute = [[[[plan objectAtIndex:2] objectAtIndex:3] objectAtIndex:tcount] intValue];    // Zeiten
//                    [planNew.WeekMaxHouresTimes addObject:dateNew];                                                     // Zeiten
//                }                                                                                                       // Zeiten
//                
//                for (int wcount = 0; wcount < 7; wcount++) {                                                            // Stunden
//                    for (int hcount = 0; hcount < [[[plan objectAtIndex:0] objectAtIndex:wcount] count]; hcount++) {    // Stunden
//                        Houre *houreNew = [[Houre alloc] init];                                                         // Stunden
//                        houreNew.HoureSubjectID = [[[plan objectAtIndex:0] objectAtIndex:wcount] objectAtIndex:hcount]; // Stunden
//                        [[[planNew.WeekDurationNames objectAtIndex:wcount] Subjects] addObject:houreNew];               // Stunden
//                    }                                                                                                   // Stunden
//                }                                                                                                       // Stunden
//                
//                [personNew.Weeks addObject:planNew];
//                
//                
//            }    // Pläne
//            
//            personNew.Homeworks = [NSMutableArray arrayWithArray:catchedHomeworks];
//            
//            for (int termincount = 0; termincount < [[person objectAtIndex:4] count]; termincount++) {           // Termine
//                NSMutableArray *termin = [[person objectAtIndex:4] objectAtIndex:termincount];                   // Termine
//                Termin *terminNew = [[Termin alloc] init];                                                       // Termine
//                terminNew.TerminName = [termin objectAtIndex:0];                                                 // Termine
//                terminNew.TerminDate = [termin objectAtIndex:1];                                                 // Termine
//                terminNew.ConnectedSubjectID = [termin objectAtIndex:2];                                         // Termine
//                [personNew.Termine addObject:terminNew];                                                         // Termine
//            }                                                                                                    // Termine
//                        
//            [personNew newID];
//            
//            NSMutableArray *Persons = [MainData LoadMain];
//            [Persons addObject:personNew];
//            [MainData SaveMain:Persons];
//            
//            AppData *appData = [MainData LoadAppData];
//            appData.selectedPersonID = [personNew PersonID];
//            [MainData SaveAppData:appData];
//            [self.weekView reloadViewsWithIndex:(int)[Persons indexOfObject:personNew]];
//        }
//        
//        
//    }
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    [self.weekView viewDidAppear:YES];
//    
//    // ------- Start Ansicht -------
//    AppData *appData = [MainData LoadAppData];
//    if (appData.StartAnsichtOn) [self.weekView didSelectButton:appData.StartAnsichtIndex andIndex:nil];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
