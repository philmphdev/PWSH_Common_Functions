function Get-GPONotLinkedReport {
    <#
    .SYNOPSIS
    Checks for unlinked GPO objects.
    
    .DESCRIPTION
    Checks for unlinked GPO objects by creating a domain GPO XML report and parsing it.
    
    .PARAMETER Domain
    Defines the domain to check for unlinked gpos. Defaults to env:USERDNSDOMAIN.
    
    .EXAMPLE
    PS C:\> Get-GPONotLinkedReport

    Name       CreatedTime         ModifiedTime       
    ----       -----------         ------------       
    Not Linked 12.07.2019 13:43:38 12.07.2019 13:43:38

    .INPUTS
    -
    
    .OUTPUTS
    [PSCustomObject]
    
    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph
    
    .LINK
    https://github.com/philmph/PWSH_Common_Functions
    #>
    
    [CmdletBinding()]
        
    param (
        [Parameter(Mandatory=$false)]
        [string]$Domain = $env:USERDNSDOMAIN
    ) # param
    
    begin {
        Set-StrictMode -Version 2

        # Regex for GPO report splits; (?s) to enable 'dot matches newline'
        $Regex = [Regex]::new('(?s)<Name>(?<Name>.+)</Name>.+<CreatedTime>(?<CreatedTime>.+)</CreatedTime>.+<ModifiedTime>(?<ModifiedTime>.+)</ModifiedTime>')
    } # begin
    
    process {
        Write-Verbose -Message "Domain is: $Domain"
        if ([string]::IsNullOrEmpty($Domain)) {
            throw 'Not in a windows domain'
        }

        # Save full XML GPO report in variable to parse
        $GPOs = Get-GPOReport -ReportType Xml -Domain $Domain -Server $Domain -All -ErrorAction Stop
        
        foreach ($GPO in $GPOs) {
            if (($GPO -match '<Name>') -and ($GPO -notmatch '<LinksTo>')) {

                $GPOMatches = $Regex.Match($GPO)
                Write-Verbose -Message "Match success for Index $($GPOs.IndexOf($GPO)) is $($GPOMatches.Success)"

                [PSCustomObject]@{
                    Name = $GPOMatches.Groups['Name'].Value
                    CreatedTime = $GPOMatches.Groups['CreatedTime'].Value -as [DateTime]
                    ModifiedTime = $GPOMatches.Groups['ModifiedTime'].Value -as [DateTime]
                }
            } # if
        } # foreach
    } # process
    
    end {} # end
} # function