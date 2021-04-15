Get-CimInstance Win32_NetworkAdapterConfiguration |
 Where-Object IPEnabled -EQ "True" |
    Select-Object -Property @{n ="Description";e={$_.Description}},
        @{n = "Index"; e={$_.Index}},
        @{n = "IP Address"; e={$_.ipaddress}},
        @{n = "Subnet Mask"; e={$_.Ipsubnet}},
        @{n = "DNS Name"; e={$_.dnsdomain}},
        @{n = "DNS Server"; e={$_.DNSServersearchorder}}|
Format-Table
         

                            