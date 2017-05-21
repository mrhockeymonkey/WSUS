Function Get-SupercededUpdates {
    [CmdletBinding()]
    Param (
        [Switch]$AllowUnapprovedSupersedingUpdates
    )
    #Get all updates that are not declined and supersed some other update
    Write-Verbose "Getting Updates..."
    If($AllowUnapprovedSupersedingUpdates) {
        $WSUS.GetUpdates() | Where-Object -FilterScript {$_.HasSupersededUpdates -and -not $_.isDeclined}
    }
    Else {
        $WSUS.GetUpdates() | Where-Object -FilterScript {$_.HasSupersededUpdates -and -not $_.isDeclined}
    }
        #ForEach-Object {
        #    $_.GetRelatedUpdates([Microsoft.UpdateServices.Administration.UpdateRelationship]::UpdatesSupersededByThisUpdate) | Where-Object -FilterScript {-not $_.isDeclined}
        #} 
}
