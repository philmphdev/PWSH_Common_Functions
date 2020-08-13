function ConvertTo-InvertedCsv {
    <#
    .SYNOPSIS
    Converts a .csv file from header:cloumn to cloumn:header.
    
    .DESCRIPTION
    Converts a .csv file from header:cloumn to cloumn:header.
    
    .PARAMETER SourceCsv
    Path to the original .csv file.
    
    .PARAMETER Delimiter
    Defines the delimiter to use for Import and Export-Csv cmdlets. Defaults to ','.
    
    .EXAMPLE
    PS C:\> Import-Csv -Path $File -Encoding UTF8                                                                                                                                                                                                                                  
    Column1 Column2 Column3
    ------- ------- -------
    1       2       3
    a       b       c
    x       y       z
    4       5       6


    PS C:\> ConvertTo-InvertedCsv -SourceCsv $File -Verbose                                                                                                                                                                                                                        VERBOSE: Old header: Column1,Column2,Column3
    VERBOSE: New header: Column1,1,a,x,4
    VERBOSE: Starting convertion for header Column2
    VERBOSE: Starting convertion for header Column3
    VERBOSE: Outputting to file D:\test_Inverted.csv
 

    PS C:\> Import-Csv -Path $File2 -Encoding UTF8 | FT                                                                                                                                                                                            
    Column1 1 a x 4
    ------- - - - -
    Column2 2 b y 5
    Column3 3 c z 6
    
    .INPUTS
    -
    
    .OUTPUTS
    -
    
    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph
    #>
    
    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory=$true,
                   Position=0)]
        [ValidateScript({
            if (Test-Path -Path $_ -PathType Leaf) {
                $true
            } else {
                $false
            }
        })]
        [string]$SourceCsv,

        [Parameter(Mandatory=$false,
                   Position=1)]
        [char]$Delimiter = ','
    )
    
    begin {
        Set-StrictMode -Version 2
    } # begin
    
    process {
        $SourceCsvData = Import-Csv -Path $SourceCsv -Delimiter $Delimiter -Encoding UTF8

        # Get old header and create the new one; "[$([char]34)$([char]39)]" = ["']
        $OldHeader = @(((Get-Content -Path $SourceCsv -Encoding UTF8 | Select-Object -First 1) -replace "[$([char]34)$([char]39)]", '').Split($Delimiter))
        $NewHeader = [System.Collections.ArrayList]::new()
        $NewHeader.Add($OldHeader[0]) | Out-Null
        $SourceCsvData | ForEach-Object -Process { $NewHeader.Add($_.($OldHeader[0])) } | Out-Null

        Write-Verbose -Message "Old header: $($OldHeader -join $Delimiter)"
        Write-Verbose -Message "New header: $($NewHeader -join $Delimiter)"

        $n = 1
        $DestinationCsvData = [System.Collections.ArrayList]::new()
       
        foreach ($OldHeaderProp in ($OldHeader | Select-Object -Skip 1)) {
            $obj = [PSCustomObject] @{
                $NewHeader[0] = $OldHeader[$n]
            }

            $m = 0

            Write-Verbose -Message "Starting convertion for header $($OldHeader[$n])"

            foreach ($NewHeaderProp in ($NewHeader | Select-Object -Skip 1)) {
                $obj | Add-Member -MemberType NoteProperty -Name $NewHeaderProp -Value ($SourceCsvData[$m].($OldHeader[$n]))
                $m++
            } # foreach

            $n++
            $DestinationCsvData.Add($obj) | Out-Null
        } # foreach
 
        Write-Verbose -Message ('Outputting to file {0}' -f $SourceCsv.Replace('.csv', '_inverted.csv'))
        $DestinationCsvData | Export-Csv -Path $SourceCsv.Replace('.csv', '_inverted.csv') -Delimiter $Delimiter -Encoding UTF8 -NoTypeInformation
    } # process
    
    end {}
} # function