/// Created using the page template: Default
Class Phonebook.Login Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "Phonebook.PhonebookApp";

/// Displayed name of this page.
Parameter PAGENAME = "Login";

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
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="RoloCube v2.5">
<html id="title">RoloCube v2.0<br/>Login</html>

<vgroup id="groupRight" height="100%" align="center" cellAlign="center">
<vgroup>
<spacer height="20px" />
<loginForm id="loginForm" >
<text name="CacheUserName" label="Username: " onkeypress="return zenPage.formEnterSubmit(zenThis)" /> <password name="CachePassword" label="Password: " onkeypress="return zenPage.formEnterSubmit(zenThis)" /> <submit caption="Login" action="Login" nextPage="Phonebook.AllStart.cls"/>
</loginForm>

  <spacer height="10px" />
  <html id ="LoginErrorMsg" OnDrawContent="PrintLoginError"/>
</vgroup>

</vgroup>
</page>
}

/// submit the form when an enter is pressed
ClientMethod formEnterSubmit(inThis) [ Language = javascript ]
{

    // Note, this event test is for Internet Explorer Only  
   if (window.event && window.event.keyCode == 13) { 
        var xForm=inThis.getForm();
         if (!xForm){
               //control is not in a form
         }else{
              xForm.submit();
        }
      }
}

Method PrintLoginError(pSeed As %String) As %Status [ ZenMethod ]
{
	if ($get(%request.Data("$ZENLOGINFAILURE", 1)) = 1)
	{
		&html<<font color= "red">Incorrect username or password.  Please try again, or give up.</font>>
	}
	
	q $$$OK
}

}

