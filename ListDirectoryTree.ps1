<#
.SYNOPSIS
    Recursively lists all .vb, .exe, and .7z files in a specified directory while excluding common folders like "bin" and "obj".

.DESCRIPTION
    This script generates a tree-like structure of the specified directory, listing all relevant files (.vb, .exe, .7z) and excluding unwanted folders like "bin" and "obj".
    The output is copied to the clipboard for easy sharing or further use.

.NOTES
    This script does not require administrative privileges.

.EXAMPLE
    .\ListDirectoryTree.ps1
    Lists the files and folders starting from the defined root directory and copies the result to the clipboard.

.AUTHOR
    Sam (ident)

.TWITTER
    https://twitter.com/1d3nt

.GITHUB
    https://github.com/1d3nt

.EMAIL
    ident@simplecoders.com

.VBFORUMS
    https://www.vbforums.com/member.php?113656-ident

.ORCID
    https://orcid.org/0009-0007-1363-3308
#>

# Define the path you want to list (Example: "C:\path\to\your\project")
$path = "C:\path\to\your\project"

# Define the exclusion list for folders
$excludedFolders = @("bin", "obj")

# Function to list .vb, .exe, and .7z files while excluding certain folders
function List-DirectoryTree {
    param (
        [string]$directoryPath,
        [string]$indent = "",
        [switch]$lastItem = $false
    )

    # Initialize a variable to capture output
    $output = @()

    # Get all directories and relevant files in the current directory
    $items = Get-ChildItem -Path $directoryPath -Force | Where-Object {
        # Check if the item is a folder and should be excluded, or if it's a .vb, .exe, or .7z file
        if ($_.PSIsContainer) {
            -not ($excludedFolders -contains $_.Name)
        } else {
            $_.Extension -eq ".vb" -or $_.Extension -eq ".exe" -or $_.Extension -eq ".7z"
        }
    }

    # Loop through all filtered items
    $count = 0
    $totalItems = $items.Count

    foreach ($item in $items) {
        if ($item.PSIsContainer) {
            # If item is a directory
            if ($count -eq ($totalItems - 1)) {
                $output += "$indent+-- $($item.Name)"
                $newIndent = "$indent    "
            } else {
                $output += "$indent|-- $($item.Name)"
                $newIndent = "$indent|   "
            }
            # Recursively list contents of the directory
            $output += List-DirectoryTree -directoryPath $item.FullName -indent $newIndent
        } else {
            # If item is a .vb, .exe, or .7z file
            if ($count -eq ($totalItems - 1)) {
                $output += "$indent+-- $($item.Name)"
            } else {
                $output += "$indent|-- $($item.Name)"
            }
        }
        $count++
    }

    # Return collected output
    return $output
}

# Start listing from the root path and capture the output
$output = List-DirectoryTree -directoryPath $path

# Check if $output is not null or empty before setting the clipboard
if ($null -ne $output -and $output.Count -gt 0) {
    $output | Set-Clipboard
} else {
    Write-Host "No content to copy to clipboard."
}
