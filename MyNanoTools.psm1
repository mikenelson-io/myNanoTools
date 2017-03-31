#requires -version 5.0
#requires -RunAsAdministrator

#creating a domain joined image might require a CredSSP session
#unless you pre-stage an AD computer account 

<#
My Nano images are for lab testing so passwords are not critical. 
You need to set a default password to create the Nano image
but you can always change it later through your own tooling.
#>

Function New-MyNanoImage {

[cmdletbinding(SupportsShouldProcess)]
Param(
[Parameter(Mandatory)]
[alias("name")]
[string]$ComputerName,
[Parameter(Mandatory)]
[ValidateNotNullorEmpty()]
[string]$Plaintex,
[Parameter(Mandatory)]
[ValidateNotNullorEmpty()]
[string]$IPv4Address,
[Parameter(Mandatory)]
[ValidateScript({Test-Path $_})]
[string]$ConfigData,
[Parameter(Mandatory)]
[ValidateScript({Test-Path $_})]
[string]$DiskPath,
[string]$SetupCompleteCommand,
[string[]]$CopyPath,
[string]$DomainName,
[switch]$ReuseDomainNode,
[string]$DomainBlobPath
)

$start = Get-Date

Write-Verbose "Importing values from $ConfigData"
$config = Import-PowerShellDataFile -Path $ConfigData

#add each entry to PSBoundParameters which will eventually be 
#splatted to New-NanoServerImage
foreach ($key in $config.keys) {
    $PSBoundParameters.Add($key,$config.item($key))
}

#remove some parameters that don't belong to New-NanoServerImage
$PSBoundParameters.Remove("DiskPath") | Out-Null
$PSBoundParameters.Remove("ConfigData") | Out-Null
$PSBoundParameters.Remove("Plaintext") | Out-Null

Write-Verbose "Creating a new Nano image for $($Computername.toupper())"
$Target = Join-Path $diskPath -ChildPath "$computername.vhdx"
$secure = ConvertTo-SecureString -String $plainText -AsPlainText -Force

#add to PSBoundParameters
$PSBoundParameters.Add("TargetPath",$target) | Out-Null
$PSBoundParameters.Add("AdministratorPassword",$secure) | Out-Null

Write-Verbose "Using these values"
$PSBoundParameters | Out-String | write-verbose 

if ($PSCmdlet.ShouldProcess($target)) {
    Try {
        $result = New-NanoServerImage @PSBoundparameters -ErrorAction Stop
        #write image path to the pipeline
        [pscustomobject]@{
            Result = $result
            Name = $ComputerName
            VHDPath = $Target
        }
    }
    Catch {
        Write-Warning "Error. $($_.exception.message)"
    }
} #should process

$end = Get-Date
Write-Verbose "Image created in $($end-$Start)"

}

<#
There is probably a better way to organize parameters into 
parameter sets but doing so would break some of my existing 
demos so I will leave this alone for now. 3/31/2017 - JH
#>
Function New-MyNanoVM {
[cmdletbinding(SupportsShouldProcess)]
Param(
[Parameter(Position = 0, Mandatory,ValueFromPipelineByPropertyName)]
[string]$Name,
[Parameter(Position = 1, Mandatory,ValueFromPipelineByPropertyName)]
[string]$VhdPath,
[Parameter(Mandatory)]
[string]$Path,
[ValidateSet("Dynamic","Static")]
[string]$Memory = "Dynamic",
[ValidateNotNullorEmpty()]
[int64]$MemoryStartupBytes = 512MB,
[ValidateNotNullorEmpty()]
#this will be ignored if using Static memory
[int64]$MemoryMaximumBytes = 1GB,
[ValidateScript({$_ -ge 1})]
[int]$ProcessorCount = 1,
[Parameter(Mandatory)]
[ValidateNotNullOrEmpty()]
[string]$SwitchName,
[switch]$Start
)

#create a generation 2 VM
$PSBoundParameters.Add("Generation",2)

#remove parameters that don't belong to New-VM
$PSBoundParameters.Remove("MemoryMaximumBytes") | Out-Null
$PSBoundParameters.Remove("ProcessorCount") | Out-Null
$PSBoundParameters.Remove("Memory") | Out-Null
$PSBoundParameters.Remove("Start") | Out-Null

#create a hashtable of parameters for Set-VM
$set = @{
 MemoryStartupBytes = $MemoryStartupBytes
 ProcessorCount = $ProcessorCount
}

if ($Memory -eq 'Dynamic') {
    $set.Add("DynamicMemory",$True)
    $set.Add("MemoryMaximumBytes", $MemoryMaximumBytes)
    $set.Add("MemoryMinimumBytes", $MemoryStartupBytes)
}
else {
    $set.Add("StaticMemory",$True)   
}

write-verbose "Creating VM with these parameters"
Write-verbose ($PSBoundParameters | Out-String)
$vm = New-VM @PSBoundParameters

Write-verbose "Setting VM with these parameters"
Write-verbose ($set| Out-String)
$vm | Set-VM @set

if ($start) {
    Start-VM $vm
}
}

