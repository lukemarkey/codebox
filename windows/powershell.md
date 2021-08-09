## GET HELP
Get-Help
Get-Culture

## ALIAS
New-Alias -Name help -Value Get-Help  
Get-Alias

## GET LIST OF UPDATES
Get-Hotfix
Get-HotFix -id kb2741530

## ARRAYS
$list = "one","two","two","three","four","five"
$A = 1, 2, 3, 4
write-host("Print all the array elements")
$list
write-host("Get the length of array")
$list.Length
write-host("using forEach Loop")
foreach ($element in $myList) {
  $element
}

## HASHTABLES (DICTIONARIES)
$hash = @{ ID = 1; Shape = "Square"; Color = "Blue"}
write-host("Print all hashtable keys")
$hash.keys
write-host("Print all hashtable values")
$hash.values
write-host("Get ID")
$hash["ID"]
write-host("Add key-value")
$hash.Add("Created","Now")
write-host("Remove key-value")
$hash.Remove("Updated")

## REGEX
"book" -match "oo"
"book" -match "^bo"
"book" -match "ok$"

## NEWLINE AND TABS
Write-host "Title Subtitle"
Title Subtitle
Write-host "Title `nSubtitle"
Title 
Subtitle
Write-host "Title `tSubtitle"
Title   Subtitle

## VARIABLES
$location = Get-Location
$location | Get-Member // GET TYPE OF VARIABLE

## OPERATORS
eq // EQUALS
ne // NOT EQUALS
gt // GREATER THAN
ge // GREATER OR EQUAL TO
lt // LESS THAN
le // LESS OR EQUAL TO
-AND // BOTH TRUE
-OR // EITHER TRUE
-NOT // NOT TRUE
> // PRINT OUTPUT TO FILE

## FOR LOOP
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }
item1
item2
item3

## FOR EACH LOOP
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }
item1
item2
item3

## WHILE LOOP
$counter = 0;

while($counter -lt $array.length){
   $array[$counter]
   $counter += 1
}
 
item1
item2


## DO WHILE LOOP
$array = @("item1", "item2", "item3")
$counter = 0;

do {
   $array[$counter]
   $counter += 1
} while($counter -lt $array.length)
 
item1
item2
item3 

## IF STATEMENT
$x = 10

if($x -le 20){
   write-host("This is if statement")
}

## SWITCH STATEMENT
switch(3){
   1 {"One"}
   2 {"Two"}
   3 {"Three"; break }
   4 {"Four"}
   3 {"Three Again"}
}


## FILES AND FOLDERS
New-Item -Path 'D:\temp\Test Folder' -ItemType Directory // CREATE DIRECTORY OR FILE
Copy-Item 'D:\temp\Test Folder' -Destination 'D:\temp\Test Folder1' // COPY DIRECTORY OR FILE
Remove-Item 'D:\temp\Test Folder1' -Recurse // DELETE FOLDER OR FILE
Move-Item D:\temp\Test D:\temp\Test1 // MOVE DIRECTORY OR FILE
Rename-Item D:\temp\Test D:\temp\Test1 // RENAME DIRECTORY OR FILE
Get-Content D:\temp\Test\test.txt // GET CONTENT OF FILE AS ARRAY
Test-Path D:\temp\test // CHECK DIRECTORY EXISTENCE
Clear-Content D:\temp\test\test.txt // CLEAR FILE CONTENTS
Add-Content D:\temp\test\test.txt 'World!' // APPEND TO FILE
Invoke-Item "D:\Temp\test.txt" // INVOKE DEFAULT ACTION ON FILE

## DATES AND TIMES
Get-Date

## CMDLETS
Get-Unique // GET UNIQUE VALUES
Sort // SORT VALUES
Format-List // FORMAT OUTPUT SPACED AND READABLE
Write-Warning // WRITES WARNING
Write-Host // WRITE MESSAGES

Get-Process | Where-Object {$_.ProcessName -Match "^p.*"} // GET PROCESS STARTING WITH P
Get-Service | Where-Object {$_.Status -eq "Stopped"} // WHERE FILTERS OBJECTS
Start-Sleep -s 15 // 15 SECONDS
Start-Sleep -m 500 // 500 MILLISECONDS
"a","b","c","a","a","a" | Select-Object -Unique // SELECT UNIQUE OBJECTS
Get-Process | Sort-Object -Property WS | Select-Object -Last 5 // GET 5 PROCESS SORTED BY WS PROPERTY
