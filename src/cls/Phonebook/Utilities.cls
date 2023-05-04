Class Phonebook.Utilities Extends %RegisteredObject
{

ClassMethod FillEmUp() As %Status
{
	
		Do ##class(Phonebook.Personal).Populate(3,1)
		Do ##class(Phonebook.Vendor).Populate(3,1)
		Do ##class(Phonebook.Customer).Populate(3,1)
		Do ##class(Phonebook.Company).Populate(3,1)
		
		Set company1=##class(Phonebook.Company).%OpenId(1)
		Set company2=##class(Phonebook.Company).%OpenId(2)
		set company3=##class(Phonebook.Company).%OpenId(3)
		
		//for i=1:1:9 {
		for con="Personal","Vendor","Customer" {
			for i=1:1:3 {	
				//Set contact=##class(Phonebook.Contact).%OpenId(i)
				set contact=$zobjclassmethod("Phonebook."_con,"%OpenId",i)
				
				set contact.Owner=$username
			
				if i#3=2
				{
					set contact.Company=company1
					
				}
			
				elseif i#3=1
				{
					set contact.Company=company2
				}
				
				elseif i#3=0
				{
					set contact.Company=company3
				}
			
				
				Do contact.%Save()
			}
		
		}
		
		Quit $$$OK
}

ClassMethod KillEmAll() As %Status
{
	
		Do ##class(Phonebook.Personal).%KillExtent()
		Do ##class(Phonebook.Customer).%KillExtent()
		Do ##class(Phonebook.Vendor).%KillExtent()
		Do ##class(Phonebook.Company).%KillExtent()
		
		 Quit $$$OK
}

/// This method no longer works, because Contact is abstract now.
ClassMethod AssignCompanyNames()
{
	for i=1:1:9
	{
		set contact = ##class(Phonebook.Contact).%OpenId(i)
		
		if (i#3=2)
		{
			set contact.Company="Acme Industrial"
			do contact.%Save()	
		}
		
		if (i#3=1)
		{
			set contact.Company="Sunnydale Pest Control"
			do contact.%Save()	
		}
		
		if (i#3=0)
		{
			set contact.Company="Widget World"
			do contact.%Save()	
		}
		
	}
}

ClassMethod CreateODL()
{
	set filename= "C:\Documents and Settings\denelson\My Documents\Visual Studio Projects\Phonebook3\bin\Debug\SDClasses.odl"
	set classlist="Phonebook.Facade,Phonebook.ContactData,Phonebook.CompanyData,Phonebook.ContactList,Phonebook.ObjectList"
	
	do $System.OBJ.ExportODL(classlist,filename)
}

}

