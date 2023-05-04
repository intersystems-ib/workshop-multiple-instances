/// Phonebook.PhonebookApp
Class Phonebook.PhonebookApp Extends %ZEN.application
{

/// This is the name of this application.
Parameter APPLICATIONNAME = "RoloCube v2.5";

/// This is the URL of the main starting page of this application.
Parameter HOMEPAGE = "Phonebook.AllStart.Cls";

/// This Style block contains application-wide CSS style definitions.
XData Style
{
<style type="text/css">
#title {
	  float: left;
  width: 100%;
  height: 100px;
  font-family: tahoma;
  font-weight: bold;
  font-size: 1.5em;

  border-bottom: 1px solid #000000;
  border-top: 2px solid #000000;
  padding: .25em;
  padding-left: 130px;  

  background-color: #66CCFF;
  background-image: url('cube_logo_blue.gif');
  background-repeat: no-repeat;
  background-position: .5em;

}

/* group on right-hand side */
#groupRight {
	border-right: 1px solid black;
	background: #96EE96;
	height: 100%;
	overflow: auto;
	padding-left: 20px;
}

#groupLeft {
	  float: left;
  list-style-type: none;

  padding-left: 0px;
  
  border-right: 1px solid #000000;
  border-bottom: 0px solid #000000;
  background-color: #DDDDDD
}


/* Style for even-rows when using zebra styling. */
.tpEven {
	background-color: 66CCFF;
	color: 000000;
}

.tpOdd {
	color: 000000;
}

H2 {
	font-family: tahoma;
  font-weight: bold;
  font-size: 1.5em;
}


.zenLabel {
	font-family: tahoma;
}

#footer {
   float: left;
   clear: left;
   width: 100%;

   padding-left: 1em;

   background-color: #DDDDDD;
   border-top: 1px solid #000000;
   border-bottom: 2px solid #000000;
}
 
p {
	font-family: tahoma;
}

/* Style for labels of read-only fields */
.ro {
	font-family: tahoma;
	color: #888888;
}
/* Wrapper for dropdown of combobox. */
.comboboxDropDown {
	font-family: tahoma;
}
/* Style for textarea. */
.textarea {
	font-family:tahoma;
}
/* Style for button (input). */
.button {
	font-family: tahoma;
	font-size: 1em;
}

.body {
  	font-family: tahoma;
}
</style>
}

}

