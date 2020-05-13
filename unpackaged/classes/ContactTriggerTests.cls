@isTest
private class ContactTriggerTests
{
	@isTest
	static void BeforeInsert_DuplicateEmail_ExcpectException()
	{
		//Arrange
		Account testAccount1 = UnitTestHelper.CreateTestAccount();
		Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'test@test.com');
		try
		{
			//Act
			Test.startTest();
			Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'test@test.com');
			Test.stopTest();
			System.Assert(false);
		}
		catch (Exception ex)
		{
			//Assert
			string message = ex.GetMessage();
			System.Assert(message.Contains('Duplicate Email Address'));
		}		
	}

	@isTest
	static void BeforeUpdate_DuplicateEmail_ExcpectException()
	{
		//Arrange
		Account testAccount1 = UnitTestHelper.CreateTestAccount();
		Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'test@test.com');
		Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'test1@test.com');
		try
		{
			//Act
			testContact2.Email = 'test@test.com';
			Test.startTest();
			update testContact2;
			Test.stopTest();
			System.Assert(false);
		}
		catch (Exception ex)
		{
			string message = ex.GetMessage();
			//Assert			
			System.Assert(message.Contains('You cannot change this email address.  There is already a contact with this email.'));
		}		
	}

	
}