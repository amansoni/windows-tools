Function Start-VM()
{
param (
    [string]$vmname = "Ubuntu",
    [switch]$config = $false
)

IF (!$config)
{ 
echo 'Adding port forward rule ssh,tcp,,3022,,22 to ' + $vmname
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe modifyvm " + $VMName + " --natpf1 'ssh,tcp,,3022,,22'"
}

echo "starting " + $VMName + " --headless"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe startvm" + $VMName + " --headless"

}

# VBoxManage modifyvm myserver --natpf1 "ssh,tcp,,3022,,22"