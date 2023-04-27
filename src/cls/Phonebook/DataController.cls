Class Phonebook.DataController Extends (%RegisteredObject, %XML.Adaptor) [ Inheritance = right ]
{

ClassMethod GetCompany(CompanyID As %String) As Phonebook.CompanyData
{
		set dCompany = ##class(Phonebook.ContactFacade).GetCompany(CompanyID)
		quit dCompany
}

ClassMethod GetContact(ContactID As %String) As Phonebook.ContactData
{
		Set dContact = ##class(Phonebook.ContactFacade).GetContact("Personal",ContactID)
		quit dContact
}

ClassMethod GetPersonal(ContactID As %String) As Phonebook.ContactData
{
	Set dContact=##class(Phonebook.ContactFacade).GetPersonal(ContactID)
	quit dContact
}

ClassMethod GetVendor(ContactID As %String) As Phonebook.ContactData
{
	Set dContact=##class(Phonebook.ContactFacade).GetVendor(ContactID)
	quit dContact
}

ClassMethod GetCustomer(ContactID As %String) As Phonebook.ContactData
{
	Set dContact=##class(Phonebook.ContactFacade).GetCustomer(ContactID)
	quit dContact
}

ClassMethod SaveContact(dContact As Phonebook.ContactData) As %String
{
	Set ContactID = ##class(Phonebook.ContactFacade).SaveContact(dContact)
	quit ContactID
}

ClassMethod SavePersonal(dContact As Phonebook.ContactData) As %String
{
	Set ContactID=##class(Phonebook.ContactFacade).SavePersonal(dContact)	
	quit ContactID
}

ClassMethod SaveCustomer(dContact As Phonebook.ContactData) As %String
{

	Set ContactID=##class(Phonebook.ContactFacade).SaveCustomer(dContact)	
	quit ContactID
}

ClassMethod SaveVendor(dContact As Phonebook.ContactData) As %String
{

	Set ContactID=##class(Phonebook.ContactFacade).SaveVendor(dContact)	
	quit ContactID
}

ClassMethod SearchCustomerByName(name As %String, owner As %String) As Phonebook.ContactData
{
	set dContact=##class(Phonebook.ContactFacade).CustomerByName(name, owner)
	quit dContact
}

ClassMethod SearchVendorByName(name As %String, owner As %String) As Phonebook.ContactData
{
	set dContact=##class(Phonebook.ContactFacade).VendorByName(name, owner)
	quit dContact
}

ClassMethod SearchPersonalByName(name As %String, owner As %String) As Phonebook.ContactData
{
	set dContact=##class(Phonebook.ContactFacade).PersonalByName(name,owner)
	quit dContact
}

ClassMethod GetCompanies() As %ListOfObjects
{
	set list = ##class(Phonebook.ContactFacade).GetCompanies()
	quit list
}

}

