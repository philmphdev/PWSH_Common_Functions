---
external help file:
Module Name:
online version: https://github.com/philmph/PWSH_Common_Functions
schema: 2.0.0
---

# ConvertTo-CSVMailAttachment

## SYNOPSIS
Transforms objects to CSV Mail Attachments.

## SYNTAX

```
ConvertTo-CSVMailAttachment [-InputObject] <Object[]> [-FileName] <String> [-AddDate] [<CommonParameters>]
```

## DESCRIPTION
Transforms objects to CSV Mail Attachments.
Used for sending sending CSV files In-Memory.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-CSVMailAttachment -InputObject ([PSCustomObject]@{ "Test" = 123 }) -FileName Test

Name               : Test
NameEncoding       :
ContentDisposition : attachment
ContentStream      : System.IO.MemoryStream
ContentId          : fe3cf29e-29b2-444d-bf5b-67c3aa6f9a9c
ContentType        : text/csv; name=Test
TransferEncoding   : 
```

## PARAMETERS

### -InputObject
PowerShell objects which should be converted to the CSV content.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FileName
Defines the output filename.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AddDate
Adds the date in front of the output filename.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [System.Net.Mail.Attachment]
## NOTES
Author:			Philipp Maier\
Author Git:		https://github.com/philmph

## RELATED LINKS

[https://github.com/philmph/PWSH_Common_Functions](https://github.com/philmph/PWSH_Common_Functions)

[https://stackoverflow.com/questions/57035997/sending-e-mail-with-attachment-in-powershell](https://stackoverflow.com/questions/57035997/sending-e-mail-with-attachment-in-powershell)

