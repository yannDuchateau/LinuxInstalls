param(
    [Parameter(Mandatory=$True)]
    [string]    $Drive,
    [int[]]     $AttributeId,
    [string[]]  $Property,
    [switch]    $FriendlyOutput)
# parses attribute table in smartctl output and builds an object
$smart = [string[]](smartctl -A $Drive)
$attributes=@()
foreach ($s in $smart) {
    if ($s -match '^\s*(\d+)\s+(\w+)\s+(\w+)\s+(\d+)\s+(\d+)\s+([\d-]+)\s+([\w-]+)\s+(\w+)\s+([\w-]+)\s+(\d+)') {
        $o = new-object -Typename PSObject
        add-member -in $o -m NoteProperty -name 'ID' -value ([int]$matches[1])
        add-member -in $o -m NoteProperty -name 'Name' -value $matches[2]
        add-member -in $o -m NoteProperty -name 'Flag' -value $matches[3]
        add-member -in $o -m NoteProperty -name 'Value' -value ([int]$matches[4])
        add-member -in $o -m NoteProperty -name 'Worst' -value ([int]$matches[5])
        add-member -in $o -m NoteProperty -name 'Threshold' -value ([int]$matches[6])
        add-member -in $o -m NoteProperty -name 'Type' -value $matches[7]
        add-member -in $o -m NoteProperty -name 'Updated' -value $matches[8]
        add-member -in $o -m NoteProperty -name 'WhenFailed' -value $matches[9]
        add-member -in $o -m NoteProperty -name 'Raw' -value ([int64]$matches[10])
        $attributes += $o
    }
}
if ($AttributeId){
    $attributes = $attributes | ? {$_.id -in $attributeid}
}
if ($Property){
    if ($property.count -gt 1 -and $attributes.count -gt -0 -and $Property -notcontains 'id'){
        # if more than one result and more than one attribute, add the ID to the output
        $property = ,'id'+$Property
    }
    $attributes = $attributes | select $Property
}
if (@($attributes).count -eq 1 -and @($attributes.psobject.properties).count -eq 1){
    # return single values directly instead of an object
    $attributes.psobject.properties.value
} elseif ($FriendlyOutput){
    $attributes | ft * -a
} else {
    $attributes
}