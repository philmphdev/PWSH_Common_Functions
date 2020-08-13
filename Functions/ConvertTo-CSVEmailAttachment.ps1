function ConvertTo-CSVMailAttachment {
    <#
    .SYNOPSIS
    Transforms objects to CSV Mail Attachments.
    
    .DESCRIPTION
    Transforms objects to CSV Mail Attachments. Used for sending sending CSV files In-Memory.
    
    .PARAMETER InputObject
    PowerShell objects which should be converted to the CSV content.
    
    .PARAMETER FileName
    Defines the output filename.

    .PARAMETER AddDate
    Adds the date in front of the output filename.
    
    .EXAMPLE
    ConvertTo-CSVMailAttachment -InputObject ([PSCustomObject]@{ "Test" = 123 }) -FileName Test


    Name               : Test
    NameEncoding       :
    ContentDisposition : attachment
    ContentStream      : System.IO.MemoryStream
    ContentId          : fe3cf29e-29b2-444d-bf5b-67c3aa6f9a9c
    ContentType        : text/csv; name=Test
    TransferEncoding   : Base64
    
    .OUTPUTS
    [System.Net.Mail.Attachment]
    
    .NOTES
    Author:			Philipp Maier
    Author Git:		https://github.com/philmph

    Original idea from
    https://stackoverflow.com/questions/57035997/sending-e-mail-with-attachment-in-powershell
    #>
    
    [CmdletBinding()]

    param(
        [Parameter(Mandatory,
                   Position=0,
                   ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [object[]]$InputObject,

        [Parameter(Mandatory,
                   Position=1,
                   ValueFromPipelineByPropertyName)]
        [string]$FileName,

        [switch]$AddDate
    )
    
    if ($AddDate) {
        $FileName = '{0:yyyyMMdd\_HHmmss}_{1}.csv' -f (Get-Date), $FileName
    }

    $MemoryStream = [System.IO.MemoryStream]::new()
    $StreamWriter = [System.IO.StreamWriter]::new($MemoryStream)

    $StreamWriter.Write([string](
        $InputObject |
        ConvertTo-CSV -NoTypeInformation -Delimiter ';' |
        ForEach-Object {$_ + [System.Environment]::NewLine})
    )

    $StreamWriter.Flush()
    $MemoryStream.Seek(0, "Begin") | Out-Null

    $ContentType = [System.Net.Mime.ContentType]::new()
    $ContentType.MediaType = "text/csv"

    $Output = [System.Net.Mail.Attachment]::new($MemoryStream, $FileName, $ContentType)

    Write-Output -InputObject $Output
}