public class KnowledgeBaseController 
{
    @AuraEnabled
    public static Knowledge__kav GetArticle(id articleId)
    {
        List<Knowledge__kav> arts = [SELECT Id,Title,Body__c,CreatedDate,LastModifiedDate,CreatedBy.Name, LastModifiedBy.Name FROM Knowledge__kav WHERE PublishStatus='online' AND Id=:articleId];
        return arts[0];        
    }
    
    @AuraEnabled 
    public static Map<string,Map<string, string>> GetChildCategories(string parentCategory) 
	{
        Map<string,Map<string, string>> childCategories = new Map<string,Map<string, string>>();
        List<DescribeDataCategoryGroupStructureResult> lddcgsr = new List<DescribeDataCategoryGroupStructureResult>();
		lddcgsr = getDescribeDataCategoryGroupStructureResults();
        for(DescribeDataCategoryGroupStructureResult ddcgsr : lddcgsr)
        {
            if(ddcgsr.Label == parentCategory)
            {
                for(DataCategory topCategory : ddcgsr.TopCategories)
                {
                    for(DataCategory childCategory : topCategory.childcategories)
                    {
                        Map<String, String> m1 = new Map<String, String>();
                        string parentCategoryName = parentCategory.Replace(' ','_') + '__c';
                        string childCategoryName = childCategory.Name.Replace(' ','_') + '__c';
                        //Complaint_Management__c
                        String template = 'SELECT Id,Title FROM KnowledgeArticleVersion WHERE PublishStatus=\'\'online\'\' WITH DATA CATEGORY {0} BELOW {1}';
                        List<Object> parameters = new List<Object> {parentCategoryName, childCategoryName };
                        string soqlQuery = String.format(template, parameters);                        
                        System.Debug('soqlQuery:  ' + soqlQuery);
                        
                        
                        
                        List<sObject> sobjList = Database.query(soqlQuery);
                        
						for(sObject so : sobjList)
                        {
                            KnowledgeArticleVersion kav = (KnowledgeArticleVersion)so;
                            m1.put(kav.Id,kav.Title);
                        }
                    	childCategories.put(childCategory.Label,m1);
                    }
                }
            }
        }
        System.Debug('childCategories:  ' + childCategories);
        return childCategories;
    }
    
    
    //List<JSONCategory> categories = (List<JSONCategory>)System.JSON.deserialize(JSON.serialize(getDescribeDataCategoryGroupStructureResults());
    private static List<DescribeDataCategoryGroupStructureResult> getDescribeDataCategoryGroupStructureResults()
    {
    	List<DescribeDataCategoryGroupResult> describeCategoryResult;
    	List<DescribeDataCategoryGroupStructureResult> describeCategoryStructureResult;
    	try 
    	{
        	//Making the call to the describeDataCategoryGroups to
        	//get the list of category groups associated
        	List<String> objType = new List<String>();
        	objType.add('KnowledgeArticleVersion');
        	describeCategoryResult = Schema.describeDataCategoryGroups(objType);

        	//Creating a list of pair objects to use as a parameter
        	//for the describe call
        	List<DataCategoryGroupSobjectTypePair> pairs = new List<DataCategoryGroupSobjectTypePair>();

        	//Looping throught the first describe result to create
        	//the list of pairs for the second describe call
        	for(DescribeDataCategoryGroupResult singleResult : describeCategoryResult)
            {
           		DataCategoryGroupSobjectTypePair p = new DataCategoryGroupSobjectTypePair();
           		p.setSobject(singleResult.getSobject());
           		p.setDataCategoryGroupName(singleResult.getName());
           		pairs.add(p);
         	}

        	//describeDataCategoryGroupStructures()
        	describeCategoryStructureResult = Schema.describeDataCategoryGroupStructures(pairs, false);

         	//Getting data from the result
         	for(DescribeDataCategoryGroupStructureResult singleResult : describeCategoryStructureResult)
         	{
            	//Get name of the associated Sobject

            	//Get the name of the data category group
            	singleResult.getName();
	
        	    //Get the top level categories
    	        DataCategory [] toplevelCategories =  singleResult.getTopCategories();

            	//Recursively get all the categories
            	List<DataCategory> allCategories = getAllCategories(toplevelCategories);

            	for(DataCategory category : allCategories) 
                {
               		//Get the name of the category
               		category.getName();
            	}
	        }
        } 
       	catch (Exception e)
       	{

       	}	
        //System.debug(categoryToSubCategoryMap);
        return describeCategoryStructureResult;
   }

   	private  static DataCategory[] getAllCategories(DataCategory [] categories)
    {
        if(categories.isEmpty())
        {
            return new DataCategory[]{};
                } 
        else 
        {
            DataCategory [] categoriesClone = categories.clone();
            DataCategory category = categoriesClone[0];
            DataCategory[] allCategories = new DataCategory[]{category};
                categoriesClone.remove(0);
            categoriesClone.addAll(category.getChildCategories());
            allCategories.addAll(getAllCategories(categoriesClone));
            return allCategories;
        }
    }

    private class JSONCategory
    {
        public String label{set;get;}
        public String name{set;get;}
        public List<TopLevelCategory> topCategories{set;get;}
    }
    
    private class TopLevelCategory
    {
        public List<ChildLevelCategory> childCategories{set;get;}
    }
    
    private class ChildLevelCategory
    {
        public List<ChildLevelCategory> childCategories{set;get;}
        public String label{set;get;}
        public String name{set;get;}
    }
}