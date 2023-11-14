public with sharing class multipleintegration {
@AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        
List<String> objectNames = new List<String>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        for (Schema.SObjectType objType : schemaMap.values()) {
            objectNames.add(objType.getDescribe().getLocalName());
        }
        return objectNames;
    }
  @AuraEnabled(cacheable=true)
    public static List<String> getFieldsForObjectName(String objectName) {
        List<String> fieldNames = new List<String>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objType = schemaMap.get(objectName);
        if (objType != null) {
            Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();
            for (String fieldName : fieldMap.keySet()) {
                fieldNames.add(fieldName);
            }
        }
        return fieldNames;
    }

@AuraEnabled
 public static String sendToGoogleSheets(String selectedObject, List<String> selectedFields) {
        String query = 'SELECT';
        for (String field : selectedFields) {
            query += ' ' + field + ',';
        }
        if (query.endsWith(',')) {
            query = query.substring(0, query.length() - 1);
        }
        query += ' FROM ' + selectedObject;

        List<SObject> records = Database.query(query);
        List<List<String>> valuesList = new List<List<String>>();
        List<String> headerRow = new List<String>();
    headerRow.add('Id'); 
    headerRow.addAll(selectedFields);
    valuesList.add(headerRow);


        for (SObject record : records) {
            List<String> recordValues = new List<String>();
            recordValues.add(String.valueOf(record.get('Id')));
            for (String field : selectedFields) {
                recordValues.add(String.valueOf(record.get(field)));
            }
            valuesList.add(recordValues);
        }

        Map<String, Object> payload = new Map<String, Object>{
            'majorDimension' => 'ROWS',
            'values' => valuesList,
            'range' => 'Sheet1'
        };

        String jsonBody = JSON.serialize(payload);

        if (jsonBody != null) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleSheetAPI/v4/spreadsheets/1MKa7hw5N9Y29r9Gg9xXIWXLUfo1-b9U4ZQWbyKocykw/values/Sheet1:append?valueInputOption=RAW');
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);

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
