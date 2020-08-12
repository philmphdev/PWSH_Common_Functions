function Get-ADDirectoryServerOperationMasterRole {
    <#
    .SYNOPSIS
    Used to query fsmo owners.
    
    .DESCRIPTION
    Used to query one or more domains for their fsmo owners.
    
    .PARAMETER DomainName
    Defines one or more domainnames to query for fsmo owners. Defaults to env:USERDNSDOMAIN.
    
    .EXAMPLE
    PS C:\> Get-ADDirectoryServerOperationMasterRole -DomainName 'pmaier.lab'
    

    DomainName           : pmaier.lab
    DomainNamingMaster   : WIN-5LI9IQMANGJ.pmaier.lab
    SchemaMaster         : WIN-5LI9IQMANGJ.pmaier.lab
    InfrastructureMaster : WIN-5LI9IQMANGJ.pmaier.lab
    PDCEmulator          : WIN-5LI9IQMANGJ.pmaier.lab
    RIDMaster            : WIN-5LI9IQMANGJ.pmaier.lab

    .EXAMPLE
    PS C:\> 'pmaier.lab' | Get-ADDirectoryServerOperationMasterRole


    DomainName           : pmaier.lab
    DomainNamingMaster   : WIN-5LI9IQMANGJ.pmaier.lab
    SchemaMaster         : WIN-5LI9IQMANGJ.pmaier.lab
    InfrastructureMaster : WIN-5LI9IQMANGJ.pmaier.lab
    PDCEmulator          : WIN-5LI9IQMANGJ.pmaier.lab
    RIDMaster            : WIN-5LI9IQMANGJ.pmaier.lab
    
    .INPUTS
    [System.String]
    
    .OUTPUTS
    [PSCustomObject]
    
    .NOTES
    Author:			Philipp Maier
    Github:			https://github.com/philmph
    Repository:		https://github.com/philmph/PWSH_Common_Functions
    
    Creationdate:	-
    Version:		1.0
    #>
    
    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateScript({
            # Check for domain name pattern
            if ($_ -match '^[0-9a-z]+(\.[0-9a-z]+)+$') {
                $true
            } else {
                throw "'$_' is not a valid domain name."
            }
        })]
        [string[]]$DomainName = $env:USERDNSDOMAIN
    ) # param
    
    begin {
        Set-StrictMode -Version 2
    } # begin
    
    process {
        # $Domain can only be empty when not defined by user and $env:USERDNSDOMAIN doesn't exist.
        # If defined ValidateScript would throw. Example Get-ADDirectoryServerOperationMasterRole -Domain ''
        Write-Verbose -Message "Domain is: $Domain"
        if ([string]::IsNullOrEmpty($Domain)) {
            throw 'Not in a windows domain'
        }

        foreach ($DomainObj in $DomainName) {
            try {
                Write-Verbose -Message "Gathering information for $DomainObj"
                $Forest = Get-ADForest -Server $DomainObj
                $Domain = Get-ADDomain -Server $DomainObj

                [PSCustomObject]@{
                    DomainName = $DomainObj
                    DomainNamingMaster = $Forest.DomainNamingMaster
                    SchemaMaster = $Forest.SchemaMaster
                    InfrastructureMaster = $Domain.InfrastructureMaster
                    PDCEmulator = $Domain.PDCEmulator
                    RIDMaster = $Domain.RIDMaster
                }
            } catch {
                Write-Error -Exception Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException -Message "$DomainName doesn't exist or cannot be reached."
            } # try/catch
        } # foreach
    } # process
    
    end {} # end
} # function