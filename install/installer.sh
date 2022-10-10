nohup $IRISSYS/ISCAgentUser start &>/dev/null &
sleep 1
iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
do \$SYSTEM.OBJ.Load("/management/PhonebookInstaller.xml", "ck") 
do ##class(Phonebook.Installer).RunInstall()
halt
END

