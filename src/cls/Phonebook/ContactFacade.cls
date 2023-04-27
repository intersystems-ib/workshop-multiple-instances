Class Phonebook.ContactFacade
{

Parameter MAP As COSEXPRESSION = "$LISTBUILD("""",""Active"",""CellPhone"",""Company"",""Email1"",""Email2"",""HomePhone"",""Name"",""Note"",""OfficePhone"",""Owner"",""Pager"",""Title"")";

ClassMethod CustomerByName(Name As %String, owner As %String) As Phonebook.ContactData
{
	set (StartName,NextName)=" "_$zcvt($zstrip(Name,">W"),"U")
	if '$d(^Phonebook.CustomerI("NameIndex",StartName))
	{
		// find first possible matching name, quit if no match
		set NextName=$o(^Phonebook.CustomerI("NameIndex",StartName))
		quit:($e(NextName,1,$l(StartName))'=StartName) ""
	}
	
	// loop to find first matching name that is also active
	for
	{
		set custID=$o(^Phonebook.CustomerI("NameIndex",NextName,""))	
		set active=$d(^Phonebook.CustomerI("ActiveIndex",1,custID))
		quit:active
		// try the next name
		set custID=0
		set NextName=$o(^Phonebook.CustomerI("NameIndex",NextName))
		quit:($e(NextName,1,$l(StartName))'=StartName)
	}
	
	quit:(custID=0) ""
	set pContact=..GetContact("Customer",custID)
	set dContact=..BuildContact(pContact,custID)
	quit dContact
}

ClassMethod VendorByName(Name As %String, owner As %String) As Phonebook.ContactData
{
	set (StartName,NextName)=" "_$zcvt($zstrip(Name,">W"),"U")
	if '$d(^Phonebook.VendorI("NameIndex",StartName))
	{
		// find first possible matching name, quit if no match
		set NextName=$o(^Phonebook.VendorI("NameIndex",StartName))
		quit:($e(NextName,1,$l(StartName))'=StartName) ""
	}
	
	// loop to find first matching name that is also active
	for
	{
		set vendID=$o(^Phonebook.VendorI("NameIndex",NextName,""))
		set active=$d(^Phonebook.VendorI("ActiveIndex",1,vendID))
		quit:active
		// try the next name
		set vendID=0
		set NextName=$o(^Phonebook.VendorI("NameIndex",NextName))
		quit:($e(NextName,1,$l(StartName))'=StartName)
	}
	
	quit:(vendID=0) ""
	Set pContact=..GetContact("Vendor",vendID)
	set dContact=..BuildContact(pContact,vendID)
	quit dContact
}

ClassMethod PersonalByName(Name As %String, Owner As %String) As Phonebook.ContactData
{
	set (StartName,NextName)=" "_$zcvt($zstrip(Name,">W"),"U")
	if '$d(^Phonebook.PersonalI("NameIndex",StartName))
	{
		// find first possible matching name, quit if no match
		set NextName=$o(^Phonebook.PersonalI("NameIndex",StartName))
		quit:($e(NextName,1,$l(StartName))'=StartName) ""
	}
	
	// loop to find first matching name that is also active
	set map=..#MAP
	for
	{
		set persID=$o(^Phonebook.PersonalI("NameIndex",NextName,""))
		set active=$d(^Phonebook.PersonalI("ActiveIndex",1,persID))
		set pContact=..GetContact("Personal",persID)
		
		// check if owner is valid also
		set owner=$li(pContact,$lf(map,"Owner"))
		quit:(active)&&(owner=Owner)

		// try the next name
		set persID=0
		set NextName=$o(^Phonebook.PersonalI("NameIndex",NextName))
		quit:($e(NextName,1,$l(StartName))'=StartName)
	}

	quit:(persID=0) ""
	Set dContact=..BuildContact(pContact,persID)
	quit dContact
}

ClassMethod GetPersonal(ContactID As %String) As Phonebook.ContactData
{
	Set pContact=..GetContact("Personal",ContactID)
	Set dContact=..BuildContact(pContact,ContactID)
	quit dContact
}

ClassMethod GetVendor(ContactID As %String) As Phonebook.ContactData
{
	Set pContact=..GetContact("Vendor",ContactID)
	Set dContact=..BuildContact(pContact,ContactID)
	quit dContact
}

ClassMethod GetCustomer(ContactID As %String) As Phonebook.ContactData
{
	Set pContact=..GetContact("Customer",ContactID)
	Set dContact=..BuildContact(pContact,ContactID)
	quit dContact
}

ClassMethod GetContact(Type As %String, ContactID As %String) As %String
{
	Set pContact=$case(Type,"Customer":^Phonebook.CustomerD(ContactID),
	                       "Personal":^Phonebook.PersonalD(ContactID),
	                       "Vendor"  :^Phonebook.VendorD(ContactID))
	quit pContact
}

ClassMethod BuildContact(pContact As %String, ContactID As %String) As Phonebook.ContactData
{
	
	Set dContact=##class(Phonebook.ContactData).%New()
	Set dCompany=##class(Phonebook.CompanyData).%New()
	
	set map=..#MAP
	Set dContact.ContactID = ContactID
	Set dContact.Name=$li(pContact,$lf(map,"Name"))
	Set dContact.Title=$li(pContact,$lf(map,"Title"))
	
	Set dContact.HomePhone=$li(pContact,$lf(map,"HomePhone"))
	Set dContact.OfficePhone=$li(pContact,$lf(map,"OfficePhone"))
	Set dContact.CellPhone=$li(pContact,$lf(map,"CellPhone"))
	Set dContact.Email1=$li(pContact,$lf(map,"Email1"))
	Set dContact.Email2=$li(pContact,$lf(map,"Email2"))
	Set dContact.Owner=$li(pContact,$lf(map,"Owner"))
	Set dContact.Note=$li(pContact,$lf(map,"Note"))
	Set dContact.Active=$li(pContact,$lf(map,"Active"))
	Set dContact.Pager = $li(pContact,$lf(map,"Pager"))
	
	if ($li(pContact,$lf(map,"Company"))'="")
	{
		Set CompanyID=$li(pContact,$lf(map,"Company"))
		set dCompany = ##class(Phonebook.ContactFacade).GetCompany(CompanyID)
		set dContact.Company=dCompany
	}
	
	
	quit dContact
}

ClassMethod GetCompany(CompanyID As %String) As Phonebook.CompanyData
{
	set pCompany = ^Phonebook.CompanyD(CompanyID)
	set dCompany = ##class(Phonebook.CompanyData).%New()
	
	set companymap=$lb("","Address","Name")
	set dCompany.CompanyID=CompanyID
	set dCompany.Name=$li(pCompany,$lf(companymap,"Name"))
	set dCompany.Address=$li(pCompany,$lf(companymap,"Address"))
	
	quit dCompany
}

ClassMethod CopyContact(dContact As Phonebook.ContactData) As %String [ PublicList = map ]
{
	
	Set $li(tContact,$lf(map,"Name"))=dContact.Name
	Set $li(tContact,$lf(map,"Title"))=dContact.Title
	Set $li(tContact,$lf(map,"HomePhone"))=dContact.HomePhone
	Set $li(tContact,$lf(map,"OfficePhone"))=dContact.OfficePhone
	Set $li(tContact,$lf(map,"CellPhone"))=dContact.CellPhone
	Set $li(tContact,$lf(map,"Email1"))=dContact.Email1
	Set $li(tContact,$lf(map,"Email2"))=dContact.Email2
	Set $li(tContact,$lf(map,"Owner"))=dContact.Owner
	Set $li(tContact,$lf(map,"Note"))=dContact.Note
	Set $li(tContact,$lf(map,"Active"))=dContact.Active
	Set $li(tContact,$lf(map,"Pager"))=dContact.Pager
	Set $li(tContact,$lf(map,"Company"))=dContact.Company.CompanyID
	quit tContact
}

ClassMethod SavePersonal(dContact As Phonebook.ContactData) As %String [ PublicList = map ]
{
	set map=..#MAP

	set pContactID=dContact.ContactID
	if pContactID'=""
	{
		Set pContact=$g(^Phonebook.PersonalD(pContactID))
	}
	else
	{
		set pContact=""
		set pContactID=$i(^Phonebook.PersonalD)
	}
		
	set tContact=..CopyContact(dContact)
	set (oldname,oldactive,oldowner)=""
	if (pContact'="")
	{
		set oldname=$li(pContact,$lf(map,"Name"))
		set oldname=" "_$zcvt($zstrip(oldname,">W"),"U")
		set oldactive=$li(pContact,$lf(map,"Active"))
		set oldowner=$li(pContact,$lf(map,"Owner"))
		set oldowner=" "_$zcvt($zstrip(oldowner,">W"),"U")
	}
	set newname=$li(tContact,$lf(map,"Name"))
	set newname=" "_$zcvt($zstrip(newname,">W"),"U")
	set newactive=$li(tContact,$lf(map,"Active"))
	set newowner=$li(tContact,$lf(map,"Owner"))
	set newowner=" "_$zcvt($zstrip(newowner,">W"),"U")
	tstart
	set ^Phonebook.PersonalD(pContactID)=tContact
	kill:(oldname'="") ^Phonebook.PersonalI("NameIndex",oldname,pContactID)
	set ^Phonebook.PersonalI("NameIndex",newname,pContactID)=""
	kill:(oldactive'="") ^Phonebook.PersonalI("ActiveIndex",oldactive,pContactID)
	set ^Phonebook.PersonalI("ActiveIndex",newactive,pContactID)=""
	kill:(oldowner) ^Phonebook.PersonalI("OwnerIndex",oldowner,pContactID)
	set ^Phonebook.PersonalI("OwnerIndex",newowner,pContactID)=""
	tcommit
	quit pContactID
}

ClassMethod SaveVendor(dContact As Phonebook.ContactData) As %String [ PublicList = map ]
{
	set map=..#MAP

	set pContactID=dContact.ContactID
	if pContactID'=""
	{
		Set pContact=$g(^Phonebook.VendorD(pContactID))
	}
	else
	{
		set pContact=""
		set pContactID=$i(^Phonebook.VendorD)
	}
		
	set tContact=..CopyContact(dContact)
	set (oldname,oldactive)=""
	if (pContact'="")
	{
		set oldname=$li(pContact,$lf(map,"Name"))
		set oldname=" "_$zcvt($zstrip(oldname,">W"),"U")
		set oldactive=$li(pContact,$lf(map,"Active"))
	}
	set newname=$li(tContact,$lf(map,"Name"))
	set newname=" "_$zcvt($zstrip(newname,">W"),"U")
	set newactive=$li(tContact,$lf(map,"Active"))
	tstart
	set ^Phonebook.VendorD(pContactID)=tContact
	kill:(oldname'="") ^Phonebook.VendorI("NameIndex",oldname,pContactID)
	set ^Phonebook.VendorI("NameIndex",newname,pContactID)=""
	kill:(oldactive'="") ^Phonebook.VendorI("ActiveIndex",oldactive,pContactID)
	set ^Phonebook.VendorI("ActiveIndex",newactive,pContactID)=""
	tcommit
	quit pContactID
}

ClassMethod SaveCustomer(dContact As Phonebook.ContactData) As %String [ PublicList = map ]
{
	set map=..#MAP

	set pContactID=dContact.ContactID
	if pContactID'=""
	{
		Set pContact=$g(^Phonebook.CustomerD(pContactID))
	}
	else
	{
		set pContact=""
		set pContactID=$i(^Phonebook.CustomerD)
	}
		
	set tContact=..CopyContact(dContact)
	set (oldname,oldactive)=""
	if (pContact'="")
	{
		set oldname=$li(pContact,$lf(map,"Name"))
		set oldname=" "_$zcvt($zstrip(oldname,">W"),"U")
		set oldactive=$li(pContact,$lf(map,"Active"))
	}
	set newname=$li(tContact,$lf(map,"Name"))
	set newname=" "_$zcvt($zstrip(newname,">W"),"U")
	set newactive=$li(tContact,$lf(map,"Active"))
	tstart

	set ^Phonebook.CustomerD(pContactID)=tContact
	kill:(oldname'="") ^Phonebook.CustomerI("NameIndex",oldname,pContactID)
	set ^Phonebook.CustomerI("NameIndex",newname,pContactID)=""
	kill:(oldactive'="") ^Phonebook.CustomerI("ActiveIndex",oldactive,pContactID)
	set ^Phonebook.CustomerI("ActiveIndex",newactive,pContactID)=""

	tcommit
	quit pContactID
}

ClassMethod GetCompanies() As Phonebook.CompanyList
{
	
	set list=##class(Phonebook.CompanyList).%New()
	
	set company=""
	While 1
	{
    	Set company=$o(^Phonebook.CompanyI("NameIndex",company))
    	quit:(company="")
    	set ID=$o(^Phonebook.CompanyI("NameIndex",company,""))
    	Set dComp = ..GetCompany(ID)
    	do list.Insert(dComp)
 	}
	
	quit list
}

ClassMethod GetPersonals(owner As %String) As Phonebook.ContactList
{
	set owner = " "_$zcvt($zstrip(owner,">W"),"U")
	Set list = ##class(Phonebook.ContactList).%New()
	Set personal=""
	While 1
	{	
		set personal=$o(^Phonebook.PersonalI("NameIndex",personal))
		quit:(personal="")
		set ID=""
		while 1
		{
			set ID=$o(^Phonebook.PersonalI("NameIndex",personal,ID))
			quit:(ID="")
			continue:('$d(^Phonebook.PersonalI("ActiveIndex",1,ID)))
			continue:('$d(^Phonebook.PersonalI("OwnerIndex",owner,ID)))
			set pContact=..GetContact("Personal",ID)
			Set contact = ..BuildContact(pContact,ID)
			Do list.Insert(contact)
		}
	}
	
	quit list
}

ClassMethod GetVendors(owner As %String) As Phonebook.ContactList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set vendor=""
	While 1
	{	
		set vendor=$o(^Phonebook.VendorI("NameIndex",vendor))
		quit:(vendor="")
		set ID=""
		while 1
		{
			set ID=$o(^Phonebook.VendorI("NameIndex",vendor,ID))
			quit:(ID="")
			continue:('$d(^Phonebook.VendorI("ActiveIndex",1,ID)))
			set pContact=..GetContact("Vendor",ID)
			Set contact = ..BuildContact(pContact,ID)
			Do list.Insert(contact)
		}
	}
	
	quit list
}

ClassMethod GetCustomers(owner As %String) As Phonebook.ContactList
{
	
	Set list = ##class(Phonebook.ContactList).%New()
	Set customer=""
	While 1
	{	
		set customer=$o(^Phonebook.CustomerI("NameIndex",customer))
		quit:(customer="")
		set ID=""
		while 1
		{
			set ID=$o(^Phonebook.CustomerI("NameIndex",customer,ID))
			quit:(ID="")
			continue:('$d(^Phonebook.CustomerI("ActiveIndex",1,ID)))
			set pContact=..GetContact("Customer",ID)
			Set contact = ..BuildContact(pContact,ID)
			Do list.Insert(contact)
		}
	}
	
	quit list
}

}

