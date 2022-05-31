<# Hardware Info Script #>
<#
    Author: Gabriel Plume
    Version: 0.2
    Date uploaded: 31/05/2022
    Change note:
        Added functionality to capacity button
#>
$Cs=(Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name

<# Main Menu Window #>

[xml]$MenuForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Hardware Info" Height="500" Width="300" ResizeMode="NoResize">
    <Canvas Name="Panel1">
        <Label Name="ComputerConnected" Content="Connected to $Cs" Canvas.Left="5" Canvas.Top="5"/>
        <Label Name="Auth" Content="By Gabriel Plume" Canvas.Bottom="5" Canvas.Right="10"/>
        <Button Name="Reconnect" Canvas.Bottom="8" Canvas.Left="10" HorizontalAlignment="Center">Connect to other</Button>
        <Grid Width="{Binding ElementName=Panel1, Path=ActualWidth}" Canvas.Top="85">
            <Grid.RowDefinitions>
                <RowDefinition/>
                <RowDefinition Height="35"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
            </Grid.RowDefinitions>
            <Label Name="Welcome" Content="Welcome" FontSize="30" HorizontalAlignment="Center" VerticalAlignment="Top"/>
            <Button Name="CPU" Grid.Row="2" Height="50" Width="150" HorizontalAlignment="Center">CPU Info</Button>
            <Button Name="Memory" Grid.Row="3" Height="50" Width="150" HorizontalAlignment="Center">Memory Info</Button>
            <Button Name="Storage" Grid.Row="4" Height="50" Width="150" HorizontalAlignment="Center">Storage Info</Button>
            <Button Grid.Row="5" Height="50" Width="150" HorizontalAlignment="Center">Test2</Button>
        </Grid>
    </Canvas>
</Window>
"@
$MenuNR=(New-Object System.Xml.XmlNodeReader $MenuForm)
$MenuWin=[Windows.Markup.XamlReader]::Load( $MenuNR )

$Device = $MenuWin.FindName("ComputerConnected")
$CPU = $MenuWin.FindName("CPU")
$Memory = $MenuWin.FindName("Memory")
$Storage = $MenuWin.FindName("Storage")
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
                    $CPUWin.Hide()})

$DID = $CPUWin.FindName("DID") 
$Name = $CPUWin.FindName("Name")
$MCS = $CPUWin.FindName("MCS")
$Socket = $CPUWin.FindName("Socket")
$Man = $CPUWin.FindName("Man")

<# Memory Info window #>

[xml]$MMForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Main Memory Info" Height="100" Width="600" ResizeMode="NoResize">
    <Grid Width="{Binding ElementName=Panel1, Path=ActualWidth}">
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition  Width="150"/>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        
        <Label Grid.Column="0">Part Number</Label>
        <Label Grid.Column="1">Manufacturer</Label>
        <Label Grid.Column="2">Location</Label>
        <Label Grid.Column="3">Capacity</Label>
        <Label Grid.Column="4">Speed</Label>
        <Label Grid.Column="5">Data Width</Label>

        <Label Name="PN" Grid.Row="1" Grid.Column="0"> </Label>
        <Label Name="MMMan" Grid.Row="1" Grid.Column="1"> </Label>
        <Label Name="Location" Grid.Row="1" Grid.Column="2"> </Label>
        <Label Name="Cap" Grid.Row="1" Grid.Column="3"> </Label>
        <Label Name="Speed" Grid.Row="1" Grid.Column="4"> </Label>
        <Label Name="DW" Grid.Row="1" Grid.Column="5"> </Label>

    </Grid>
</Window>
"@

$MMNR=(New-Object System.Xml.XmlNodeReader $MMForm)
$MMWin=[Windows.Markup.XamlReader]::Load( $MMNR )

$MMWin.Add_Closing({$_.Cancel = $true
                    $MMWin.Hide()})

$PN = $MMWin.FindName("PN")
$MMMan = $MMWin.FindName("MMMan")
$Location = $MMWin.FindName("Location")
$Cap = $MMWin.FindName("Cap")
$Speed = $MMWin.FindName("Speed")
$DW = $MMWin.FindName("DW")

