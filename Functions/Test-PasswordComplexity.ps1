function Test-PasswordComplexity
{
    <#
    .SYNOPSIS
    Tests a string phrase for password complexity.
    
    .DESCRIPTION
    Test a string phrase for password complexity by evaluating different requirements.
    
    .PARAMETER Phrase
    Defines the string phrase to test.
    
    .EXAMPLE
    PS C:\> Test-PasswordComplexity -Phrase 'PassW0rd'

    MeetComplexityRequirements : True
    Length                     : 8
    CapitalLetters             : True
    LowerCaseLetters           : True
    Numbers                    : True
    SpecialCharacters          : False
        
    .INPUTS
    [System.String]
    
    .OUTPUTS
    [PSCustomObject]
    
    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph
    #>

    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [AllowEmptyString()]
        [string]$Phrase
    )
    
    begin {
        Set-StrictMode -Version 3
    }
    
    process {
        $ComplexityCounter = 0

        $Result = [PSCustomObject] @{
            MeetComplexityRequirements = $false
            Length = $Phrase.Length
            CapitalLetters = $false
            LowerCaseLetters = $false
            Numbers = $false
            SpecialCharacters = $false
        }

        switch -regex -casesensitive ($Phrase) {
            "[A-Z]" { $ComplexityCounter++; $Result.CapitalLetters = $true }
            "[a-z]" { $ComplexityCounter++; $Result.LowerCaseLetters = $true }
            "[\d]" { $ComplexityCounter++; $Result.Numbers = $true }
            "[^\w]" { $ComplexityCounter++; $Result.SpecialCharacters = $true }
        }

        if (($Phrase.Length -ge 8) -and ($ComplexityCounter -ge 3)) {
            $Result.MeetComplexityRequirements = $true
        }

        Write-Output -InputObject $Result
    }
    
    end {}
}