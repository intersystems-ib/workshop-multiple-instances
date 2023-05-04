Class Phonebook.ContactData Extends (%RegisteredObject, %XML.Adaptor) [ Inheritance = right ]
{

Property ContactID As %String;

Property Name As %String;

Property Title As %String;

Property Pager As %String;

//Property Company As %String;

Property Company As Phonebook.CompanyData;

//Property CompanyAddress As %String;

Property HomePhone As %String;

Property OfficePhone As %String;

Property CellPhone As %String;

Property Active As %Boolean;

Property Email1 As %String;

Property Email2 As %String;

Property Owner As %String;

Property Note As %String;

}

