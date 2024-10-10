# Define the list of extensions to keep
$allowedExtensions = @(".pptx", ".docx", ".xlsx", ".ppt", ".doc", ".xls", ".pdf", ".jpg", ".png", ".txt", ".md")

# Function to recursively delete files based on extension
function DeleteFilesByExtension {
    param(
        [string]$path
    )
    
    # Get all files in the current directory
    $files = Get-ChildItem $path -File
    
    foreach ($file in $files) {
        $extension = $file.Extension.ToLower()
        
        # Check if the extension is in the list of allowed extensions
        if ($allowedExtensions -notcontains $extension) {
            Write-Host "Deleting $($file.FullName)"
            Remove-Item $file.FullName -Force
        }
    }
    
    # Recursively call the function for each subdirectory
    $subdirectories = Get-ChildItem $path -Directory
    foreach ($subdirectory in $subdirectories) {
        DeleteFilesByExtension $subdirectory.FullName
    }
}

# Start the recursive deletion process from the root directory
$rootDirectory = ".\consume"
DeleteFilesByExtension $rootDirectory
