/// Created using the page template: Default
Class Phonebook.EditPersonal Extends Phonebook.EditTemplatePage
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME = "Edit Personal";

/// Domain used for localization.
Parameter DOMAIN;

Parameter ERRORPAGE = "/csp/samples/error.csp";

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
</style>
}

/// This XML block defines the contents of this page.
XData HeaderAndSource [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">

<html id="pageHeader"><H2>Personal Contacts</H2> <br/></html>
<dataController id="source" modelClass="Phonebook.Personal" modelId="" />


</pane>
}

Method CreateRS(Output pSC As %Status, pInfo As %ZEN.Auxiliary.QueryInfo) As %ResultSet
{
	set pSC = $$$OK
	
	set rs = ##class(%ResultSet).%New("Phonebook.Personal:SelectPersonalByOwner")
	set pInfo.parms(1) = $USERNAME
	
	Quit rs
}

Method saveContact(contactIndex As %Integer) [ ZenMethod ]
{
	set UN = $USERNAME
	&sql(UPDATE Phonebook.Personal set Owner=:UN WHERE ID=:contactIndex)
}

}

