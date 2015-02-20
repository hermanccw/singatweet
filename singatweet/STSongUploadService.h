//
//  STSongUploadService.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-19.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@protocol STSongUploadService <NSObject>
- (void)uploadSongAtLocalPath:(NSString*)localPath;
@end