Class Phonebook.Contact Extends (%Persistent, %Populate, %ZEN.DataModel.Adaptor, %XML.Adaptor) [ Abstract, ClassType = "", Inheritance = right ]
{

Property Name As %String(POPSPEC = "Name()");

Index NameIndex On Name;

Property Title As %String(POPSPEC = "Title()");

Property Pager As %String(POPSPEC = "USPhone()");

//Property Company As %String(VALUELIST = ",Acme Industrial,Widget World,Sunnydale Pest Control");

//Property CompanyAddress As %String(POPSPEC = "City()");

Property HomePhone As %String(POPSPEC = "USPhone()");

Property OfficePhone As %String(POPSPEC = "USPhone()");

Property CellPhone As %String(POPSPEC = "USPhone()");

Property Active As %Boolean [ InitialExpression = 1, Required ];

Index ActiveIndex On Active;

Property Email1 As %String;

Property Email2 As %String;

Property Owner As %String;

Property Note As %String(ZENCONTROL = "textarea");

Property Company As Phonebook.Company(ZENSQL = "SELECT ID,Name FROM Phonebook.Company WHERE Name %STARTSWITH ? ORDER BY Name", ZENSQLLOOKUP = "SELECT Name FROM Phonebook.Company WHERE ID = ?");

}

