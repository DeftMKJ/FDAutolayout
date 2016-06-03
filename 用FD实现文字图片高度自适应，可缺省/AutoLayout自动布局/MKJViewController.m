//
//  MKJViewController.m
//  AutoLayout自动布局
//
//  Created by 宓珂璟 on 16/5/5.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "MKJViewController.h"
#import "MKJTableViewCell.h"
#import "MKJModel.h"
#import <UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>

@interface MKJViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableVieW;
@property (nonatomic,strong) NSMutableArray *dataSource;


@end

static NSString *identify = @"MKJTableViewCell";

@implementation MKJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configModel];
    
    [self.tableVieW registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    
}

- (void)configModel
{
    NSArray *mainImage = @[@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21tYml6LnFwaWMuY24vbW1iaXovMWxuRWx1VGFiMndyaWNtdFI1dlVRREUxeEJEMk5GR1F6TWd2SjdXQnJ4UkpLOG9uU0ZDMDFocWdjOGpVRGJ5bVRnN3daTElaQmV1RGpMMHZKQkZRZ1RBLzA/d3hfZm10PWpwZWc=",@"",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21tYml6LnFwaWMuY24vbW1iaXovajNzenRhSWxiMFlWVFVpYkJFZE1JUjlnUzllQmlha2xaMHFUQ3FCcGo5RFVEZ0JKRDMyeWN2VVc4OVZQMFJpYTJQNnJWVVRNMDJnVVcxVTgzd2NKWWw3OHcvMD93eF9mbXQ9anBlZw==",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cHM6Ly9vNC54aWFvaG9uZ3NodS5jb20vZGlzY292ZXJ5L3c2NDAvYjMzZTY1MDg0YmI1NzViY2E1ODYxNzZhY2M3Y2Q0YWZfNjQwXzY0MF85Mi5qcGc=",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21laWxhcHAucWluaXVjZG4uY29tL0ZpUHdQSXBqS0RtSFNwU0hrNi1SS1laWklDWDY=",@"http://qingdan.img.taowaitao.cn/image.php?ot=aHR0cDovL21laWxhcHAucWluaXVjZG4uY29tL0ZqUGUtSE1CX1d5X1pnUjFkam5zMGxNRWpfeGk="];
    NSArray *sizeArr = @[@"700,486",@"",@"564,575",@"640,640",@"750,750",@"645,968"];
    NSArray *userImage = @[@"http://twt.img.iwala.net/touxiang/56c344acdbb88.jpg",@"http://twt.img.iwala.net/touxiang/56c344a5a1054.jpg",@"http://twt.img.iwala.net/touxiang/56c342284128a.jpg",@"http://twt.img.iwala.net/touxiang/56384670e4787.jpg",@"",@"http://twt.img.iwala.net/touxiang/5638460884c06.jpg"];
    
    NSArray *descArr = @[@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管理会计师法规；建设路口；价格开始；浪费",@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管理会计师法规；建设路口；价格开始；浪费",@"建设路口；价格开始；浪费",@"合理收费价格了快速分解管理会计师法规",@"愤怒的时间发货的收款计划发放贷款结构合理收费价格了快速分解管",@"合理收费价格了快速分解管理会计师法规；建设路口"];
    
    for (NSInteger i = 0; i < 6; i ++)
    {
        MKJModel *model = [[MKJModel alloc] init];
        model.headImageURL = userImage[i];
        model.userName = @"觅克璟";
        model.mainImageURL = mainImage[i];
        if (![sizeArr[i] isEqualToString:@""])
        {
            model.mainWidth = [[sizeArr[i] componentsSeparatedByString:@","][0] floatValue];
            model.mainHeight = [[sizeArr[i] componentsSeparatedByString:@","][1] floatValue];
        }
        else
        {
            model.mainWidth = 0;
            model.mainHeight = 0;
        }
        
        model.desc = descArr[i];
        [self.dataSource addObject:model];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [self configCell:cell indexpath:indexPath];
    return cell;
}

- (void)configCell:(MKJTableViewCell *)cell indexpath:(NSIndexPath *)index
{
    // 获取模型
    MKJModel *model = self.dataSource[index.row];
    __weak typeof(cell) weakCell = cell;
    // 配置用户头像的的图片，以下操作是让图片0-1的渐现的动画
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            weakCell.headImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakCell.headImageView.alpha = 1.0;
            }];
        }
        else
        {
            weakCell.headImageView.alpha = 1.0;
        }
        
    }];
    // 用户名
    cell.userName.text = model.userName;
    // 用户描述
    cell.descLabel.text = model.desc;
    // 当图片存在的时候
    if (![model.mainImageURL isEqualToString:@""])
    {
        // 图片不隐藏
        cell.mainImageView.hidden = NO;
        // 配置主图的方法，同头像
        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
            if (image && cacheType == SDImageCacheTypeNone) {
                weakCell.mainImageView.alpha = 0;
                [UIView animateWithDuration:1.0 animations:^{
                   
                    weakCell.mainImageView.alpha = 1.0;
                }];
            }
            else
            {
                weakCell.mainImageView.alpha = 1.0;
            }
        }];
        // 我们进行等比例计算出刚才那个主图高度的约束
        cell.mainHeightConstraint.constant = (model.mainHeight * 375) / model.mainWidth;
        // 底部描述具体图片底部的约束固定为19
        cell.descTopConstraint.constant = 19;
    }
    else // 图片没有的时候，只显示描述
    {
        // 主要图片隐藏
        cell.mainImageView.hidden = YES;
        // 主图的高度越是为0  其实也代表了隐藏了
        cell.mainHeightConstraint.constant = 0;
        // 底部如果约束还是19的话，会拉的太长，所以咱们让他为0
        cell.descTopConstraint.constant = 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(MKJTableViewCell *cell)
            {
                [self configCell:cell indexpath:indexPath];
            }];
}
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
