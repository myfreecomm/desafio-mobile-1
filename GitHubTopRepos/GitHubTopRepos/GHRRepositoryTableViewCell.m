//
//  GHRRepositoryTableViewCell.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRRepositoryTableViewCell.h"

#import "GHRGitHubClient.h"

static UIImage* _noPictureUser;

@implementation GHRRepositoryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValuesWithDictionary:(NSDictionary*)dict
{
    self.repositoryName.text = dict[@"name"];
    self.repositoryDescription.text = dict[@"description"];
    
    self.repositoryForkCounter.text = [NSString stringWithFormat:@"%d",[dict[@"forks_count"] intValue]];
    self.repositoryStarCounter.text = [NSString stringWithFormat:@"%d",[dict[@"stargazers_count"] intValue]];
    
    self.repositoryOwnerUsername.text = dict[@"owner"][@"login"];
    
    @synchronized(_noPictureUser)
    {
        if (!_noPictureUser) _noPictureUser = [UIImage imageNamed:@"undefined_user"];
        self.repositoryOwnerPicture.image = _noPictureUser;
    }
    
    [GHRGitHubClient githubUserPictureFromUrlPath:dict[@"owner"][@"avatar_url"] withCompletionHandler:^(UIImage *picture, NSString *error)
    {
        if (!error) self.repositoryOwnerPicture.image = picture;
    }];
}

@end
