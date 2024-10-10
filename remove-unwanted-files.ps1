# PowerShell Script to delete files that don't match the preset list of extensions
# Define the directory to scan
$RootDirectory = ".\consume" # Replace with your root directory

# Define the list of file extensions to keep
$KeepExtensions = @(".pptx", ".docx", ".xlsx", ".ppt", ".doc", ".xls", ".pdf", ".jpg", ".png", ".txt", ".md")

# Function to recursively delete unwanted files
function Remove-UnwantedFiles {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    # Get all files in the current directory
    $Files = Get-ChildItem -Path $Path -File

    foreach ($File in $Files) {
        # Check if the file extension is in the allowed list
        if ($KeepExtensions -notcontains $File.Extension.ToLower()) {
            # Remove file if not in the allowed list
            Write-Output "Deleting file: $($File.FullName)"
            Remove-Item -Path $File.FullName -Force
        }
    }

    # Recursively call this function for all subdirectories
    $Directories = Get-ChildItem -Path $Path -Directory
    foreach ($Directory in $Directories) {
        Remove-UnwantedFiles -Path $Directory.FullName
    }
}

# Start the cleaning process
Remove-UnwantedFiles -Path $RootDirectory
