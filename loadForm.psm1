Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase,system.windows.forms

Function Load-XAMLForm($Name){
    $xaml = [xml](Get-Content -Raw $Name)
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
    $Form=[Windows.Markup.XamlReader]::Load($reader)
    $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]").ForEach({Set-Variable -Scope Global -Name "$($_.Name)" -Value $form.FindName($_.Name)})

    Set-Variable -Name "form" -Value $form -Scope Global
}