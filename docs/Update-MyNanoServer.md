---
external help file: MyNanoTools-help.xml
online version: 
schema: 2.0.0
---

# Update-MyNanoServer

## SYNOPSIS
Get Windows updates on a Nano server installation.

## SYNTAX

```
Update-MyNanoServer [-Computername] <String> [-Credential <PSCredential>] [-ScanOnly] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Get and install Windows updates for a Nano server. This command uses the CIM cmdlets.

## EXAMPLES

### Example 1
```
PS C:\>update-mynanoserver chi-nweb -ScanOnly


KBArticleID    : KB4013418
Description    : Install this update to resolve issues in Windows. For a 
                 complete listing of the issues that are included
                 in this update, see the associated Microsoft Knowledge Base 
                 article for more information. After you install this item, 
                 you may have to restart your computer.
MsrcSeverity   :
RevisionNumber : 200
Title          : Update for Windows Server 2016 for x64-based Systems (KB4013418)
UpdateID       : 025c4f16-fea1-4ea9-91fd-32209b4d8998
PSComputerName : chi-nweb

KBArticleID    : KB4015438
Description    : Install this update to resolve issues in Windows. For a 
                 complete listing of the issues that are included
                 in this update, see the associated Microsoft Knowledge Base 
                 article for more information. After you install this item, 
                 you may have to restart your computer.
MsrcSeverity   :
RevisionNumber : 200
Title          : Cumulative Update for Windows Server 2016 for x64-based Systems (KB4015438)
UpdateID       : a69e4d69-0a50-4e79-a814-4b809d392071
PSComputerName : chi-nweb
```

Scan the specified computer for available updates but don't install the.

### Example 2
```
PS C:\>update-mynanoserver chi-nweb -credential $cred
```

Install updates using alternate credentials.
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
An alternate credential for the remote CIM connection.

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

### -ScanOnly
Don't install any updates, list them only.

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
[Get-CimInstance]()
