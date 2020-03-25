function New-PMModuleManifest
{
    <#
    .SYNOPSIS
    Creates a basic psd1 modules manifest.
    
    .DESCRIPTION
    Creates a basic psd1 modules manifest for a .psm1 file. Only the path is required.
    
    .PARAMETER PSM1Path
    Path to the psm1 file to create a psd1 module manifest for.
    
    .PARAMETER Author
    Defines the author. Defaults to "Philipp Maier".
    
    .PARAMETER Description
    Defines the description.
    
    .PARAMETER CompanyName
    Define the company name. Defaults to "Philipp Maier".
    
    .PARAMETER OpenManifest
    Tries to open the psd1 module manifest after creation. Default programm for .psd1 files is used.
    
    .EXAMPLE
    PS D:\Daten\GIT\_NOGIT\TestModule> New-PMModuleManifest -PSM1Path .\TestModule.psm1
    
    .EXAMPLE
    PS D:\Daten\GIT\_NOGIT\TestModule> New-PMModuleManifest -PSM1Path .\TestModule.psm1 -Author "Max Mustermann"
    
    .INPUTS
    -
    
    .OUTPUTS
    -
    
    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph
    Repository:		https://github.com/philmph/PWSH_Common_Functions
    
    Creationdate:	24.03.2020
    Version:		1.0
    #>
    
    
    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory)]
        [ValidateScript({
            if ((Test-Path -Path $_ -PathType Leaf) -and ($_ -match ".psm1$")) {
                $true
            }
            else {
                throw "Path to .psm1 file couldn't be validated"
            }
        })]
        [string]$PSM1Path,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Author = "Philipp Maier",

        [string]$Description,
        [string]$CompanyName,
        [switch]$OpenManifest
    )
    
    begin {
        Set-StrictMode -Version 3
    }
    
    process {
        $Path = $PSM1Path.Replace(".psm1", ".psd1")
        $RootModule = Split-Path -Path $PSM1Path -Leaf


        $NewModuleManifestArgs = @{
            Path = $Path
            Author = $Author
            CompanyName = $CompanyName
            RootModule = $RootModule
            Description = $Description
        }

        New-ModuleManifest @NewModuleManifestArgs

        if ($OpenManifest -and (Test-Path -Path $Path)) {
            Invoke-Item -Path $Path
        }
    }

    end {}
}