function Connect-WsusServer {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param (
        [Parameter(Position = 0)]
        [String]$ComputerName = 'localhost',

        [Parameter()]
        [Switch]$UseSecureConnection,
        
        [Parameter(ParameterSetName = 'Custom')]
        [Int]$PortNumber
    )
    BEGIN{ 
        Write-Verbose "Connecting to $ComputerName..."  
             
        #Decide which port to use based on ParameterSetName
        Switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                if ($UseSecureConnection) {
                    Write-Verbose "Defaulting to 8531 for Secure Connection"
                    $PortNumber = 8531
                }
                else {
                    Write-Verbose "Defaulting to 8530 for Non Secure Connection"
                    $PortNumber = 8530
                }
            }

            'Custom' {
                Write-Verbose "Using Custom Port: $PortNumber"
            }
        }
    }
    PROCESS{
        Try {
            $Script:WSUS = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($ComputerName,$UseSecureConnection,$PortNumber)
            Write-Verbose "Connected to $ComputerName"
        }
        Catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    }
    END{}
}

