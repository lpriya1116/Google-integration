public with sharing class produtscontroller {
    @AuraEnabled(cacheable=true)
public static String relatedFiles(Id ProductId){
    List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocument.FileExtension, ContentDocument.LatestPublishedVersion.Title, ContentDocument.LatestPublishedVersion.VersionData
     FROM ContentDocumentLink WHERE LinkedEntityId = :ProductId];
String base64Data;
    if(!contentDocumentLinks.isEmpty()) {
     ContentDocumentLink cdl = contentDocumentLinks[0];
     base64Data = 'data:image/' + cdl.ContentDocument.FileExtension + ';charset=utf-8;base64, ';
     base64Data += EncodingUtil.base64Encode(cdl.ContentDocument.LatestPublishedVersion.VersionData);
    }
    return base64Data;
}
}
