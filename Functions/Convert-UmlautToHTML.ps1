Function Convert-UmlautToHTML
{
    <#
    .SYNOPSIS
    Converts string text input with umlauts to HTML compatible.
    
    .DESCRIPTION
    Converts string text input with umlauts to HTML compatible by replacing umlaut characters.
    
    .PARAMETER InputObject
    String input to convert. This parameter accepts arrays with strings.
    
    .EXAMPLE
    PS C:\> Convert-UmlautToHTML -InputObject 'Example text 1: ßüÜöÖäÄ', 'Example text 2: äÄöÖßüÜ'
    Example text 1: &szlig;&uuml;&Uuml;&ouml;&Ouml;&auml;&Auml;
    Example text 2: &auml;&Auml;&ouml;&Ouml;&szlig;&uuml;&Uuml;
    
    .EXAMPLE
    PS C:\> 'Example text: ßüÜöÖäÄ' | Convert-UmlautToHTML
    Example text: &szlig;&uuml;&Uuml;&ouml;&Ouml;&auml;&Auml;

    .INPUTS
    [System.String[]]
    
    .OUTPUTS
    [System.String]

    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph

    .LINK
    https://github.com/philmph/PWSH_Common_Functions
    #>

    [CmdletBinding()]
    
    Param (
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true)]
        [Alias('Text')]
        [ValidateNotNullOrEmpty()]
        [string[]]$InputObject
    )
    
    begin {
        Set-StrictMode -Version 3
    }
    
    process {
        foreach ($Text in $InputObject) {
            switch -regex ($Text) {
                # Use [char]'X' -as [int] to get ID
                ([char]223) { $Text = $Text -replace ([char]223), '&szlig;' }
                ([char]252) { $Text = $Text -creplace ([char]252), '&uuml;' }
                ([char]220) { $Text = $Text -creplace ([char]220), '&Uuml;' }
                ([char]246) { $Text = $Text -creplace ([char]246), '&ouml;' }
                ([char]214) { $Text = $Text -creplace ([char]214), '&Ouml;' }
                ([char]228) { $Text = $Text -creplace ([char]228), '&auml;' }
                ([char]196) { $Text = $Text -creplace ([char]196), '&Auml;' }
                '"' { $Text = $Text -replace '"', '&quot;' }
                '&' { $Text = $Text -replace '&', '&amp;' }
                '<' { $Text = $Text -replace '<', '&lt;' }
                '>' { $Text = $Text -replace '>', '&gt;' }
            }

            Write-Output $Text
        }
    }
    
    end {}
}