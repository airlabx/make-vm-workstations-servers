$VMName = Read-Host "vm name"
if(($ProcessorCount = Read-Host "Press enter to accept default value [default two]") -eq ''){$ProcessorCount}else{$ProcessorCount = 2}
# $ProcessorCount=read-host "Press enter to accept default value [default two]"
# if($answer -eq $null){$ProcessorCount = 2}
# if($answer -eq ""){$ProcessorCount = 2}
$ISO = "C:\iso\en_windows_10_multiple_editions_version_1703_updated_july_2017_x64_dvd_10925340.iso"
New-VM -Name $VMName -BootDevice VHD -NewVHDPath "H:\VM\$VMName\Virtual Hard Disks\$VMName.vhdx" -Path C:\VM\ -NewVHDSizeBytes 40GB -Generation 2 -Switch "vSwitch - External"
Write-Host -foregroundcolor "green" "VM" $VMName "Made"
#set the processor count
Set-VMProcessor $VMName -Count $ProcessorCount 
Write-Host -foregroundcolor "green" "Processor set: "
#Set the ram 
Set-VMMemory  $VMName -DynamicMemoryEnabled $true -MinimumBytes 512MB -StartupBytes 1024MB -MaximumBytes 4GB
#disable secure boot for linx/ubuntu
#Set-VMFirmware $VMName -EnableSecureBoot off
#create the dvd drive and set the iso 
Add-VMDvdDrive -VMName $VMName -Path $ISO
#set boot from iso
# $VMName = get-vm 
# https://blogs.technet.microsoft.com/jhoward/2013/10/25/hyper-v-generation-2-virtual-machines-part-2/
$dvd = Get-VMDvdDrive $VMName 
Set-VMFirmware $VMName -FirstBootDevice $dvd
#remove-vm $VMName -force
#Remove-Item c:\vm\$vmname -Recurse