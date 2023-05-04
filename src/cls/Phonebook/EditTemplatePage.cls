/// Template page for all Edit contact pages
Class Phonebook.EditTemplatePage Extends Phonebook.Template [ Abstract ]
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME;

/// Domain used for localization.
Parameter DOMAIN;

Property deleteMsg As %ZEN.Datatype.caption [ InitialExpression = {$$$Text("OK to delete this record?","Phonebook")} ];

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">

</style>
}

/// This XML block defines the contents of this page.
XData RightSideContents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen" title="">
<vgroup>
<!-- Each Contact Edit subpage uses this pane to set the title and include the dataSource //-->
<pane paneName="HeaderAndSource" />
 <label  enclosingClass="zenLabel" value="Select a contact below or click 'New' to create a new contact." id="emptyMessage"/>
<!-- table of contacts //-->

<tablePane id="ContactTable" OnCreateResultSet="CreateRS"
	valueColumn="ID"
	showZebra="false"
	useKeys="true"
onselectrow="zenPage.rowSelected(zenThis,which);" showRowSelector="false"  
 width="830">
<!-- Columns do not specify which columns to show (the CreateRS does that) //-->
<!-- Instead, they control size and header names //-->
<column colName="ID" width="30"/>
<column colName="Name" width="200" />
<column colName="Title" width="150" />
<column colName="OfficePhone" width="125" header="Work Phone" />
<column colName="CellPhone" width="125" header ="Cell Phone"/>
<column colName="Company" width="200" />
</tablePane>


<html> <br/><H2>Edit</H2></html>
 <!-- form for editing contacts.  All fields start readOnly so that user must select row or click 'new' //-->
 <form controllerId="source" id="editForm" labelPosition="left">
  <hgroup>
  <vgroup cellVAlign="top" valign="top">
  <text label="ID:" id="idText" dataBinding="%id" 
        onblur="zenPage.loadRecord(zenThis.getValue())" value="" readOnly="true" labelClass="ro" />
  <text dataBinding="Name" id="name" label="Name: " readOnly="true" labelClass="ro"/>
  <text dataBinding="Title" id="titleText" label="Title: " readOnly="true" labelClass="ro"/>
  
 <dataCombo id="company" label="Company: " dataBinding="Company" OnCreateResultSet="CreateCompanyRS" 
 displayColumns="2" valueColumn="1" onchange="zenPage.companyChange();" readOnly="true" labelClass="ro"
  sqlLookup="SELECT Name FROM Phonebook.Company WHERE ID = ?"/>
  <textarea id ="companyAddress" label="Company Address: " readOnly="true" labelClass="ro"/>
  </vgroup>
  <spacer width="60px" />
  <vgroup cellVAlign="top" valign="top">
  <text dataBinding="OfficePhone" id="officePhone" label="Work Phone: " readOnly="true" labelClass="ro"/>
  <text dataBinding="HomePhone" id="homePhone" label="Home Phone: " readOnly="true" labelClass="ro"/>
  <text dataBinding="CellPhone" id="cellPhone" label="Cell Phone: " readOnly="true" labelClass="ro"/>
  <text dataBinding="Email1" id="email" label="Email: " readOnly="true" labelClass="ro"/>
  <text id="owner" dataBinding="Owner" label="Owner: " labelClass="ro" readOnly="true" />
  </vgroup>
  </hgroup>
  </form>
 <!-- Buttons are connected to methods working w/ MVC. //-->
  <hgroup>
    <button caption="New" onclick="zenPage.newRecord();" />
    <button caption="Save" id="Save" onclick="zenPage.save();" disabled="true"  />
    <button caption="Delete" onclick="zenPage.deleteItem();" />
</hgroup>
</vgroup>
</pane>
}

/// Method that returns the ResultSet that populates the table.  Each edit subpage implements its own version.
Method CreateRS(Output pSC As %Status, pInfo As %ZEN.Auxiliary.QueryInfo) As %ResultSet [ Abstract ]
{
}

/// Loads the companies from the db
Method CreateCompanyRS(Output pSC As %Status, pInfo As %ZEN.Auxiliary.QueryInfo) As %ResultSet
{
	set pSC = $$$OK
	
	set rs = ##class(%ResultSet).%New("Phonebook.Company:SelectCompanies")
	
	Quit rs
}

/// Takes the id of a contact, and sets the dataSource's modelId
ClientMethod loadRecord(id) [ Language = javascript ]
{
  var controller = zenPage.getComponentById('source');
  controller.setModelId(id);
}

/// Creates a new record and resets the fields.
ClientMethod newRecord() [ Language = javascript ]
{
	var text = zenPage.getComponentById('idText');
  	text.setValue("");
  	
  	var addr = zenPage.getComponentById('companyAddress');
  	addr.setValue("");
  	
  var controller = zenPage.getComponentById('source');
  controller.createNewObject();
  
  	zenPage.unghostSave();
}

/// Save the current contact
ClientMethod save() [ Language = javascript ]
{
  	var form = zenPage.getComponentById('editForm');
  	form.save();
  	var controller = zenPage.getComponentById('source');
	var id = controller.getModelId();
	
	if(zenPage.getComponentById('owner').getValue() == "")
		zenPage.saveContact(id);

	var table = zenPage.getComponentById('ContactTable');
	table.executeQuery(true);
}