Function Test-IsNanoServer {
[cmdletbinding()]

Param(
[parameter(
Mandatory,
ValueFromPipeline,
ValueFromPipelineByPropertyName,  
HelpMessage = "Enter a computer name to test"
)]
[Alias("cn")]
[string[]]$Computername,
[PSCredential]$Credential,
[Switch]$Quiet

)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    $PSBoundParameters.Remove("Quiet") | Out-Null
    $PSBoundParameters.Remove("Computername") | Out-Null
} #begin

Process {
    foreach ($Computer in $Computername) {
        Write-Verbose "[PROCESS] Testing $Computer"
        $PSBoundParameters.Computername = $Computer
        Try {
            Write-Verbose "[PROCESS] Creating a temporary CimSession"
            $cs = New-CimSession @PSBoundParameters -ErrorAction Stop
        }
        Catch {
            Write-Warning "Oops. $($_.exception.message)"
        }
        if ($cs) {
            Write-Verbose "[PROCESS] Querying Win32_OperatingSystem"
            $os = $cs | Get-CimInstance Win32_OperatingSystem
            if ($os.OperatingSystemSKU -match "143|144") {
                $IsNano = $True
            }
            else {
                $IsNano = $False
            }
            
            if ($Quiet) {
                $IsNano                
            }
            else {
                $OS | Select-Object @{Name="Computername";Expression={$_.PSComputername.ToUpper()}},
                Caption,OperatingSystemSKU,
                @{Name="IsNano";Expression={$IsNano}}
            }

            Write-Verbose "[PROCESS] Removing temporary CimSession"
            $cs | Remove-CimSession
        }
    }

} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

}

Function Update-MyNanoServer {
[cmdletbinding(SupportsShouldProcess)]
Param(
[Parameter(
Position = 0,
Mandatory,
ValueFromPipeline,
ValueFromPipelineByPropertyName,  
HelpMessage = "Enter the name of a Nano server to update"
)]
[Alias("cn")]
[ValidateNotNullorEmpty()]
[string]$Computername,
[PSCredential]$Credential,
[switch]$ScanOnly
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    $PSBoundParameters.Remove("ScanOnly") | Out-Null
    $ns = "root/Microsoft/windows/WindowsUpdate"
} #begin

Process {
Try {
    Write-Verbose "[PROCESS] Creating a CIM Session to $computername"
    $cs = New-CimSession @psboundparameters -ErrorAction stop
}
Catch {
    Write-Error $_
}

if ($cs) {

    $sess = New-CimInstance -Namespace $ns -ClassName MSFT_WUOperationsSession -CimSession $cs -WhatIf:$False
    
    if ($ScanOnly) {
        Write-Verbose "[PROCESS] Scanning for updates"
        $phash = @{
        Inputobject = $sess
        MethodName = 'ScanForUpdates'
        Arguments = @{SearchCriteria="IsInstalled=0";OnlineScan=$True}
        }

        $scan = Invoke-CimMethod @phash
        
        if ($scan.Updates) {
            $scan.Updates | Add-Member -MemberType Scriptproperty -Name KBArticleID -value {
              [regex]$rx="\bKB\d+\b"
              $rx.Match($this.title).Value
            } -force -PassThru
        }
        else {
            Write-Host "no updates found" -ForegroundColor Magenta
        }
    }
    else {
        Write-Verbose "[PROCESS] Apply Applicable Updates"
        Invoke-CimMethod -InputObject $sess -MethodName ApplyApplicableUpdates
    }

    #remove session
    Write-Verbose "[PROCESS] Cleaning up cimsessions"
    $cs | Remove-CimSession
}
} #process
End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #end function

Function Set-MatchingTimeZone {
[cmdletbinding(supportsShouldProcess)]
Param(
    [Parameter(
    Position = 0,
    Mandatory,
    ValueFromPipeline,
    ValueFromPipelineByPropertyName,  
    HelpMessage = "Enter the name of a Nano server to update"
)]
[Alias("cn")]
[ValidateNotNullorEmpty()]
[string]$Computername,
[PSCredential]$Credential
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    #get host time zone
    $zone = (Get-Timezone).id
    Write-Verbose "[BEGIN  ] local host time zone is '$zone'"
    $sb = { Set-Timezone -Name $using:zone -PassThru }
    $PSBoundParameters.Add("scriptblock",$sb) | Out-Null
} #begin

Process {
    Write-Verbose "[PROCESS] Setting timezone on $computername"
    if ($PSCmdlet.ShouldProcess($computername,"Setting time zone to $zone")) {
        Invoke-Command @PSBoundParameters | Select-object -property PSComputername,ID
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end
}