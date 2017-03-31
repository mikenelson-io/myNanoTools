---
external help file: MyNanoTools-help.xml
online version: 
schema: 2.0.0
---

# Test-IsNanoServer

## SYNOPSIS
Test if a computer is a Nano server installation.

## SYNTAX

```
Test-IsNanoServer [-Computername] <String[]> [[-Credential] <PSCredential>] [-Quiet]
```

## DESCRIPTION
Test if a given computer is a Nano server installation.

## EXAMPLES

### Example 1
```
PS C:\>  test-isnanoserver chi-dc04,chi-p50,chi-nweb

Computername Caption                                  OperatingSystemSKU IsNano
------------ -------                                  ------------------ ------
CHI-DC04     Microsoft Windows Server 2012 Datacenter                  8  False
CHI-P50      Microsoft Windows Server 2016 Datacenter                  8  False
CHI-NWEB     Microsoft Windows Server 2016 Standard                  144   True
```

### Example 2
```
PS C:\> 'chi-dc04','chi-p50','chi-nweb' | where {Test-IsNanoServer $_ -quiet -credential $cred}
chi-nweb
```

Filter a list of computer names to get only Nano servers.

## PARAMETERS

### -Computername
Enter a computer name to test

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential
An alternate credential for the remote server connection.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet
Suppress normal output and return either True or False.

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

## INPUTS

### System.String[]


## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Get-CimInstance]()
