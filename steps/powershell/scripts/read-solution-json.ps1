param (
    [Parameter(Mandatory = $true)]
    [string]$solutionJsonPath = "solution.json"
)

$solution = `
    Get-Content `
        -Raw `
        -Path $env:SOLUTION_JSON_PATH `
    | ConvertFrom-Json
Write-Host "##vso[task.setvariable variable=solutionName]$($solution.name)"

If($solution.path) { 
    $solutionRelativePath = $solution.path
} Else {
    $solutionRelativePath = "contents"
}
$solutionJsonFolder = $env:SOLUTION_JSON_PATH -Replace "(.*?[/\\]?)[^/\\]*.json$", "`$1"
$solutionPath = "$solutionJsonFolder$solutionRelativePath"
Write-Host "##vso[task.setvariable variable=solutionPath]$solutionPath"