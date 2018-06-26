$testProjects = "Sample.Tests", "Sample.Tests.Integration"
$testRuns = 1;

& dotnet restore
	
$oldResults = Get-ChildItem -Path "$PSScriptRoot\results_$testRuns-*.testresults"
if ($oldResults) {
    Remove-Item $oldResults
}
	
foreach ($testProject in $testProjects){
    & cd "$PSScriptRoot\test\$testProject"
	
    & dotnet.exe xunit `
        -parallel all `
        -xml $PSScriptRoot\results_$testRuns.testresults   
                 
        $testRuns++
}

& cd "$PSScriptRoot"