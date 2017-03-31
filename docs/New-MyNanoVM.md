---
external help file: MyNanoTools-help.xml
online version: 
schema: 2.0.0
---

# New-MyNanoVM

## SYNOPSIS
Create a new Nano server virtual machine.

## SYNTAX

```
New-MyNanoVM [-Name] <String> [-VhdPath] <String> -Path <String> [-Memory <String>]
 [-MemoryStartupBytes <Int64>] [-MemoryMaximumBytes <Int64>] [-ProcessorCount <Int32>] -SwitchName <String>
 [-Start] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Use this command to create a new Nano Server Hyper-V virtual machine. It is assumed that you have already created the Nano server disk image file.

## EXAMPLES

### Example 1
```
PS C:\> New-MyNanoVM -name Nfoo -vhdpath e:\vmdisks\nfoo.vhdx -processorcount 2 -switchname Lab
```

Create a new virtual machine called Nfoo using the specified vhdx file. The VM will be configured with default memory settings, 2 processors and assigned to the Lab virtual switch.

### Example 2
```
PS C:\> $imgparam = @{
    ComputerName = "N-SRV1"
    Plaintext = "P@ssw0rd"
    IPv4Address = "172.16.40.2"
    DiskPath = "E:\VMdisks"
    ConfigData = ".\nanoFile.psd1"
    DomainName = "globomantics"
    ReuseDomainNode = $True
}
PS C:\> $vmparam = @{
    Path = "E:\VMs" 
    SwitchName = "DomainNet" 
    MemoryStartupBytes = 1GB
    start = $True
}
PS C:\> New-MyNanoImage @imgparam | New-MyNanoVM @vmparam
```

Create a new virtual image and pipe the output to New-MyNanoVM using the specified parameters.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Memory
Indicated whether you want the virtual machine to use Dynamic or Static memory.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Dynamic, Static

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemoryMaximumBytes
This will be ignored if using Static memory setting.
```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1073741824
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemoryStartupBytes

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 536870912
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name for the new virtual machine. Typically this will be the same as the Nano computername.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
The path where the new virtual machine configuration will be stored. You could use your Hyper-V default location but you would need to explicitly specify it: (get-vmhost).VirtualHardDiskPath

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessorCount
The number of processors for the new virtual machine.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start
Start the virtual machine after configuration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SwitchName
The name of a Hyper-V switch to connect the virtual machine. 

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VhdPath
The path to the VHDX pile

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[New-MyNanoImage](New-MyNanoImage.md)