<# Capacity Info window #>

[xml]$CapForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Storage Info" Height="150" Width="600" ResizeMode="NoResize">
    <ScrollViewer HorizontalScrollBarVisibility="Auto">  
        <Grid Name="CapGrid" Width="{Binding ElementName=Panel1, Path=ActualWidth}">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
        
            <Label Grid.Column="0">Name</Label>
            <Label Grid.Column="1">Device ID</Label>
            <Label Grid.Column="2">Partitions</Label>
            <Label Grid.Column="3">Capacity</Label>

        </Grid>
    </ScrollViewer>
</Window>
"@

$CapNR=(New-Object System.Xml.XmlNodeReader $CapForm)
$CapWin=[Windows.Markup.XamlReader]::Load( $CapNR )

$CapWin.Add_Closing({$_.Cancel = $true
                    $CapWin.Hide()})

$CapGrid = $CapWin.FindName("CapGrid")

# $CapGrid.ColumnDefinitions.Add()

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

<# Main Menu functions #>

$CPU.Add_Click({
    if($Cs -EQ (Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name){
    $Data = Get-CimInstance -ClassName CIM_processor
    }else{
    $Data = Get-CimInstance -ClassName CIM_processor -ComputerName $Cs
    }
    $DID.Content = $Data.DeviceID
    $Name.Content = $Data.Name
    $MCS.Content = $Data.MaxClockSpeed
    $Socket.Content = $Data.SocketDesignation
    $Man.Content = $Data.Manufacturer
    $CPUWin.Showdialog()
})

$Memory.Add_Click({
    if($Cs -EQ (Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name){
    $Data = Get-CimInstance -ClassName CIM_PhysicalMemory
    }else{
    $Data = Get-CimInstance -ClassName CIM_PhysicalMemory -ComputerName $Cs
    }
    $PN.Content = $Data.PartNumber
    $MMMan.Content = $Data.Manufacturer
    $Location.Content = $Data.DataWidth
    $Cap.Content = $Data.Capacity
    $Speed.Content = $Data.Speed
    $DW.Content = $Data.DataWidth
    $MMWin.ShowDialog()
})

$Storage.Add_Click({
    if($Cs -EQ (Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name){
    $CapData = Get-CimInstance -ClassName CIM_DiskDrive
    }else{
    $CapData = Get-CimInstance -ClassName CIM_DiskDrive -ComputerName $Cs
    }

    $Count=1

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

    if($Cs -EQ (Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name){
    $CapData = Get-CimInstance -ClassName CIM_DiskPartition
    }else{
    $PartData = Get-CimInstance -ClassName CIM_DiskPartition -ComputerName $Cs
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

    foreach ($d in $CapData) {
        $PartRow = new-object system.windows.controls.rowdefinition
        $PartRow.Height="Auto"
        $CapGrid.RowDefinitions.Add($PartRow)
        
        $NameLabel = New-Object System.Windows.Controls.Label
        $NameLabel.Name = "Name"
        $NameLabel.Content = $d.Name
        [System.Windows.Controls.Grid]::SetRow($NameLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($NameLabel,0)
        $CapGrid.AddChild($NameLabel)

        $IDLabel = New-Object System.Windows.Controls.Label
        $IDLabel.Name = "DiskID"
        $IDLabel.Content = $d.BootPartition
        [System.Windows.Controls.Grid]::SetRow($IDLabel,$Count)
        [System.Windows.Controls.Grid]::SetColumn($IDLabel,1)
        $CapGrid.AddChild($IDLabel)

        $PartLabel = New-Object System.Windows.Controls.Label
        $PartLabel.Name = "Parts"
        $PartLabel.Content = $d.PrimaryPartition
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

    $CapWin.ShowDialog()
})

$Reconnect.Add_Click({
    $RWin.Showdialog()
})

<# Reconnect functions #>

$ConBut.Add_Click({
    $Cs = $NewMachine.Text({})
    $Device.Content({"Connected to $Cs"})
    $RWin.Hide()
})

$MenuWin.Showdialog()
