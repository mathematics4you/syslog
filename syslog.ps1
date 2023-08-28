$Server="syslog.example.com"
$SourceScript=$SourceScript=$MyInvocation.MyCommand.Source
$Message="Test log string"

function Syslog ($Message) {
    $Message = $SourceScript+" "+$Message
    $Timestamp = Get-Date -Format "MMM dd HH:mm:ss" #syslog time format
    $Severity = '6' #severity info
    $Facility = '22' #Facility LOCAL6
    $Priority = ([int]$Facility * 8) + [int]$Severity
    $Computer=$env:computername
    $FullString = "<$priority>$Timestamp $Computer $Message"
    $Encoding = [System.Text.Encoding]::ASCII
    $ByteString = $Encoding.GetBytes($FullString)
    #send the log
    $Connection = New-Object System.Net.Sockets.UdpClient
    #$Connection.Connect($Server, 514)
    #$Connection.Send($ByteString, $ByteString.Length)
}

Syslog -Message $Message
