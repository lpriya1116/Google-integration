public with sharing class googleintegration {
@AuraEnabled(cacheable=true)
 public static List<Contact> getContactList() {
return [SELECT Id, Name, LastName, FirstName, Phone, Email FROM Contact];
    }

 @AuraEnabled
public static String sendDataToGoogleSheets() {
 List<Contact> clist = [SELECT Id, Name, LastName, FirstName, Phone, Email FROM Contact];
List<String> jsonlist = new List<String>();
        
for(Contact cs : clist) {
String sjson = '["' + cs.Id + '","' + cs.Name + '","' + cs.LastName + '","' + cs.FirstName + '","' + cs.Phone + '","' + cs.Email + '"]';
jsonlist.add(sjson);
 }

String myListString = String.join(jsonlist, ',');
if (myListString != null) {
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('callout:GoogleSheetAPI/v4/spreadsheets/1xy8YPLkKgztys463R_RwMQ_ZmowYlEXSXQVoYxk_700/values/Sheet1:append?valueInputOption=RAW');
request.setHeader('Accept', 'application/json');
request.setHeader('Content-Type', 'application/json');
request.setMethod('POST');
            
 String jsonstring = '{ ' +
                '"majorDimension": "DIMENSION_UNSPECIFIED",' +
                '"values": [["ID","Name","LastName","FirstName","Phone","Email"],' + myListString + ' ],' +
                '"range": "Sheet1"}';
                
            request.setBody(jsonstring);
            
            HttpResponse res = http.send(request);
            
            if (res.getStatusCode() == 200) {
                System.debug('SUCCESS');
                return 'SUCCESS';
            } else {
                System.debug('Error sending data to Google Sheets: ' + res.getStatus() + ' ' + res.getBody());
                return 'Error sending data to Google Sheets';
            }
        }
        
        return 'No data to send';
    }
}
