---
external help file: MyNanoTools-help.xml
online version: 
schema: 2.0.0
---

# Set-MatchingTimeZone

## SYNOPSIS
Set the virtual machine time zone to match the Hyper-V host.


## SYNTAX

```
Set-MatchingTimeZone [-Computername] <String> [-Credential <PSCredential>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Set the time zone for the Nano server, or any computer, to that of the local host which is presumably the Hyper-V host. This command uses PowerShell remoting to make the change.

## EXAMPLES

### Example 1
```
PS C:\> Set-Matchingtimezone N-SRV8.globomantics.local -credential globomantics\administrator

PSComputerName            Id
--------------            --
N-SRV8.globomantics.local Eastern Standard Time
```

## PARAMETERS

### -Computername
Enter the name of a Nano server to update

```yaml
Type: String
Parameter Sets: (All)
Aliases: cn

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### -Credential
An alternate credential for the remote server connection.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
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

### System.String

## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Get-TimeZone]()
[Set-TimeZone]()
