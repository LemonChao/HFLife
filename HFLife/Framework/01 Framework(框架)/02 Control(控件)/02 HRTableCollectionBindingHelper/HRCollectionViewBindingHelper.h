/*
 此版本暂无太灵活的api开放，不支持多cell以及cell的多段注册，敬请期待...
 */
#import <UIKit/UIKit.h>


typedef void (^CollectionSelectionBlock)(id model);

@interface HRCollectionViewBindingHelper : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray              *_data;
    UICollectionView            *_collectionView;
    UICollectionViewCell        *_templateCell;
    RACCommand                  *_selectCommand;
    CollectionSelectionBlock     _selectBlock;
}

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                          templateCell:(UINib *)nibCell;

+ (instancetype)bindWithCollectionView:(UICollectionView *)collectionView
                            dataSource:(RACSignal *)source
                      selectionCommand:(RACCommand *)command
                 templateCellClassName:(NSString *)classCell;

+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView
                              sourceList:(NSArray *)source
                       didSelectionBlock:(CollectionSelectionBlock)block
                            templateCell:(UINib *)templateCellNib;

+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView
                              sourceList:(NSArray *)source
                       didSelectionBlock:(CollectionSelectionBlock)block
                   templateCellClassName:(NSString *)templateCellClass;

- (void)customInitialization;
- (void)reloadDataWithSourceList:(NSArray *)source;
- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
