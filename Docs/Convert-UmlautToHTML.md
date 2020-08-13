---
external help file:
Module Name:
online version: https://github.com/philmph/PWSH_Common_Functions
schema: 2.0.0
---

# Convert-UmlautToHTML

## SYNOPSIS
Converts string text input with umlauts to HTML compatible.

## SYNTAX

```
Convert-UmlautToHTML [-InputObject] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Converts string text input with umlauts to HTML compatible by replacing umlaut characters.

## EXAMPLES

### EXAMPLE 1
```
Convert-UmlautToHTML -InputObject 'Example text 1: ßüÜöÖäÄ', 'Example text 2: äÄöÖßüÜ'

Example text 1: &szlig;&uuml;&Uuml;&ouml;&Ouml;&auml;&Auml;
Example text 2: &auml;&Auml;&ouml;&Ouml;&szlig;&uuml;&Uuml;
```

### EXAMPLE 2
```
'Example text: ßüÜöÖäÄ' | Convert-UmlautToHTML

Example text: &szlig;&uuml;&Uuml;&ouml;&Ouml;&auml;&Auml;
```

## PARAMETERS

### -InputObject
String input to convert.
This parameter accepts arrays with strings.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Text

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.String[]]
## OUTPUTS

### [System.String]
## NOTES
Author:			Philipp Maier\
Author Git:		https://github.com/philmph

## RELATED LINKS

[https://github.com/philmph/PWSH_Common_Functions](https://github.com/philmph/PWSH_Common_Functions)

