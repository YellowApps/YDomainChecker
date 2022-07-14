cls
Import-Module ".\loadForm.psm1" -DisableNameChecking

$exts = (Get-Content ".\exts.txt" -Raw).Split(" ")
$sites = @()

Load-XAMLForm ".\mainWindow.xaml"

$btn_Check.Add_Click({
    $name = $tb_SiteName.Text
    $exts | %{
        if((Test-Connection "$name.$_" -Quiet -Count 1 -Delay 1)){
            $sites += "$name.$_"
        }
    }
    $lb_Sites.ItemsSource = $sites
})

$lb_Sites.Add_MouseDoubleClick({
    $url = "http://" + $lb_Sites.SelectedItem
    start $url
})

$form.ShowDialog() | Out-Null