echo "=>This is information of system hardware:"
function Hardwaredata {
    $sysinfo = Get-CimInstance -Class win32_computersystem |
    foreach{
            New-Object -TypeName psobject -Property @{ Description = $_.Description
                                                       Name = $_.Name
                                                       PrimaryownerName = $_.PrimaryOwnerName
                                                       Domain =$_.Domain
                                                       Model = $_.Model
                                                       Manufacture =$_.Manufacturer
                                                       }
            }| Format-Table Description,Name,PrimaryownerName,Domain,Model,Manufacture
            $sysinfo
 }
 Hardwaredata

 echo "=>This is Name and Version number of operating system:"
 function OSdata{
 $osinfo = Get-CimInstance -ClassName Win32_OperatingSystem |
 foreach {
          New-Object -TypeName psobject -Property @{ Name = $_.Name
                                                     Version = $_.Version
                                                     }
          } | Format-Table Name,Version
           $osinfo
 }
 OSdata


echo "=> Processor description :"

function Processorinfo{
    $proinfo = Get-CimInstance -ClassName Win32_Processor|
    foreach {
            New-Object -TypeName psobject -Property @{ CurrentclockSpeed = $_.CurrentClockSpeed
                                              MaxClockSpeed = $_.MaxClockSpeed
                                              Numberofcores = $_.NumberOfCores
                                              L2CacheSize = $_.L2CacheSize
                                              L3Cachesize = $_.L3CacheSize
                                              }
            } | Format-List
            $proinfo
}
Processorinfo




 echo "=> Summary of RAM Installed :"
 $totalcapacity = 0 
 function sumRAM{
   $ram=Get-CimInstance -ClassName win32_physicalmemory | 
    foreach { 
        new-object -TypeName psobject -Property @{ Description = $_.Description
                                                   "Size(MB)" = $_.Capacity/1mb
                                                   Bank = $_.BankLabel
                                                   Slot = $_.DeviceLocator
                                                    }
                                                    $totalcapacity += $_.Capacity/1mb
            } | Format-Table -AutoSize Descriptio,"Size(MB)",Bank,Slot
            $ram
            echo "Total RAM : ${totalcapacity}MB"
    }
 sumRAM
 Write-Host " "

echo "=> Summary of DiskDrive:"
function DD{
$diskdrives = Get-CIMInstance CIM_diskdrive
  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      } 
  }  Format-Table -AutoSize
   $diskdrives
  }
  DD

 echo "=>Information about Network Adapter:"
 function networkAdpt{
    $netadpt = Get-CimInstance -className Win32_NetworkAdapterConfiguration | Where-Object IPEnabled -EQ "True" |
    foreach{
                New-Object -TypeName psobject -Property @{Description =$_.Description
                                                          Index =$_.Index
                                                          IPAddress=$_.ipaddress
                                                          SubnetMask = $_.Ipsubnet
                                                          DNSName=$_.dnsdomain
                                                          DNSServer=$_.DNSServersearchorder
                                                          }
        }|Format-Table Description,Index,IPAddress, Subnetmask,DNSName,DNSServer
        $netadpt
    }
networkAdpt



echo "=> Information of video Card :"
function ViCard {
    $vidCard = Get-CimInstance -ClassName Win32_VideoController |
    foreach {
            New-Object -TypeName psobject -Property @{Description = $_.Description
                                                      Name = $_.Name
                                                      VideoModeDescription= $_.VideoModeDescription
                                                      Currentverticalresolution = $_.CurrentVerticalResolution
                                                      Currenthorizontalresoluton = $_.CurrentHorizontalResolution
                                                    }
            }  | Format-list Description,Name,VideoModeDescription,Currentverticalresolution,Currenthorizontalresoluton
            $vertical = ($vidCard).currentverticalresolution
            $horizontal = ($vidCard).currenthorizontalresolution 
            echo "this is your current screen resolution is $horizontal * $vertical"
            $vidCard
}
ViCard