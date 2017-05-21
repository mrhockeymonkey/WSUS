<#
    First Dot Source all functions
#>
Try {
    Get-ChildItem -Path "$PSScriptRoot\Functions" -Filter *.ps1  | Select -ExpandProperty FullName | ForEach-Object {
        $Function = Split-Path $_ -Leaf
        . $_
    }
} 
Catch {
    Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
    Continue
}         


<#
    Load Update Services assembly
#>
Try {
    [void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
}
Catch {
    Write-Error -ErrorRecord $_
}




