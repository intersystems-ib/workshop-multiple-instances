Class Phonebook.Personal Extends (Phonebook.Contact, %ZEN.DataModel.Adaptor) [ ClassType = persistent, Inheritance = right ]
{

Query AllPersonal2() As %SQLQuery(CONTAINID = 1)
{
SELECT %ID,Active,CellPhone,Email1,HomePhone,Name,Note,OfficePhone,Owner,Pager,Title FROM Personal
}

Query SomePersonal() As %SQLQuery(CONTAINID = 1)
{
SELECT %ID,Active,CellPhone,Email1,HomePhone,Name,Note,OfficePhone,Owner,Pager,Title FROM Personal
}

Property Owner As %String(ZENREADONLY = 1);

Index OwnerIndex On Owner;

Query SelectPersonal() As %SQLQuery(CONTAINID = 1)
{
SELECT %ID,Name,Company->Name AS Company,Title,HomePhone,CellPhone FROM Personal WHERE Active=1
}

Query SelectPersonalByOwner(Owner As %String) As %SQLQuery(CONTAINID = 1)
{
SELECT %ID,Name,Title,OfficePhone,CellPhone,Company->Name AS Company FROM Personal WHERE Owner = :Owner and Active=1
}

Storage Default
{
<Data name="PersonalDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Active</Value>
</Value>
<Value name="3">
<Value>CellPhone</Value>
</Value>
<Value name="4">
<Value>Company</Value>
</Value>
<Value name="5">
<Value>Email1</Value>
</Value>
<Value name="6">
<Value>Email2</Value>
</Value>
<Value name="7">
<Value>HomePhone</Value>
</Value>
<Value name="8">
<Value>Name</Value>
</Value>
<Value name="9">
<Value>Note</Value>
</Value>
<Value name="10">
<Value>OfficePhone</Value>
</Value>
<Value name="11">
<Value>Owner</Value>
</Value>
<Value name="12">
<Value>Pager</Value>
</Value>
<Value name="13">
<Value>Title</Value>
</Value>
</Data>
<DataLocation>^Phonebook.PersonalD</DataLocation>
<DefaultData>PersonalDefaultData</DefaultData>
<IdLocation>^Phonebook.PersonalD</IdLocation>
<IndexLocation>^Phonebook.PersonalI</IndexLocation>
<Property name="Active"/>
<Property name="CellPhone"/>
<Property name="Company"/>
<Property name="CompanyAddress"/>
<Property name="ContactID"/>
<Property name="Email1"/>
<Property name="Email2"/>
<Property name="HomePhone"/>
<Property name="Name"/>
<Property name="Note"/>
<Property name="OfficePhone"/>
<Property name="Owner"/>
<Property name="Pager"/>
<Property name="Title"/>
<StreamLocation>^Phonebook.PersonalS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

