Class Phonebook.Facade Extends (%RegisteredObject, %XML.Adaptor) [ Inheritance = right ]
{

ClassMethod GetPersonals() As Phonebook.ContactList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set rs=##class(%ResultSet).%New("Phonebook.Personal:Extent")
	do rs.Execute()
	While (rs.Next()){
		
		Set contact = ##class(Phonebook.ContactFacade).GetContact(rs.Data("ID"))
		Do list.Insert(contact)
		
	}
	
	quit list
}

ClassMethod GetVendors() As Phonebook.ContactList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set rs=##class(%ResultSet).%New("Phonebook.Vendor:Extent")
	do rs.Execute()
	While (rs.Next()){
		
		Set contact = ##class(Phonebook.ContactFacade).GetContact(rs.Data("ID"))
		Do list.Insert(contact)
		
	}
	
	quit list
}

ClassMethod GetCustomers() As Phonebook.ContactList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set rs=##class(%ResultSet).%New("Phonebook.Customer:Extent")
	do rs.Execute()
	While (rs.Next()){
		
		Set contact = ##class(Phonebook.ContactFacade).GetContact(rs.Data("ID"))
		Do list.Insert(contact)
		
	}
	
	quit list
}

ClassMethod SavePersonals(list As Phonebook.ContactList)
{
	
	for i=1:1:list.Count()
	{
		
		set contact = list.GetAt(i)
		do ##class(Phonebook.ContactFacade).SavePersonal(contact)
				
		
	}
}

ClassMethod SaveVendors(list As Phonebook.ContactList)
{
	
	for i=1:1:list.Count()
	{
		
		set contact = list.GetAt(i)
		do ##class(Phonebook.ContactFacade).SaveVendor(contact)
				
		
	}
}

ClassMethod SaveCustomers(list As Phonebook.ContactList)
{
	
	for i=1:1:list.Count()
	{
		
		set contact = list.GetAt(i)
		do ##class(Phonebook.ContactFacade).SaveCustomer(contact)
				
		
	}
}

ClassMethod GetCompanies() As Phonebook.ObjectList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set rs=##class(%ResultSet).%New("Phonebook.Company:Extent")
	do rs.Execute()
	While (rs.Next()){
		
		Set contact = ##class(Phonebook.ContactFacade).GetCompany(rs.Data("ID"))
		Do list.Insert(contact)
		
	}
	
	quit list
}

}

