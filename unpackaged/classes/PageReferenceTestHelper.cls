public with sharing class PageReferenceTestHelper 
{
	public PageReferenceTestHelper() 
	{
		
	}

	public static void Assert(PageReference expected, PageReference actual)
	{
		system.assertEquals(expected == null, actual == null, 'One Page isn\'t null');
		system.assertEquals(expected != null, actual != null, 'One Page isn\'t non-null.');
		if(expected != null && actual != null)
		{
			system.assertEquals(expected.getAnchor(), actual.getAnchor(), 'Anchor');
			system.assertEquals(expected.getURL() , actual.getURL(), 'URL');
			system.assertEquals(expected.getRedirect(), actual.getRedirect(), 'Redirect');
			system.assertEquals(expected.getCookies(), actual.getCookies(), 'Cookies');
			system.assertEquals(expected.getHeaders(), actual.getHeaders(),'Headers');
			system.assertEquals(expected.getParameters(), actual.getParameters(), 'Parameters');
		}
  }
}