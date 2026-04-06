Import-Module SSH-Sessions
New-SShSession -computername edacmev1afis01 -username nagioro -pass P@ssw0rd
Invoke-SshCommand -ComputerName edacmev1afis01 -Command "df -h | grep vg_data"
New-SShSession -computername edacmev1afis02 -username nagioro -pass P@ssw0rd
Invoke-SshCommand -ComputerName edacmev1afis02 -Command "df -h | grep vg_data"
New-SShSession -computername edacmev1afis03 -username nagioro -pass P@ssw0rd
Invoke-SshCommand -ComputerName edacmev1afis03 -Command "df -h | grep vg_data"
Remove-SshSession -removeAll