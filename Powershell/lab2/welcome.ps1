#lab 2 COMP2101 welcome script for profile
#

write-output "welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."