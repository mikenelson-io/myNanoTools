---
external help file: MyNanoTools-help.xml
online version: 
schema: 2.0.0
---

# New-MyNanoImage

## SYNOPSIS
Create a new Nano server image. 

## SYNTAX

```
New-MyNanoImage [-ComputerName] <String> [-Plaintext] <String> [-IPv4Address] <String> [-ConfigData] <String>
 [-DiskPath] <String> [[-SetupCompleteCommand] <String>] [[-CopyPath] <String[]>] [[-DomainName] <String>]
 [-ReuseDomainNode] [[-DomainBlobPath] <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
This command will create a new Nano server disk image using commands from the NanoServerImageGenerator module. Many of the parameters from this command will be passed to the underlying New-NanoServerImage function. 

## EXAMPLES

### Example 1
```
PS C:\> New-MyNanoImage -ComputerName "NFoo" -Plaintext "P@ssw0rd" -IPv4Address "172.16.80.2" -DiskPath "E:\VMdisks" -ConfigData "c:\work\NanoDefaults.psd1" -DomainName "globomantics" -ReuseDomainNode $True
```

Create a Nano server image called NFoo with the given IP address that will belong to the Globomantics domain. An AD computer account for NFoo has already been created. The disk file will be created at E:\VMDisks\Nfoo.vhdx using additional settings from the NanoDefaults.psd1 file.

## PARAMETERS

### -ComputerName
The name of the new Nano server.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigData
The path to the psd1 file with additional configuration information.

You can automate the process more efficiently with a ConfigData file. In fact, this is a required parameter. The psd1 file that might look like this:

```
@{
BasePath = "D:\2016Media\NanoServer"
Edition = "standard"
DeploymentType = "Guest"
InterfaceNameorIndex = "Ethernet"
EnableEMS = $True
EnableRemoteManagementPort = $True
ipV4DNS = "172.16.30.203"
IPv4Subnet = "255.255.0.0"
IPv4Gateway = "172.16.10.254"
EMSPort = 1
EMSBaudRate = 115200
Defender = $True
Clustering = $false
Storage = $False
Containers = $False
Compute = $False
Package = @('Microsoft-NanoServer-Guest-Package','Microsoft-NanoServer-DSC-Package')
}
```
You can use this to set common and default values for your environment. Keys can be any parameter from New-NanoServerImage that isn't specified as a parameter in the New-MyNanoImage function.

The BasePath setting is the folder with the Nanoserver.wim and the Packages folder. The Diskpath setting is where to create the VHDX file. DeploymentType and Edition are also required.

Depending on your configuration you might want to add:
MaxSize
ServicePackages
UnattendPath
Development

With a configuration file you can create settings for different types of Nano installations such as DNS or Containers.

A sample file (nanodefaults.psd1) is included in the module directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -CopyPath
Files to be copied to the root of C: in the new Nano server image.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskPath
The directory for the new file. The disk file will be constructed from the computer name. You only need to specify the DiskPath like D:\VMDisks.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainBlobPath
The path to a saved domain blob for an offline domain join.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainName
The name of an Active Directory domain to join.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv4Address
The IPv4 address for the new Nano server image. There is no validation in this command that the address is correct or available.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Plaintext
The initial Administrator password. You can change this later.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReuseDomainNode
If joining a domain and a matching AD Computer account already exists, then use it instead of the domain blob.

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

### -SetupCompleteCommand
Specifies an array of commands to run after setup completes.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
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

### None


## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[New-NanoServerImage]()
[New-MyNanoVM](New-MyNanoVM.md)
