@isTest
public class AttributesTests2 
{
static testMethod void OBJECTID_get_set()
{
    //Arrange
    integer expected = 1;
    Attributes2 attributes = new Attributes2();
    //Act
    attributes.OBJECTID = 1;
    //Assert
    System.assertEquals(expected, attributes.OBJECTID);
}


static testMethod void RB_NAME_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    Attributes2 attributes = new Attributes2();
    //Act
    attributes.RB_NAME = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, attributes.RB_NAME);
}



}