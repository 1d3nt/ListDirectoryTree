# ListDirectoryTree Script

This PowerShell script recursively lists all `.vb`, `.exe`, and `.7z` files in a specified directory, while excluding common folders like `bin` and `obj`. It formats the directory structure in a tree-like layout and copies the output to the clipboard for easy sharing or further use.

## How to Run the Script

1. **Save the script**: Copy the script content into a `.ps1` file (e.g., `ListDirectoryTree.ps1`).
2. **Set the directory path**: Modify the `$path` variable to point to the directory you want to scan. For example:
    ```powershell
    $path = "C:\path\to\your\project"
    ```
3. **Run the script**: Open PowerShell and run the script by navigating to the script's directory and executing it:
    ```powershell
    .\ListDirectoryTree.ps1
    ```
4. **Check the clipboard**: After running, the directory structure will be copied to your clipboard.

## Example Output
## Example Output

Assuming the following directory structure:

C:\
│
├───Project
│   ├───bin
│   ├───obj
│   ├───src
│   │   ├───File1.vb
│   │   └───File2.vb
│   ├───build.exe
│   └───archive.7z

The output might look like this:

+-- Project
|   |-- src
|   |   |-- File1.vb
|   |   |-- File2.vb
|   |-- build.exe
|   |-- archive.7z

Note: The `bin` and `obj` folders are excluded from the listing.
