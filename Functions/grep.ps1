# NOTE: This function is not something that should be taken serious and 
# more of a joke. Feel free to use it to show someone that "Powershell
# can grep" :)

function grep {
    [CmdletBinding()]

    param (
        [Parameter(Mandatory,
                   Position=1,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [psobject[]]$InputObject,

        [Parameter(Mandatory,
                   Position=0,
                   ValueFromPipelineByPropertyName)]
        [string]$Filter
    )

    begin {
        Set-StrictMode -Version 3
        $Output = [System.Collections.Generic.List[psobject]]::new()
    }

    process {
        foreach ($obj in $InputObject) {
            $Output.Add($obj)
        }
    }

    end {
        $Output | Out-String | Select-String -Pattern $Filter -AllMatches
    }
}