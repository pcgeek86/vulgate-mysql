# This PowerShell script is being provided as a demonstration of how to read a tab-delimited (TSV) file in PowerShell, and generate MySQL language from the data.
# The data conversion has already been executed, and can be found in the vulgate.sql file in this repository.

$Vulgate = Import-Csv -Delimiter "`t" -Path $PSScriptRoot/vul.tsv -Header @('BookName', 'BookShortName', 'BookNumber', 'Chapter', 'Verse', 'VerseText')

$StringBuilder = [System.Text.StringBuilder]::new()

$null = $StringBuilder.AppendLine(@'
DROP DATABASE IF EXISTS vulgate;
CREATE DATABASE vulgate;

CREATE TABLE vulgate.vulgate_text (
    BookName varchar(20)
  , BookShortName varchar(5)
  , BookNumber INT
  , Chapter INT
  , Verse INT
  , VerseText TEXT
);

START TRANSACTION;
INSERT INTO vulgate.vulgate_text (
    BookName
  , BookShortName
  , BookNumber
  , Chapter
  , Verse
  , VerseText
)
  VALUES
'@)

$Vulgate | & { process {
    $NewLine = '  ("{0}", "{1}", {2}, {3}, {4}, "{5}"),' -f $PSItem.BookName, $PSItem.BookShortName, $PSItem.BookNumber, $PSItem.Chapter, $PSItem.Verse, $PSItem.VerseText, "`t"
    $null = $StringBuilder.AppendLine($NewLine)
  }
}

$null = $StringBuilder.Remove($StringBuilder.Length-3, 1)
$null = $StringBuilder.AppendLine(@'
;
COMMIT;
'@)

$StringBuilder.ToString() | clip
