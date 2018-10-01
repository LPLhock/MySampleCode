//
//  JSDClassReusingCell.m
//  JSDUITableViewReuseMethods
//
//  Created by Jersey on 2018/10/1.
//  Copyright © 2018年 Jersey. All rights reserved.
//

#import "JSDClassReusingCell.h"

@implementation JSDClassReusingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
     self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
 
    return self;
}

@end
