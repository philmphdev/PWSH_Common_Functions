#Requires -Version 5.1

<#
#################################################################
Author:				Philipp Maier
Author Git:			https://github.com/philmph

Notes & Usage:
This class is used to implement static string functions which don't
exist on [System.String] in .NET

Call with [PMString]::Trunctuate($String, $Length) to trunctuate.
Call with [PMString]::ToCyrillic($String) to convert a string to Cyrillic.

Link:
https://github.com/philmph/PWSH_Common_Functions
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

    static [string] ToCyrillic ([string]$Value) {
        return ([Text.Encoding]::ASCII).GetString(([Text.Encoding]::GetEncoding("Cyrillic")).GetBytes($Value))
    }
}