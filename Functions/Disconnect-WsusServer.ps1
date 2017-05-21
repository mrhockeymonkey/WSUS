function Disconnect-WsusServer {
    [CmdletBinding()]
    Param (

    )
    Write-Verbose "Disconnecting from $($Script:WSUS.Name)..."
    Remove-Variable -Name WSUS -Scope Script
}