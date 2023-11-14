public class sampleintegration {
    
    @AuraEnabled
    public static List <String> getselectOptions() {
        /*List < EntityDefinition > objlist = [SELECT  QualifiedApiName FROM EntityDefinition order by QualifiedApiName  ];
        system.debug('Object List::'+objlist);
        return  objlist;*/
        List<String> sObjectList = new List<String>();
        List<String> namedCred = new List<String>();
    for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
    {
        Schema.DescribeSObjectResult sobj = objTyp.getDescribe();
            Set<String> StandardObjects = new Set<String>{'Account','Contact','Opportunity','Lead','Task','Case','Campaign','Contract','Order','Product2','Quote','QuoteLineItem','Task','User','OpportunityLineItem'};
            
            if(sobj.isCustom() || StandardObjects.contains(sobj.getName()))
            {
                String name = objTyp.getDescribe().getName();
                SobjectList.add(name);
            }
        
    }
   
    return sObjectList;
    }
    
    @AuraEnabled
    public static map<string,string> geteobjectfields(string objname){
        system.debug('objname'+objname);
        map<string,string> retrive = new map<string, string>();
        if(objname != '-None-' ){
            if(objname != ''){
            map<string, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objname).getDescribe().fields.getMap();	
            
            for(string fieldName : fieldMap.keySet()){
                retrive.put(fieldName, fieldMap.get(fieldName).getDescribe().getlabel());
            }
            }
        }
        return retrive;
    }
    @AuraEnabled
    public static string getacc(string objname ,list<string> getfields, string devName){
         system.debug('GsheetName'+objname);
        string gurl ;
        integer updstatuscode;
         Map<string,string> gsmap = new map<string,string>();
        
        string fields= string.join(getfields,',');
        system.debug('getaccounts'+fields);
        string getobj = 'Select '+fields+' FROM '+objname;
        list<sobject>  acclist= Database.query(getobj);
      
        map<string,string> retrive = new map<string, string>();
        map<string, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objname).getDescribe().fields.getMap();	
        for(string fieldName : fieldMap.keySet()){
            //retrive.put(fieldName, fieldMap.get(fieldName).getDescribe().getlabel());
            retrive.put(fieldName, fieldName);
        }
        list<string> fieldlabels = new list<string>();
        for(string label : getfields){
            string a = '"'+retrive.get(label)+'"';
            fieldlabels.add(a);
        }
        string  myfieldlabels = string.join(fieldlabels,',');
        
         list<string> jsonlist = new list<string>();
        
        integer nu = getfields.size()-1;
        system.debug('number'+nu);
        for(sobject reclist : acclist){
            for(string s : getfields){
                if(getfields[0] == s){
                    string Result= '["'+(string)reclist.get(s)+'"';
                jsonlist.add(Result);
                }
                else if(getfields[nu] != s){
                     string Result= '"'+(string)string.valueof(reclist.get(s))+'"';
                jsonlist.add(Result);
                }
                else{
                    string Result= '"'+(string)reclist.get(s)+'"]';
                jsonlist.add(Result);
                }
                
            }
        }
        
	
        string  myListStirng = string.join(jsonlist,',');
        
        string jsonst = '{ '+
        '"properties": {'+
        '"title": "'+objname+'",'+
        '"locale": "en_US",'+
        '"autoRecalc": "ON_CHANGE",'+
        '"timeZone": "Etc/GMT",'+
        '"defaultFormat": {'+
          '"backgroundColor": {'+
            '"red": 1,'+
            '"green": 1,'+
            '"blue": 1'+
          '},'+
          '"padding": {'+
            '"top": 2,'+
            '"right": 3,'+
            '"bottom": 2,'+
            '"left": 3'+
         '},'+
          '"verticalAlignment": "BOTTOM",'+
          '"wrapStrategy": "OVERFLOW_CELL",'+
          '"textFormat": {'+
            '"foregroundColor": {},'+
            '"fontFamily": "arial,sans,sans-serif",'+
            '"fontSize": 10,'+
            '"bold": false,'+
            '"italic": false,'+
            '"strikethrough": false,'+
            '"underline": false,'+
            '"foregroundColorStyle": {'+
              '"rgbColor": {}'+
            '}'+
          '},'+
          '"backgroundColorStyle": {'+
            '"rgbColor": {'+
              '"red": 1,'+
              '"green": 1,'+
              '"blue": 1'+
            '}'+
          '}'+
        '},'+
        '"spreadsheetTheme": {'+
          '"primaryFontFamily": "Arial",'+
          '"themeColors": ['+
            '{'+
              '"colorType": "LINK",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.06666667,'+
                  '"green": 0.33333334,'+
                  '"blue": 0.8'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "ACCENT2",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.91764706,'+
                  '"green": 0.2627451,'+
                  '"blue": 0.20784314'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "ACCENT1",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.25882354,'+
                  '"green": 0.52156866,'+
                  '"blue": 0.95686275'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "ACCENT3",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.9843137,'+
                  '"green": 0.7372549,'+
                  '"blue": 0.015686275'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "ACCENT5",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 1,'+
                  '"green": 0.42745098,'+
                  '"blue": 0.003921569'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "TEXT",'+
              '"color": {'+
                '"rgbColor": {}'+
              '}'+
            '},'+
            '{'+
             ' "colorType": "ACCENT6",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.27450982,'+
                  '"green": 0.7411765,'+
                  '"blue": 0.7764706'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "BACKGROUND",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 1,'+
                  '"green": 1,'+
                  '"blue": 1'+
                '}'+
              '}'+
            '},'+
            '{'+
              '"colorType": "ACCENT4",'+
              '"color": {'+
                '"rgbColor": {'+
                  '"red": 0.20392157,'+
                  '"green": 0.65882355,'+
                  '"blue": 0.3254902'+
                '}'+
              '}'+
            '}'+
          ']'+
        '}'+
      '},'+
      '"sheets": ['+
        '{'+
          '"properties": {'+
            '"sheetId": 0,'+
            '"title": "Sheet1",'+
            '"index": 1,'+
            '"sheetType": "GRID",'+
            '"gridProperties": {'+
              '"rowCount": 1000,'+
              '"columnCount": 26'+
            '}'+
          '}'+
        '}'+
  '],'+
                '}';
        map<string,string> gmap = new map<string,string>();
        map<string,string> devmap = new map<string,string>();
        for(google_sheet__c gs : [select id,name,google_Sheet_ext_Id__c,Dev_Name__c from google_sheet__c ]){
            gmap.put(gs.Name ,gs.Name);
            devmap.put(gs.Name,gs.Dev_Name__c);
        }
        if(objname == gmap.get(objname) && devName == devmap.get(objname)){
            google_sheet__c getgs = [select id,name,google_Sheet_ext_Id__c,Dev_Name__c from google_sheet__c where name =:objname AND Dev_Name__c =:devName  limit 1];
            
        //string sheetName = objname;
        //system.debug('sheetName::'+sheetName);
       if(myListStirng != null){
            Http http = new Http();
			HttpRequest request = new HttpRequest();
                request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets/'+getgs.google_Sheet_ext_Id__c+'/values:batchClear?');
            request.setHeader('Accept', 'application/json');
           request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            string jsonstring = '{ '+
                '"ranges": "Sheet1"}';	
			
            request.setBody(jsonstring);
            HttpResponse res = http.send(request);
            system.debug('statuscode'+res.getStatusCode());
           updstatuscode =res.getStatusCode();
            if(res.getStatusCode() != 200){
                system.debug('new sheet');
               // Http http = new Http();
		//HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        
        request.setBody(jsonst);
        HttpResponse resp = http.send(request);
        system.debug('statuscode'+resp.getStatusCode());
        //system.debug('response'+res.getBody());
        string responsebody = resp.getBody();
        JSONParser parser = JSON.createParser(responsebody);
        system.debug('nexttoken'+parser.nextToken());
        //Map<string,string> gsmap = new map<string,string>();
        
        if(parser.getCurrentToken() == JSONToken.START_OBJECT){
            ghseetdata gsd = (ghseetdata)parser.readValueAs(ghseetdata.class);
                    gsmap.put('spreadsheetId',gsd.spreadsheetId);
            		gsmap.put('spreadsheetUrl',gsd.spreadsheetUrl);
            
        }
        system.debug('spreadsheetId'+gsmap.get('spreadsheetId'));
        string spreadsheetUrl = gsmap.get('spreadsheetUrl');
            string spreadsheetId = gsmap.get('spreadsheetId');
         gurl = gsmap.get('spreadsheetId');
                if(myListStirng != null ){
            //Http http = new Http();
			//HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets/'+spreadsheetId+'/values:batchUpdate?');
            request.setHeader('Accept', 'application/json');
           request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            string jsonstring1 ='{ '+
  				'"valueInputOption": "USER_ENTERED",'+
  				'"data": ['+
    			'{'+
                '"range": "Sheet1",'+
  				'"majorDimension": "ROWS",'+
                '"values": [['+myfieldlabels+'],'+myListStirng+' ]'+
                '}]}';
            request.setBody(jsonstring1);
            HttpResponse resc = http.send(request);
            //system.debug('json body'+request.getBody());
            system.debug('statuscode'+resc.getStatusCode());
            
            
            string responsebody1 = resc.getBody();
             
            if(resc.getStatusCode() == 200){
                system.debug('SUCCESS');
                getgs.google_Sheet_ext_Id__c = spreadsheetId;
                getgs.Google_url__c = spreadsheetUrl;
                update getgs;
            }
        }
                
            }
        }
        if(myListStirng != null && updstatuscode == 200 ){
            Http http = new Http();
			HttpRequest request = new HttpRequest();
            
            request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets/'+getgs.google_Sheet_ext_Id__c+'/values:batchUpdate?'); 
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            string jsonstring ='{ '+
  				'"valueInputOption": "USER_ENTERED",'+
  				'"data": ['+
    			'{'+
                '"range": "Sheet1",'+
  				'"majorDimension": "ROWS",'+
                '"values": [['+myfieldlabels+'],'+myListStirng+' ]'+
                '}]}';
            request.setBody(jsonstring);
            HttpResponse res = http.send(request);
            //system.debug('json body'+request.getBody());
            system.debug('statuscode'+res.getStatusCode());
            
            string responsebody1 = res.getBody();
             string responsebody = res.getBody();
        JSONParser parser = JSON.createParser(responsebody);
        system.debug('nexttoken'+parser.nextToken());
        //Map<string,string> gsmap = new map<string,string>();
        
        if(parser.getCurrentToken() == JSONToken.START_OBJECT){
            ghseetdata gsd = (ghseetdata)parser.readValueAs(ghseetdata.class);
                    gsmap.put('spreadsheetId',gsd.spreadsheetId);
            		
            
        }
            gurl = gsmap.get('spreadsheetId');
            system.debug('spreadsheetUrl'+gurl);
            if(res.getStatusCode() == 200){
                system.debug('SUCCESS');
            }
        }
        }
        
        else if(objname != gmap.get(objname) || devName != devmap.get(devName)){       
        Http http = new Http();
		HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        
        request.setBody(jsonst);
        HttpResponse resp = http.send(request);
        system.debug('statuscode'+resp.getStatusCode());
        //system.debug('response'+res.getBody());
        string responsebody = resp.getBody();
        JSONParser parser = JSON.createParser(responsebody);
        system.debug('nexttoken'+parser.nextToken());
        //Map<string,string> gsmap = new map<string,string>();
        
        if(parser.getCurrentToken() == JSONToken.START_OBJECT){
            ghseetdata gsd = (ghseetdata)parser.readValueAs(ghseetdata.class);
                    gsmap.put('spreadsheetId',gsd.spreadsheetId);
            		gsmap.put('spreadsheetUrl',gsd.spreadsheetUrl);
            
        }
        system.debug('spreadsheetId'+gsmap.get('spreadsheetId'));
        string spreadsheetUrl = gsmap.get('spreadsheetUrl');
            string spreadsheetId = gsmap.get('spreadsheetId');
         gurl = gsmap.get('spreadsheetId');
            
        
        string sheetName = objname;
        system.debug('sheetName::'+sheetName);
       
        if(myListStirng != null ){
            //Http http = new Http();
			//HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:'+''+devName+''+'/v4/spreadsheets/'+spreadsheetId+'/values:batchUpdate?');
            request.setHeader('Accept', 'application/json');
           request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            string jsonstring ='{ '+
  				'"valueInputOption": "USER_ENTERED",'+
  				'"data": ['+
    			'{'+
                '"range": "Sheet1",'+
  				'"majorDimension": "ROWS",'+
                '"values": [['+myfieldlabels+'],'+myListStirng+' ]'+
                '}]}';
            request.setBody(jsonstring);
            HttpResponse res = http.send(request);
            //system.debug('json body'+request.getBody());
            system.debug('statuscode'+res.getStatusCode());
            
            
            string responsebody1 = res.getBody();
             
            if(res.getStatusCode() == 200){
                system.debug('SUCCESS');
            }
        }
        
        
        google_sheet__c gsheet = new google_sheet__c();
            gsheet.Name = objname;
            gsheet.google_Sheet_ext_Id__c = spreadsheetId;
            gsheet.Google_url__c = spreadsheetUrl;
            gsheet.Dev_Name__c = devName;
        insert gsheet;
        
        }
system.debug('url'+gurl);        
        return gurl;
        
    }
    
    @AuraEnabled
    public static List<NamedCredential> getCredentials(){
       List<NamedCredential> namedCred = [SELECT Id, DeveloperName,MasterLabel  FROM NamedCredential]; 
        return namedCred;
    }
    
    public class ghseetdata{
        public string spreadsheetId;
        public string spreadsheetUrl;
    }
    
    public class updateSF{
        public string range;
        public string majorDimension;
        public list<list<string>> values;
    }
    
    
}