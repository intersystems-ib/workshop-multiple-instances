nohup $IRISSYS/ISCAgentUser start &>/dev/null &
sleep 1
iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
do ##class(%SYSTEM.Process).CurrentDirectory("$PWD")
$@
if '\$Get(sc, 1) do ##class(%SYSTEM.Process).Terminate(, 1)
zn "%SYS"
do ##class(SYS.Container).QuiesceForBundling()
do ##class(Security.Users).UnExpireUserPasswords("*")

do \$SYSTEM.OBJ.Load("/management/PhonebookInstaller.xml", "ck") 
do ##class(Phonebook.Installer).RunInstall()
halt
END

