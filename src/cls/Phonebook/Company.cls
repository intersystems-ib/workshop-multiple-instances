Class Phonebook.Company Extends (%Persistent, %Populate, %XML.Adaptor, %ZEN.DataModel.Adaptor) [ Inheritance = right ]
{

Property Name As %String(POPSPEC = "Company()");

Index NameIndex On Name;

Property Address As %String(POPSPEC = "Street()");

Query SelectCompanies() As %SQLQuery(CONTAINID = 1)
{
	SELECT %ID,Name,Address FROM Company
}

Storage Default
{
<Data name="CompanyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Address</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^Phonebook.CompanyD</DataLocation>
<DefaultData>CompanyDefaultData</DefaultData>
<IdLocation>^Phonebook.CompanyD</IdLocation>
<IndexLocation>^Phonebook.CompanyI</IndexLocation>
<Property name="Address"/>
<Property name="Name"/>
<StreamLocation>^Phonebook.CompanyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

