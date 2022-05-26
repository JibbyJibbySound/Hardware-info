<# Hardware Info Script #>
<#
    Author: Gabriel Plume
    Version: 0.1
    Date uploaded: 26/05/2022
    Change note:
        Added description
        Improved layout of Reconnect window
#>

$Cs=(Get-CimInstance -ClassName CIM_ComputerSystem | Select-Object Name).Name

<# Main Menu Window #>

[xml]$MenuForm = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    Title="Hardware Info" Height="500" Width="400" ResizeMode="NoResize">
    <Canvas Name="Panel1">
        <Label Name="ComputerConnected" Content="Connected to $Cs" Canvas.Left="10" Canvas.Top="5"/>
        <Label Name="Auth" Content="By Gabriel Plume" Canvas.Bottom="5" Canvas.Right="10"/>
        <Grid Width="{Binding ElementName=Panel1, Path=ActualWidth}" Canvas.Top="90">
            <Grid.RowDefinitions>
                <RowDefinition/>
                <RowDefinition Height="45"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
                <RowDefinition Height="60"/>
            </Grid.RowDefinitions>
            <Label Name="Welcome" Content="Welcome" FontSize="30" HorizontalAlignment="Center" VerticalAlignment="Top"/>
            <Button Name="CPU" Grid.Row="2" Height="50" Width="150" HorizontalAlignment="Center">CPU Info</Button>
            <Button Name="Memory" Grid.Row="3" Height="50" Width="150" HorizontalAlignment="Center">Memory Info</Button>
            <Button Name="Reconnect" Grid.Row="4" Height="50" Width="150" HorizontalAlignment="Center">Connect to other</Button>
        </Grid>
    </Canvas>
</Window>
"@
$MenuNR=(New-Object System.Xml.XmlNodeReader $MenuForm)
$MenuWin=[Windows.Markup.XamlReader]::Load( $MenuNR )

$Device = $MenuWin.FindName("ComputerConnected")
$CPU = $MenuWin.FindName("CPU")
$Memory = $MenuWin.FindName("Memory")
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
