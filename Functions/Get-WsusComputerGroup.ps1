function Get-WsusComputerGroup {
    [CmdletBinding()]
    Param (
        [String]$Name
    )
    BEGIN {
        if($PSBoundParameters.ContainsKey('Name')) {
            $FilterScript = [ScriptBlock]::Create('$_.Name -like $Name')
        }
        else {
            $FilterScript = [ScriptBlock]::Create('$_')
        }
    }
    PROCESS {
        $WSUS.GetComputerTargetGroups() | 
            Where-Object -FilterScript $FilterScript | 
            Add-Member -TypeName WSUS.ComputerGroup -PassThru
    }
    END {}
}