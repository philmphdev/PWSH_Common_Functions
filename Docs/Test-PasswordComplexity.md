---
external help file:
Module Name:
online version: https://github.com/philmph/PWSH_Common_Functions
schema: 2.0.0
---

# Test-PasswordComplexity

## SYNOPSIS
Tests a string phrase for password complexity.

## SYNTAX

```
Test-PasswordComplexity [-Phrase] <String> [<CommonParameters>]
```

## DESCRIPTION
Test a string phrase for password complexity by evaluating different requirements.

## EXAMPLES

### EXAMPLE 1
```
Test-PasswordComplexity -Phrase 'PassW0rd'

MeetComplexityRequirements : True
Length                     : 8
CapitalLetters             : True
LowerCaseLetters           : True
Numbers                    : True
SpecialCharacters          : False
```

## PARAMETERS

### -Phrase
Defines the string phrase to test.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.String]
## OUTPUTS

### [PSCustomObject]
## NOTES
Author:			Philipp Maier\
Author Git:		https://github.com/philmph

## RELATED LINKS

[https://github.com/philmph/PWSH_Common_Functions](https://github.com/philmph/PWSH_Common_Functions)

