#import "EpubViewerPlugin.h"
#import <ethiobook_epub_viewer/ethiobook_epub_viewer-Swift.h>

@implementation EpubViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEpubViewerPlugin registerWithRegistrar:registrar];
}
@end
