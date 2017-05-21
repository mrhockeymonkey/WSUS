function Get-WsusComputerTarget {
    [CmdletBinding(DefaultParameterSetName = 'Normal')]
    param (
        [Parameter(Position = 0)]
        $ComputerName,
        
        [Parameter(ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        $ComputerGroup
    )
    BEGIN{
        if($PSBoundParameters.ContainsKey('ComputerName')) {
            $FilterScript = [ScriptBlock]::Create('$_.FullDomainName -like $ComputerName')
        }
        else {
            $FilterScript = [ScriptBlock]::Create('$_')
        }

        Write-Verbose "Creating ComputerTargetScope..."
        $ComputerTargetScope = New-Object Microsoft.UpdateServices.Administration.ComputerTargetScope 

        Write-Verbose "Setting ComputerTargetScope to Include Downstream Computer Targets..."
        $ComputerTargetScope.IncludeDownstreamComputerTargets = $true 
    }
    PROCESS{
        Write-Debug "ParameterSetName: $($PSCmdlet.ParameterSetName)"
        Switch ($PSCmdlet.ParameterSetName) {
            'Normal' {
                #Nothing
            }
            'Pipeline' {
                Write-Verbose "Setting ComputerTargetScope to Include Group: $($ComputerGroup.name)"
                $ComputerTargetScope.ComputerTargetGroups.Add($ComputerGroup) | Out-Null
            }
        }
    }
    END{
        Write-Verbose "Fetching Results..."
        $Script:WSUS.GetComputerTargets($ComputerTargetScope) |
            Where-Object -FilterScript $FilterScript |
            Add-Member -TypeName 'WSUS.ComputerTarget' -PassThru
    }
}