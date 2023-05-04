/// Created using the page template: Column 2
Class Phonebook.AllStart Extends Phonebook.Template
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME = "Home";

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
XData RightSideContents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">

<html id="stuff"  OnDrawContent="PrintStuff" />

</pane>
}

/// PrintStuff
Method PrintStuff(pSeed As %String) As %Status [ ZenMethod ]
{
	&html<<p><table>
	<tr><td><b>Username: </b></td><td> #($USERNAME)#</td></tr>
	<tr><td><b>Roles: </b></td><td> #($ROLES)#</td></tr>
	<tr><td><b>Version: </b></td><td> #($ZV)#</td></tr>
	</table></p>>	
	Quit $$$OK
}

}

