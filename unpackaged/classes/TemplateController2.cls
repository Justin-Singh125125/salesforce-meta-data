public with sharing class TemplateController2 {
    
    public string currentLanguage { get; set;}
    
	public TemplateController2() {
		// Sets the headers for IE, don't remove;
        Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=Edge');
        
        /*if(currentLanguage == null){
            currentLanguage = 'en_US';
            string language = ApexPages.currentPage().getHeaders().get('Accept-Language');
            if(language.substring(0,5) == 'en-MX'){ currentLanguage = 'en_MX';}
            system.debug('language: ' + language);
            system.debug('currentLanguage: ' + currentLanguage);
        }
        if(ApexPages.currentPage().getParameters().get('language') != null){
            system.debug('setting language ' + ApexPages.currentPage().getParameters().get('language'));
            if(ApexPages.currentPage().getParameters().get('language') == 'en_MX'){ 
                system.debug('setting spanish');
        		currentLanguage = 'en_MX';
            } else if(ApexPages.currentPage().getParameters().get('language') == 'en_US'){
                system.debug('setting english');
                currentLanguage = 'en_US';
            }
        }*/
	}
    
}