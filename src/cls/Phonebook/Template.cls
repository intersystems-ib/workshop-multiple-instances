/// Main template page for all pages in the Phonebook App
Class Phonebook.Template Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME;

/// Domain used for localization.
Parameter DOMAIN;

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
.vmenuTable {
	border: 0px;
  padding: 0px;
  margin: 3px;
}

a.menuItem {
	   display: block;
   width: 9em;
   text-align: left;
   color: black;
   border: 0px;
   font-weight: bold;
   font-size: 1.25em;
  padding: 0px;
  margin: 3px;

}

a.menuItemDisabled  {
	display: block;
   width: 9em;
   text-align: left;
   color: grey;
   border: 0px;
   font-weight: bold;
   font-size: 1.25em;
   text-decoration: none;
  padding: 0px;
  margin: 3px;

}
	
a.menuItem:hover {
  background-color: #AAAAAA;
  border: 0px;
  padding: 0px;
  margin: 3px;
}
</style>
}

/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" xmlns:phonebook="http://www.intersystems.com/phonebook" title="RoloCube v2.5">
<html id="title" OnDrawContent="DrawTitle"/>
<hgroup id="hgroup" width="100%">
<vgroup id="groupLeft">
<!-- put contents of left column here -->
<!-- Side menu contains links to other pages //-->
<vmenu id="sideMenu" caption ="Main Menu">
	<menuItem id="homeMenuItem" caption="Home" link="Phonebook.AllStart.cls"/>
	<menuItem id="personalMenuItem" caption="Personal" link="Phonebook.EditPersonal.cls"/>
	<menuItem id="customerMenuItem" caption="Customer" link="Phonebook.EditCustomer.cls" />
	<menuItem id="vendorMenuItem" caption="Vendor" link="Phonebook.EditVendor.cls" />
	<menuItem id="logoutMenuItem" caption="Logout" link="javascript:zenPage.logout();" />
	</vmenu>

</vgroup>
<vgroup id="groupRight">
<!-- put contents of right column here -->
<spacer height="10px" />
<hgroup>
<spacer width="20px" />
<!-- This pane is implemented in all subpages //-->
<pane paneName="RightSideContents" />
</hgroup>
</vgroup>
</hgroup>
</page>
}

/// Called when user clicks logout menu item. Logs user out (ends session) and returns to login page.
ClientMethod logout() [ Language = javascript ]
{
	zenPage.ServerLogout();
	zenPage.gotoPage("Phonebook.AllStart.cls");
}

Method ServerLogout() As %Status [ ZenMethod ]
{
	s %session.EndSession = 1
	q $$$OK
}

/// Draws the title using the page's name
Method DrawTitle(pSeed As %String) As %Status
{
	&html<RoloCube v2.5<br/>#($ZCVT(..#PAGENAME,"O","HTML"))#>
	q $$$OK
}

Method %OnAfterCreatePage() As %Status
{
	//if user has U:PersonalOnly and is not a member of %All
	//Then disable the customer and vendor menus
	if ($System.Security.Check("PersonalOnly","Use") & ($Roles '[ "%All"))
	{
		set cMenu = %page.%GetComponentById("customerMenuItem")
		set vMenu = %page.%GetComponentById("vendorMenuItem")
		 If '$IsObject(cMenu) {
    		Quit $$$OK
  		}
		 If '$IsObject(vMenu) {
    		Quit $$$OK
  		}

		set cMenu.disabled = 1
		set vMenu.disabled = 1
	}
	Quit $$$OK
}

/// This method is called when this page is resized.
/// In response to a resize, we use JavaScript to dynamically
/// resize the 2 main groups on this page.
/// You can modify this method to meet your needs.
ClientMethod onlayoutHandler(load) [ Language = javascript ]
{
	// find enclosing div for the title (if present) and get its height
	var title = zenPage.getComponentById('title');
	var divTitle = title ? title.getEnclosingDiv() : null;
	var hgtTitle = divTitle ? parseInt(divTitle.offsetHeight) : 0;
	// find the enclosing divs for the 2 groups
	var groupLeft = zenPage.getComponentById('groupLeft');
	var groupRight = zenPage.getComponentById('groupRight');
	var divgroupLeft = groupLeft ? groupLeft.getEnclosingDiv() : null;
	var divgroupRight = groupRight ? groupRight.getEnclosingDiv() : null;
	// find height of window
	var winHeight = zenGetWindowHeight();
	var winWidth = zenGetWindowWidth();
	// adjust the size of groups
	var widLeft = divgroupLeft ? parseInt(divgroupLeft.offsetWidth) : 0;
	var widRight = winWidth - widLeft;
	var hgt = winHeight - hgtTitle - 20;
	if (divgroupLeft) {
		divgroupLeft.style.height = hgt + 'px';
	}
	if (divgroupRight) {
		divgroupRight.style.height = hgt + 'px';
		divgroupRight.style.width = widRight + 'px';
	}
}

}

