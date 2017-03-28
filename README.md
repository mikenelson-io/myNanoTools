# MyNanoTools
A PowerShell module with commands for working with Nano server images.

The module contains these commands

* New-MyNanoImage
* New-MyNanoVM


You might use the module like this:

```
New-MyNanoImage -ComputerName "NFoo" -Plaintext P@ssw0rd -IPv4Address "172.16.80.2" -DiskPath E:\disks -ConfigData .\NanoDefaults.psd1 | 
New-MyNanoVM -Path E:\VMs -SwitchName DomainNet -MemoryStartupBytes 1GB
```

*last updated March 28, 2017*
