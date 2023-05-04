/// Created using the page template: Default
Class Phonebook.EditVendor Extends Phonebook.EditTemplatePage
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME = "Edit Vendor";

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
<pane xmlns="http://www.intersystems.com/zen" title="">
<html id="pageHeader"><H2>Vendor Contacts</H2> <br/></html>
<dataController id="source" modelClass="Phonebook.Vendor" modelId=""/>
</pane>
}

Method CreateRS(Output pSC As %Status, pInfo As %ZEN.Auxiliary.QueryInfo) As %ResultSet
{
	set pSC = $$$OK
	
	set rs = ##class(%ResultSet).%New("Phonebook.Vendor:SelectVendor")
	set pInfo.parms(1) = $USERNAME
	
	Quit rs
}

Method saveContact(contactIndex As %Integer) [ ZenMethod ]
{
	set UN = $USERNAME
	&sql(UPDATE Phonebook.Vendor set Owner=:UN WHERE ID=:contactIndex)
}

}

