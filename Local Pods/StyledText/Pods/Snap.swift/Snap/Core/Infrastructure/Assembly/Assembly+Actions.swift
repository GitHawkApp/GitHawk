import Foundation

extension Assembly {
  var extractViewImage: ExtractViewImage {
    return ExtractViewImage(
      saveImageToDisk: saveImageToDisk,
      addAttachment: addAttachment
    )
  }
  
  private var saveImageToDisk: SaveImageToDisk {
    return SaveImageToDisk(
      environment: environment,
      fileManager: fileManager
    )
  }
  
  var compareImages: CompareImages {
    return CompareImages(
      fileManager: fileManager,
      addAttachment: addAttachment,
      saveImageToDisk: saveImageToDisk
    )
  }
  
  private var addAttachment: AddAttachment {
    return AddAttachment()
  }
}
