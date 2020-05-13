public with sharing class Layout2017Controller {
    public Layout2017Controller() {
        // Sets the headers for IE, don't remove;
        Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=Edge');
        
        
        string headerdata= ApexPages.currentPage().getHeaders().get('Host');
        string urlvalue=Apexpages.currentPage().getUrl();
        string url='https://' + headerdata+ urlvalue;
        System.Debug(url);
        
    }
}