/// Each contact subpage overrides this method.
Method saveContact(contactIndex As %Integer) [ Abstract, ZenMethod ]
{
}

ClientMethod deleteItem() [ Language = javascript ]
{
	if (confirm(this.deleteMsg)) {
		var controller = zenPage.getComponentById('source');
		controller.deleteId(controller.getModelId());
	
		var table = zenPage.getComponentById('ContactTable');
		table.executeQuery(true);
		
		zenPage.clearStuff();
		zenPage.ghostSave();
	}
}

/// Used when user cannot interact with form.
ClientMethod ghostSave() [ Language = javascript ]
{
	zenPage.getComponentById('Save').setProperty('disabled',1);
	zenPage.getComponentById('name').setProperty('readOnly',1);
	zenPage.getComponentById('titleText').setProperty('readOnly',1);
	zenPage.getComponentById('company').setProperty('readOnly',1);
	zenPage.getComponentById('officePhone').setProperty('readOnly',1);
	zenPage.getComponentById('homePhone').setProperty('readOnly',1);
	zenPage.getComponentById('cellPhone').setProperty('readOnly',1);
	zenPage.getComponentById('email').setProperty('readOnly',1);
	zenPage.getComponentById('name').setProperty('labelClass','ro');
	zenPage.getComponentById('titleText').setProperty('labelClass','ro');
	zenPage.getComponentById('company').setProperty('labelClass','ro');
	zenPage.getComponentById('officePhone').setProperty('labelClass','ro');
	zenPage.getComponentById('homePhone').setProperty('labelClass','ro');
	zenPage.getComponentById('cellPhone').setProperty('labelClass','ro');
	zenPage.getComponentById('email').setProperty('labelClass','ro');
}

/// Called to allow the user to interact with the form.
ClientMethod unghostSave() [ Language = javascript ]
{
	zenPage.getComponentById('Save').setProperty('disabled',0);
	zenPage.getComponentById('name').setProperty('readOnly',0);
	zenPage.getComponentById('titleText').setProperty('readOnly',0);
	zenPage.getComponentById('company').setProperty('readOnly',0);
	zenPage.getComponentById('officePhone').setProperty('readOnly',0);
	zenPage.getComponentById('homePhone').setProperty('readOnly',0);
	zenPage.getComponentById('cellPhone').setProperty('readOnly',0);
	zenPage.getComponentById('email').setProperty('readOnly',0);
	zenPage.getComponentById('name').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('titleText').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('company').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('officePhone').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('homePhone').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('cellPhone').setProperty('labelClass','zenLabel');
	zenPage.getComponentById('email').setProperty('labelClass','zenLabel');
}

/// Resets form fields when creating a new contact.
ClientMethod clearStuff() [ Language = javascript ]
{
	zenPage.getComponentById('idText').setValue("");
	zenPage.getComponentById('name').setValue("");
	zenPage.getComponentById('titleText').setValue("");
	zenPage.getComponentById('company').setValue("");
	zenPage.getComponentById('companyAddress').setValue("");
	zenPage.getComponentById('officePhone').setValue("");
	zenPage.getComponentById('homePhone').setValue("");
	zenPage.getComponentById('cellPhone').setValue("");
	zenPage.getComponentById('email').setValue("");
	zenPage.getComponentById('owner').setValue("");
}

/// Enhances the use of arrow keys to navigate the table.
ClientMethod rowSelected(table, which) [ Language = javascript ]
{
	if ('keypress' == which) {
		// defer this action in case the user is arrowing through a number of items
		var id = table.getValue();
		var action = new Function("zenPage.getComponentById('source').setProperty('modelId','"+id+"');"); 
		zenSetDeferredAction(action,200);
		
		var text = zenPage.getComponentById('idText');
  		text.setValue(id);
	}
	else {
		// select immediately
		
  		
		var id = table.getValue();
		var controller = zenPage.getComponentById('source');
		controller.setProperty('modelId',id);
		var text = zenPage.getComponentById('idText');
  		text.setValue(id);
		zenPage.formChange();
	}
  	zenPage.unghostSave();
}

/// When a new contact is selected, this method is called.
ClientMethod formChange() [ Language = javascript ]
{
	zenPage.companyChange();
}

/// Changes the companyAddress field based on the company of the contact.
ClientMethod companyChange() [ Language = javascript ]
{
	var company = zenPage.getComponentById('company');
	if(company.getValue() == "")
	{
		var companyAddress = zenPage.getComponentById('companyAddress');
		companyAddress.setValue("");
	}
	else
	{
		zenPage.loadCompanyAddress(company.getValue());
	}
}

/// loadCompanyAddress
ClassMethod loadCompanyAddress(companyIndex As %Integer) [ ZenMethod ]
{
	&sql(SELECT Address into :Addr FROM Phonebook.Company WHERE ID=:companyIndex)
	
	&js<var addr = zenPage.getComponentById('companyAddress');addr.setValue('#(Addr)#');>
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
	//var hgt = winHeight - hgtTitle - 20;
	var hgt = winHeight - hgtTitle;
	if (divgroupLeft) {
		divgroupLeft.style.height = hgt + 'px';
	}
	if (divgroupRight) {
		divgroupRight.style.height = hgt + 'px';
		divgroupRight.style.width = widRight + 'px';
	}
}

}

