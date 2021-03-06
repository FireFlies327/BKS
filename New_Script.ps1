Import-Module ActiveDirectory

Import-Csv "C:\New_users.csv" | ForEach-Object {
$userPrincinpal = $_."samAccountName" + "@faculty.ru"
New-ADGroup $_."Group" -GroupCategory Security -GroupScope Global -Verbose
New-ADUser -Name $_.Name -Path $_."ParentOU" -samAccountName $_."samAccountName" -UserPrincipalName $userPrincinpal -AccountPassword (ConvertTo-SecureString $_."Password" -AsPlainText -Force) -Enabled $true -EmailAddress $_."EmailAddress" -Surname $_.Surname -Verbose 
Add-ADGroupMember $_."Group" $_."samAccountName" -Verbose

}