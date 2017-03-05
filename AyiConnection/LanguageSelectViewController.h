//
//  LanguageSelectViewController.h
//  AyiConnection
//
//  Created by JCB on 3/3/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LangaugeProtocol <NSObject>

- (void)selectLanguages:(NSMutableArray*)languageArray;

@end

@interface LanguageSelectViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *languages;
@property (nonatomic) NSMutableArray *selectedLanguages;
@property (nonatomic, assign) id<LangaugeProtocol> delegate;

@end

@interface LanguageCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIButton *btnCheck;
@property (nonatomic, weak) IBOutlet UILabel *lblName;

@end
