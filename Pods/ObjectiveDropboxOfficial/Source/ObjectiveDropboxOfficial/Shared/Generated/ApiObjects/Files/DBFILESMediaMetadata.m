///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBFILESDimensions.h"
#import "DBFILESGpsCoordinates.h"
#import "DBFILESMediaMetadata.h"
#import "DBFILESPhotoMetadata.h"
#import "DBFILESVideoMetadata.h"
#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"

#pragma mark - API Object

@implementation DBFILESMediaMetadata

#pragma mark - Constructors

- (instancetype)initWithDimensions:(DBFILESDimensions *)dimensions
                          location:(DBFILESGpsCoordinates *)location
                         timeTaken:(NSDate *)timeTaken {

  self = [super init];
  if (self) {
    _dimensions = dimensions;
    _location = location;
    _timeTaken = timeTaken;
  }
  return self;
}

- (instancetype)init {
  return [self initWithDimensions:nil location:nil timeTaken:nil];
}

#pragma mark - Serialization methods

+ (NSDictionary *)serialize:(id)instance {
  return [DBFILESMediaMetadataSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary *)dict {
  return [DBFILESMediaMetadataSerializer deserialize:dict];
}

#pragma mark - Description method

- (NSString *)description {
  return [[DBFILESMediaMetadataSerializer serialize:self] description];
}

@end

#pragma mark - Serializer Object

@implementation DBFILESMediaMetadataSerializer

+ (NSDictionary *)serialize:(DBFILESMediaMetadata *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if (valueObj.dimensions) {
    jsonDict[@"dimensions"] = [DBFILESDimensionsSerializer serialize:valueObj.dimensions];
  }
  if (valueObj.location) {
    jsonDict[@"location"] = [DBFILESGpsCoordinatesSerializer serialize:valueObj.location];
  }
  if (valueObj.timeTaken) {
    jsonDict[@"time_taken"] = [DBNSDateSerializer serialize:valueObj.timeTaken dateFormat:@"%Y-%m-%dT%H:%M:%SZ"];
  }

  if ([valueObj isKindOfClass:[DBFILESPhotoMetadata class]]) {
    NSDictionary *subTypeFields = [DBFILESPhotoMetadataSerializer serialize:(DBFILESPhotoMetadata *)valueObj];
    for (NSString *key in subTypeFields) {
      jsonDict[key] = subTypeFields[key];
    }
    jsonDict[@".tag"] = @"photo";
  } else if ([valueObj isKindOfClass:[DBFILESVideoMetadata class]]) {
    NSDictionary *subTypeFields = [DBFILESVideoMetadataSerializer serialize:(DBFILESVideoMetadata *)valueObj];
    for (NSString *key in subTypeFields) {
      jsonDict[key] = subTypeFields[key];
    }
    jsonDict[@".tag"] = @"video";
  }

  return jsonDict;
}

+ (DBFILESMediaMetadata *)deserialize:(NSDictionary *)valueDict {
  if ([valueDict[@".tag"] isEqualToString:@"photo"]) {
    return [DBFILESPhotoMetadataSerializer deserialize:valueDict];
  }
  if ([valueDict[@".tag"] isEqualToString:@"video"]) {
    return [DBFILESVideoMetadataSerializer deserialize:valueDict];
  }

  @throw([NSException
      exceptionWithName:@"InvalidTag"
                 reason:[NSString stringWithFormat:@"Tag has an invalid value: \"%@\".", valueDict[@".tag"]]
               userInfo:nil]);
}

@end