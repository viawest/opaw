#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public -Filter "*.ps1" -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private -Filter "*.ps1" -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private)) {
    try {
        . $import.fullname
    } catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
