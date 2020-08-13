---
external help file:
Module Name:
online version: https://github.com/philmph/PWSH_Common_Functions
schema: 2.0.0
---

# ConvertTo-InvertedCsv

## SYNOPSIS
Converts a .csv file from header:cloumn to cloumn:header.

## SYNTAX

```
ConvertTo-InvertedCsv [-SourceCsv] <String> [[-Delimiter] <Char>] [<CommonParameters>]
```

## DESCRIPTION
Converts a .csv file from header:cloumn to cloumn:header.

## EXAMPLES

### EXAMPLE 1
```
Import-Csv -Path $File -Encoding UTF8
Column1 Column2 Column3
------- ------- -------
1       2       3
a       b       c
x       y       z
4       5       6


PS C:\\\> ConvertTo-InvertedCsv -SourceCsv $File -Verbose
VERBOSE: Old header: Column1,Column2,Column3
VERBOSE: New header: Column1,1,a,x,4
VERBOSE: Starting convertion for header Column2
VERBOSE: Starting convertion for header Column3
VERBOSE: Outputting to file D:\test_Inverted.csv


PS C:\\\> Import-Csv -Path $File2 -Encoding UTF8 | FT
Column1 1 a x 4
------- - - - -
Column2 2 b y 5
Column3 3 c z 6
```

## PARAMETERS

### -SourceCsv
Path to the original .csv file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Defines the delimiter to use for Import and Export-Csv cmdlets.
Defaults to ','.

```yaml
Type: Char
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ,
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### -
## OUTPUTS

### -
## NOTES
Author:			Philipp Maier\
Author Git:		https://github.com/philmph

## RELATED LINKS

[https://github.com/philmph/PWSH_Common_Functions](https://github.com/philmph/PWSH_Common_Functions)

