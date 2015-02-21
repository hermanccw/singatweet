//
//  STS3SongUploadService.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-19.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STS3SongUploadService.h"
#import "AFAmazonS3Manager.h"
#import "AFAmazonS3ResponseSerializer.h"

@implementation STS3SongUploadService
- (NSString *)uploadBasePath {
    return @"https://s3.amazonaws.com/ironark-openhouse/";
}

- (void)uploadSongAtLocalPath:(NSString *)localPath {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://ironark-s3-uploader.herokuapp.com/uploadKeys" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *key = [responseObject valueForKey:@"AccessKeyId"];
        NSString *secret = [responseObject valueForKey:@"SecretAccessKey"];
        NSString *sessionToken = [responseObject valueForKey:@"SessionToken"];
        if (!key || !secret) {
//            [[Photo sharedClient] archiveImageForLaterUpload:pathAndData[@"data"] path:pathAndData[@"path"]];
            return;
        }
       
        NSArray *localPathParts = [localPath componentsSeparatedByString:@"/"];
        
        AFAmazonS3Manager *s3Manager = [[AFAmazonS3Manager alloc] initWithAccessKeyID:key secret:secret];
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion;
        s3Manager.requestSerializer.bucket = @"ironark-openhouse";
        s3Manager.requestSerializer.sessionToken = sessionToken;
        [s3Manager.requestSerializer setValue:@"public-read" forHTTPHeaderField:@"x-amz-acl"];
        [s3Manager.requestSerializer setValue:@"audio/m4a" forHTTPHeaderField:@"content-type"];
        [s3Manager putObjectWithFile:localPath destinationPath:[localPathParts lastObject] parameters:nil
                            progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                            }
                             success:^(AFAmazonS3ResponseObject *s3Response) {
                                 NSLog(@"song uploaded to S3");
                             }
                             failure:^(NSError *error) {
                                 NSLog(@"song upload failed: %@", error);
                             }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"key fetch failed: %@", error);
    }];
}
@end
