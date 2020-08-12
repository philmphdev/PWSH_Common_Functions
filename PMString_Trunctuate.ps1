#Requires -Version 5.1

<#
#################################################################
Author:				Philipp Maier
Author Git:			https://github.com/philmph

Notes & Usage:
This class is used to implement the missing Trunctuate function on System.String in .NET.
Call with [PMString]::Trunctuate($String, $Length)

Link:				
#################################################################
#>

class PMString
{
    static [string] Trunctuate ([string]$String, [int16]$Length) {

        if ($String.Length -le $Length) {
            $Length = $String.Length
        }

        return $String.Substring(0, $Length)
    }
}