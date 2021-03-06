<# Hardware Info Script #>
<#
    Author: Gabriel Plume
    Version: 0.4.2
    Date uploaded: 21/06/2022
    Change note:
        Fixed overwrite issue
#>

$ComputerConnected=(Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name

<# Main Menu Window #>

[xml]$MenuForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Hardware Info" Height="500" Width="300" ResizeMode="NoResize">
    <Canvas Name="Panel1">
        <Label Name="ComputerConnected" Canvas.Left="5" Canvas.Top="5"/>
        <Label Name="Auth" Content="By Gabriel Plume" Canvas.Bottom="5" Canvas.Right="10"/>
        <Button Name="Reconnect" Canvas.Bottom="8" Canvas.Left="10" HorizontalAlignment="Center">Connect to other</Button>
        <Grid Width="{Binding ElementName=Panel1, Path=ActualWidth}" Canvas.Top="35">
            <Grid.RowDefinitions>
                <RowDefinition/>
                <RowDefinition Height="18"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
            </Grid.RowDefinitions>
            <Label Name="Welcome" Content="Welcome" FontSize="30" HorizontalAlignment="Center" VerticalAlignment="Top"/>
            <Button Name="CPU" Grid.Row="2" Height="50" Width="150" HorizontalAlignment="Center">CPU Info</Button>
            <Button Name="Memory" Grid.Row="3" Height="50" Width="150" HorizontalAlignment="Center">Memory Info</Button>
            <Button Name="Storage" Grid.Row="4" Height="50" Width="150" HorizontalAlignment="Center">Storage Info</Button>
            <Button Name="Video" Grid.Row="5" Height="50" Width="150" HorizontalAlignment="Center">Video Controller Info</Button>
            <Button Name="Drivers" Grid.Row="6" Height="50" Width="150" HorizontalAlignment="Center">Driver Info</Button>
        </Grid>
    </Canvas>
</Window>
"@

$MenuNR=(New-Object System.Xml.XmlNodeReader $MenuForm)
$MenuWin=[Windows.Markup.XamlReader]::Load( $MenuNR )

$Device = $MenuWin.FindName("ComputerConnected")
$Device.Content = "Connected to $ComputerConnected"
$CPU = $MenuWin.FindName("CPU")
$Memory = $MenuWin.FindName("Memory")
$Storage = $MenuWin.FindName("Storage")
$Video = $MenuWin.FindName("Video")
$Drivers = $MenuWin.FindName("Drivers")
$Reconnect = $MenuWin.FindName("Reconnect")

<# CPU information window #>

[xml]$CPUForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="CPU Info" Height="100" Width="600" ResizeMode="NoResize">
    <Grid Width="{Binding ElementName=Panel1, Path=ActualWidth}">
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="45"/>
            <ColumnDefinition/>
            <ColumnDefinition Width="100"/>
            <ColumnDefinition Width="45"/>
            <ColumnDefinition Width="90"/>
        </Grid.ColumnDefinitions>
        
        <Label Grid.Column="0">Device ID</Label>
        <Label Grid.Column="1">Name</Label>
        <Label Grid.Column="2">Max Clock Speed</Label>
        <Label Grid.Column="3">Socket</Label>
        <Label Grid.Column="4">Manufacturer</Label>

        <Label Name="DID" Grid.Row="1" Grid.Column="0"> </Label>
        <Label Name="Name" Grid.Row="1" Grid.Column="1"> </Label>
        <Label Name="MCS" Grid.Row="1" Grid.Column="2"> </Label>
        <Label Name="Socket" Grid.Row="1" Grid.Column="3"> </Label>
        <Label Name="Man" Grid.Row="1" Grid.Column="4"> </Label>

    </Grid>
</Window>
"@

$CPUNR=(New-Object System.Xml.XmlNodeReader $CPUForm)
$CPUWin=[Windows.Markup.XamlReader]::Load( $CPUNR )

$CPUWin.Add_Closing({$_.Cancel = $true
                    $CPUWin.Hide()
                    $MenuWin.ShowDialog()})

$DID = $CPUWin.FindName("DID") 
$Name = $CPUWin.FindName("Name")
$MCS = $CPUWin.FindName("MCS")
$Socket = $CPUWin.FindName("Socket")
$Man = $CPUWin.FindName("Man")

<# Memory Info window #>

[xml]$MMForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Main Memory Info" Height="100" Width="800">
    <ScrollViewer HorizontalScrollBarVisibility="Auto">
        <Grid Name="MMGrid" Width="{Binding ElementName=Panel1, Path=ActualWidth}">
            <Grid.ColumnDefinitions>
                <ColumnDefinition  Width="150"/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
        </Grid>
        </ScrollViewer>
</Window>
"@

$MMNR=(New-Object System.Xml.XmlNodeReader $MMForm)
$MMWin=[Windows.Markup.XamlReader]::Load( $MMNR )

$MMGrid = $MMWin.FindName("MMGrid")

$MMWin.Add_Closing({$_.Cancel = $true
                    $MMWin.Hide()
                    $MenuWin.ShowDialog()})

<# Capacity Info window #>

[xml]$CapForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Storage Info" Height="150" Width="600">
    <ScrollViewer HorizontalScrollBarVisibility="Auto">  
        <Grid Name="CapGrid" Width="{Binding ElementName=Panel1, Path=ActualWidth}">
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
        </Grid>
    </ScrollViewer>
</Window>
"@

$CapNR=(New-Object System.Xml.XmlNodeReader $CapForm)
$CapWin=[Windows.Markup.XamlReader]::Load( $CapNR )

$CapWin.Add_Closing({$_.Cancel = $true
                    $CapWin.Hide()
                    $MenuWin.ShowDialog()})

$CapGrid = $CapWin.FindName("CapGrid")

<# Video Controller Window #>

[xml]$VidForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Video Controller Info" Height="150" Width="Auto">
    <ScrollViewer HorizontalScrollBarVisibility="Auto">  
        <Grid Name="VidGrid" Width="{Binding ElementName=Panel1, Path=ActualWidth}">
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
        </Grid>
    </ScrollViewer>
</Window>
"@

$VidNR=(New-Object System.Xml.XmlNodeReader $VidForm)
$VidWin=[Windows.Markup.XamlReader]::Load( $VidNR )

$VidWin.Add_Closing({$_.Cancel = $true
                    $VidWin.Hide()
                    $MenuWin.ShowDialog()})

$VidGrid = $VidWin.FindName("VidGrid")

<# Driver Window #>

[xml]$DivForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Driver Info" Height="Auto" Width="Auto">
    <ScrollViewer HorizontalScrollBarVisibility="Auto">  
        <Grid Name="DivGrid" Width="{Binding ElementName=Panel1, Path=ActualWidth}">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
        
            <Label Grid.Column="0">File Location</Label>
            <Label Grid.Column="1">Class Name</Label>
            <Label Grid.Column="2">Boot Critical</Label>
            <Label Grid.Column="3">Provider</Label>
            <Label Grid.Column="4">Date</Label>
            <Label Grid.Column="5">Version</Label>

        </Grid>
    </ScrollViewer>
</Window>
"@

$DivNR=(New-Object System.Xml.XmlNodeReader $DivForm)
$DivWin=[Windows.Markup.XamlReader]::Load( $DivNR )

$DivWin.Add_Closing({$_.Cancel = $true
                    $DivWin.Hide()
                    $MenuWin.ShowDialog()})

$DivGrid = $DivWin.FindName("DivGrid")

<# Connect window #>

[xml] $RForm = @"
    <Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Connect" Height="75" Width="150" ResizeMode="NoResize">
        <Grid Height="75">
            <Grid.RowDefinitions>
                <RowDefinition/>
                <RowDefinition/>
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <TextBox Name="Entry" HorizontalAlignment="Center">Enter a machine name</TextBox>
            <Button Name="Connect" HorizontalAlignment="Center" VerticalAlignment="Bottom">Connect to machine</Button>
        </Grid>
    </Window>
"@

$RNR=(New-Object System.Xml.XmlNodeReader $RForm)
$RWin=[Windows.Markup.XamlReader]::Load( $RNR )

$RWin.Add_Closing({$_.Cancel = $true})

$NewMachine = $RWin.FindName("Entry")
$ConBut = $RWin.FindName("Connect")

<# Reconnect functions #>

$ConBut.Add_Click({
    try {
        $ComputerConnected = $NewMachine.Text
        Get-WMIObject -ClassName Win32_ComputerSystem -ComputerName $ComputerConnected -ErrorAction Stop| Select-Object Name 
    }
    catch {
        $ComputerConnected = (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name
    }
    finally{
        $Device.Content = "Connected to $ComputerConnected"
        $RWin.Hide()
        $MenuWin.ShowDialog()
    }
})

<# Main Menu functions #>

$CPU.Add_Click({
    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $Data = Get-WMIObject -ClassName Win32_processor
    }else{
    $Data = Get-WMIObject -ClassName Win32_processor -ComputerName $ComputerConnected
    }
    $DID.Content = $Data.DeviceID
    $Name.Content = $Data.Name
    $MCS.Content = $Data.MaxClockSpeed
    $Socket.Content = $Data.SocketDesignation
    $Man.Content = $Data.Manufacturer
    $MenuWin.Hide()
    $CPUWin.Showdialog()
})

$Memory.Add_Click({
    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $Data = Get-WMIObject -ClassName Win32_PhysicalMemory
    }else{
    $Data = Get-WMIObject -ClassName Win32_PhysicalMemory -ComputerName $ComputerConnected
    }

    $MMGrid.Children.Clear()
    $MMGrid.RowDefinitions.Clear()

    $MMLRow = new-object system.windows.controls.rowdefinition
    $MMLRow.Height="Auto"
    $MMGrid.RowDefinitions.Add($MMLRow)

    $Count=0

    $PNL = New-Object System.Windows.Controls.Label
    $PNL.Content = "Part Number"
    [System.Windows.Controls.Grid]::SetRow($PNL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($PNL,0)
    $MMGrid.AddChild($PNL)

    $ManuL = New-Object System.Windows.Controls.Label
    $ManuL.Content = "Manufacturer"
    [System.Windows.Controls.Grid]::SetRow($ManuL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($ManuL,1)
    $MMGrid.AddChild($ManuL)

    $LocationL = New-Object System.Windows.Controls.Label
    $LocationL.Content = "Location"
    [System.Windows.Controls.Grid]::SetRow($LocationL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($LocationL,2)
    $MMGrid.AddChild($LocationL)

    $CapL = New-Object System.Windows.Controls.Label
    $CapL.Content = "Capacity"
    [System.Windows.Controls.Grid]::SetRow($CapL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($CapL,3)
    $MMGrid.AddChild($CapL)

    $SpeedL = New-Object System.Windows.Controls.Label
    $SpeedL.Content = "Speed"
    [System.Windows.Controls.Grid]::SetRow($SpeedL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($SpeedL,4)
    $MMGrid.AddChild($SpeedL)

    $DWL = New-Object System.Windows.Controls.Label
    $DWL.Content = "Data Width"
    [System.Windows.Controls.Grid]::SetRow($DWL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($DWL,5)
    $MMGrid.AddChild($DWL)

    $Count++
        
    foreach ($d in $Data) {
        $MMRow = new-object system.windows.controls.rowdefinition
        $MMRow.Height="Auto"
        $MMGrid.RowDefinitions.Add($MMRow)
        
        $PN = New-Object System.Windows.Controls.Label
        $PN.Name = "PartNumber"
        $PN.Content = $d.PartNumber
        [System.Windows.Controls.Grid]::SetRow($PN,$Count)
        [System.Windows.Controls.Grid]::SetColumn($PN,0)
        $MMGrid.AddChild($PN)

        $Manu = New-Object System.Windows.Controls.Label
        $Manu.Name = "Manufacturer"
        $Manu.Content = $d.Manufacturer
        [System.Windows.Controls.Grid]::SetRow($Manu,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Manu,1)
        $MMGrid.AddChild($Manu)

        $Location = New-Object System.Windows.Controls.Label
        $Location.Name = "DeviceLocator"
        $Location.Content = $d.DeviceLocator
        [System.Windows.Controls.Grid]::SetRow($Location,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Location,2)
        $MMGrid.AddChild($Location)

        $Cap = New-Object System.Windows.Controls.Label
        $Cap.Name = "Capacity"
        $Cap.Content = $d.Capacity
        [System.Windows.Controls.Grid]::SetRow($Cap,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Cap,3)
        $MMGrid.AddChild($Cap)

        $Speed = New-Object System.Windows.Controls.Label
        $Speed.Name = "Speed"
        $Speed.Content = $d.Speed
        [System.Windows.Controls.Grid]::SetRow($Speed,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Speed,4)
        $MMGrid.AddChild($Speed)

        $DW = New-Object System.Windows.Controls.Label
        $DW.Name = "DataWidth"
        $DW.Content = $d.DataWidth
        [System.Windows.Controls.Grid]::SetRow($DW,$Count)
        [System.Windows.Controls.Grid]::SetColumn($DW,5)
        $MMGrid.AddChild($DW)

        $Count++

    }
    $MenuWin.Hide()
    $MMWin.ShowDialog()
})

$Storage.Add_Click({
    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $CapData = Get-WMIObject -ClassName Win32_DiskDrive
    }else{
    $CapData = Get-WMIObject -ClassName Win32_DiskDrive -ComputerName $ComputerConnected
    }

    $CapGrid.Children.Clear()
    $CapGrid.RowDefinitions.Clear()

    $CapLRow = new-object system.windows.controls.rowdefinition
    $CapLRow.Height="Auto"
    $CapGrid.RowDefinitions.Add($CapLRow)

    $Count=0

    $NameL = New-Object System.Windows.Controls.Label
    $NameL.Content = "Name"
    [System.Windows.Controls.Grid]::SetRow($NameL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($NameL,0)
    $CapGrid.AddChild($NameL)

    $DIDL = New-Object System.Windows.Controls.Label
    $DIDL.Content = "Device ID"
    [System.Windows.Controls.Grid]::SetRow($DIDL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($DIDL,1)
    $CapGrid.AddChild($DIDL)

    $PartitionsL = New-Object System.Windows.Controls.Label
    $PartitionsL.Content = "Partitions"
    [System.Windows.Controls.Grid]::SetRow($PartitionsL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($PartitionsL,2)
    $CapGrid.AddChild($PartitionsL)

    $CapL = New-Object System.Windows.Controls.Label
    $CapL.Content = "Capacity"
    [System.Windows.Controls.Grid]::SetRow($CapL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($CapL,3)
    $CapGrid.AddChild($CapL)

    $Count++


    foreach ($d in $CapData) {
        $CapRow = new-object system.windows.controls.rowdefinition
        $CapRow.Height="Auto"
        $CapGrid.RowDefinitions.Add($CapRow)
        
        $NameLabel = New-Object System.Windows.Controls.Label
        $NameLabel.Name = "Name"
        $NameLabel.Content = $d.Caption
        [System.Windows.Controls.Grid]::SetRow($NameLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($NameLabel,0)
        $CapGrid.AddChild($NameLabel)

        $IDLabel = New-Object System.Windows.Controls.Label
        $IDLabel.Name = "DiskID"
        $IDLabel.Content = $d.DeviceID
        [System.Windows.Controls.Grid]::SetRow($IDLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($IDLabel,1)
        $CapGrid.AddChild($IDLabel)

        $PartLabel = New-Object System.Windows.Controls.Label
        $PartLabel.Name = "Parts"
        $PartLabel.Content = $d.Partitions
        [System.Windows.Controls.Grid]::SetRow($PartLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($PartLabel,2)
        $CapGrid.AddChild($PartLabel)

        $CapLabel = New-Object System.Windows.Controls.Label
        $CapLabel.Name = "StorageCap"
        $CapLabel.Content = $d.Size
        [System.Windows.Controls.Grid]::SetRow($CapLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($CapLabel,3)
        $CapGrid.AddChild($CapLabel)

        $Count++
    }

    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $PartData = Get-WMIObject -ClassName Win32_DiskPartition
    }else{
    $PartData = Get-WMIObject -ClassName Win32_DiskPartition -ComputerName $ComputerConnected
    }

    $GapRow = new-object system.windows.controls.rowdefinition
    $GapRow.Height="20"
    $CapGrid.RowDefinitions.Add($GapRow)

    $Count++

    $Row = new-object system.windows.controls.rowdefinition
    $Row.Height="Auto"
    $CapGrid.RowDefinitions.Add($Row)

    $NameHeader = New-Object System.Windows.Controls.Label
    $NameHeader.Content = "Name"
    [System.Windows.Controls.Grid]::SetRow($NameHeader,$Count)
    [System.Windows.Controls.Grid]::SetColumn($NameHeader,0)
    $CapGrid.AddChild($NameHeader)

    $BootHeader = New-Object System.Windows.Controls.Label
    $BootHeader.Content = "Boot Partition"
    [System.Windows.Controls.Grid]::SetRow($BootHeader,$Count)
    [System.Windows.Controls.Grid]::SetColumn($BootHeader,1)
    $CapGrid.AddChild($BootHeader)

    $PartHeader = New-Object System.Windows.Controls.Label
    $PartHeader.Content = "Primary Partition"
    [System.Windows.Controls.Grid]::SetRow($PartHeader,$Count)
    [System.Windows.Controls.Grid]::SetColumn($PartHeader,2)
    $CapGrid.AddChild($PartHeader)

    $CapHeader = New-Object System.Windows.Controls.Label
    $CapHeader.Content = "Capacity"
    [System.Windows.Controls.Grid]::SetRow($CapHeader,$Count)
    [System.Windows.Controls.Grid]::SetColumn($CapHeader,3)
    $CapGrid.AddChild($CapHeader)

    $Count++

    foreach ($d in $PartData) {
        $PartRow = new-object system.windows.controls.rowdefinition
        $PartRow.Height="Auto"
        $CapGrid.RowDefinitions.Add($PartRow)
        
        $NameLabel = New-Object System.Windows.Controls.Label
        $NameLabel.Name = "Name"
        $NameLabel.Content = $d.Name
        [System.Windows.Controls.Grid]::SetRow($NameLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($NameLabel,0)
        $CapGrid.AddChild($NameLabel)

        $BootLabel = New-Object System.Windows.Controls.Label
        $BootLabel.Name = "BootLabel"
        $BootLabel.Content = $d.BootPartition
        [System.Windows.Controls.Grid]::SetRow($BootLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($BootLabel,1)
        $CapGrid.AddChild($BootLabel)

        $PrimLabel = New-Object System.Windows.Controls.Label
        $PrimLabel.Name = "PrimLabel"
        $PrimLabel.Content = $d.PrimaryPartition
        [System.Windows.Controls.Grid]::SetRow($PrimLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($PrimLabel,2)
        $CapGrid.AddChild($PrimLabel)

        $CapLabel = New-Object System.Windows.Controls.Label
        $CapLabel.Name = "StorageCap"
        $CapLabel.Content = $d.Size
        [System.Windows.Controls.Grid]::SetRow($CapLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($CapLabel,3)
        $CapGrid.AddChild($CapLabel)

        $Count++
    }

    $MenuWin.Hide()
    $CapWin.ShowDialog()
})

$Video.Add_Click({
    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $Data = Get-WMIObject -ClassName Win32_VideoController | Select-Object -Property Caption,AdapterCompatibility,VideoModeDescription,MaxRefreshRate,VideoProcessor
    }else{
    $Data = Get-WMIObject -ClassName Win32_VideoController -ComputerName $ComputerConnected| Select-Object -Property Caption,AdapterCompatibility,VideoModeDescription,MaxRefreshRate,VideoProcessor
    }

    $VidGrid.Children.Clear()
    $VidGrid.RowDefinitions.Clear()

    $VidLRow = new-object system.windows.controls.rowdefinition
    $VidLRow.Height="Auto"
    $VidGrid.RowDefinitions.Add($VidLRow)

    $Count=0

    $NameL = New-Object System.Windows.Controls.Label
    $NameL.Content = "Name"
    [System.Windows.Controls.Grid]::SetRow($NameL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($NameL,0)
    $VidGrid.AddChild($NameL)

    $ACL = New-Object System.Windows.Controls.Label
    $ACL.Content = "Adapter Compatability"
    [System.Windows.Controls.Grid]::SetRow($ACL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($ACL,1)
    $VidGrid.AddChild($ACL)

    $VML = New-Object System.Windows.Controls.Label
    $VML.Content = "Video Mode"
    [System.Windows.Controls.Grid]::SetRow($VML,$Count)
    [System.Windows.Controls.Grid]::SetColumn($VML,2)
    $VidGrid.AddChild($VML)

    $MRRL = New-Object System.Windows.Controls.Label
    $MRRL.Content = "Max Refresh Rate"
    [System.Windows.Controls.Grid]::SetRow($MRRL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($MRRL,3)
    $VidGrid.AddChild($MRRL)

    $VPL = New-Object System.Windows.Controls.Label
    $VPL.Content = "Video Processor"
    [System.Windows.Controls.Grid]::SetRow($VPL,$Count)
    [System.Windows.Controls.Grid]::SetColumn($VPL,4)
    $VidGrid.AddChild($VPL)

    $Count++

    foreach ($d in $Data) {
        $CapRow = new-object system.windows.controls.rowdefinition
        $CapRow.Height="Auto"
        $VidGrid.RowDefinitions.Add($CapRow)
        
        $NameLabel = New-Object System.Windows.Controls.Label
        $NameLabel.Name = "Name"
        $NameLabel.Content = $d.Caption
        [System.Windows.Controls.Grid]::SetRow($NameLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($NameLabel,0)
        $VidGrid.AddChild($NameLabel)

        $AC = New-Object System.Windows.Controls.Label
        $AC.Name = "AdapterComp"
        $AC.Content = $d.AdapterCompatibility
        [System.Windows.Controls.Grid]::SetRow($AC,$Count)
        [System.Windows.Controls.Grid]::SetColumn($AC,1)
        $VidGrid.AddChild($AC)

        $VMD = New-Object System.Windows.Controls.Label
        $VMD.Name = "VideoModeDescription"
        $VMD.Content = $d.VideoModeDescription
        [System.Windows.Controls.Grid]::SetRow($VMD,$Count)
        [System.Windows.Controls.Grid]::SetColumn($VMD,2)
        $VidGrid.AddChild($VMD)

        $MaxRR = New-Object System.Windows.Controls.Label
        $MaxRR.Name = "MaxRefresh"
        $MaxRR.Content = $d.MaxRefreshRate
        [System.Windows.Controls.Grid]::SetRow($MaxRR,$Count)
        [System.Windows.Controls.Grid]::SetColumn($MaxRR,3)
        $VidGrid.AddChild($MaxRR)

        $VP = New-Object System.Windows.Controls.Label
        $VP.Name = "VidPro"
        $VP.Content = $d.VideoProcessor
        [System.Windows.Controls.Grid]::SetRow($VP,$Count)
        [System.Windows.Controls.Grid]::SetColumn($VP,4)
        $VidGrid.AddChild($VP)

        $Count++
    }

    $MenuWin.Hide()
    $VidWin.ShowDialog()
})

$Drivers.Add_Click({
    if($ComputerConnected -EQ (Get-WMIObject -ClassName Win32_ComputerSystem | Select-Object Name).Name){
    $Data = Get-WindowsDriver -Online |Sort-Object -Property ClassName |Select-Object -Property OriginalFileName,ClassName,BootCritical,ProviderName,Date,Version
    }else{
    $Data = Get-WindowsDriver -Online |Sort-Object -Property ClassName |Select-Object -Property OriginalFileName,ClassName,BootCritical,ProviderName,Date,Version
    }

    $Count=1

    foreach ($d in $Data) {
        $CapRow = new-object system.windows.controls.rowdefinition
        $CapRow.Height="Auto"
        $DivGrid.RowDefinitions.Add($CapRow)
        
        $FileLabel = New-Object System.Windows.Controls.Label
        $FileLabel.Name = "FileName"
        $FileLabel.Content = $d.OriginalFileName
        [System.Windows.Controls.Grid]::SetRow($FileLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($FileLabel,0)
        $DivGrid.AddChild($FileLabel)

        $CN = New-Object System.Windows.Controls.Label
        $CN.Name = "ClassName"
        $CN.Content = $d.ClassName
        [System.Windows.Controls.Grid]::SetRow($CN,$Count)
        [System.Windows.Controls.Grid]::SetColumn($CN,1)
        $DivGrid.AddChild($CN)

        $BC = New-Object System.Windows.Controls.Label
        $BC.Name = "BootCritical"
        $BC.Content = $d.BootCritical
        [System.Windows.Controls.Grid]::SetRow($BC,$Count)
        [System.Windows.Controls.Grid]::SetColumn($BC,2)
        $DivGrid.AddChild($BC)

        $PN = New-Object System.Windows.Controls.Label
        $PN.Name = "ProviderName"
        $PN.Content = $d.ProviderName
        [System.Windows.Controls.Grid]::SetRow($PN,$Count)
        [System.Windows.Controls.Grid]::SetColumn($PN,3)
        $DivGrid.AddChild($PN)

        $Date = New-Object System.Windows.Controls.Label
        $Date.Name = "Date"
        $Date.Content = $d.Date
        [System.Windows.Controls.Grid]::SetRow($Date,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Date,4)
        $DivGrid.AddChild($Date)

        $Vers = New-Object System.Windows.Controls.Label
        $Vers.Name = "Version"
        $Vers.Content = $d.Version
        [System.Windows.Controls.Grid]::SetRow($Vers,$Count)
        [System.Windows.Controls.Grid]::SetColumn($Vers,5)
        $DivGrid.AddChild($Vers)

        $Count++
    }

    $MenuWin.Hide()
    $DivWin.ShowDialog()
})

$Reconnect.Add_Click({
    $MenuWin.Hide()
    $RWin.Showdialog()
})

$MenuWin.Showdialog()
