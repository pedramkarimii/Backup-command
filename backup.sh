#! /bin/bash

# Get source path from user input
read -p "Enter the source path: " source_path

# Get destination path for the backup from user input
read -p "Enter the destination path for the backup: " backup_destination

# Create a timestamp for the backup file
timestamp=$(date +"%Y%m%d_%H%M%S")

# Get backup filename from user input
read -p "Enter the backup filename: " backup_filename

# Combine timestamp and user-specified filename
backup_filename="${backup_filename}_${timestamp}.tar.gz"
double_compressed_filename="double_compressed_${backup_filename%.*}.tar.gz"

# Step 0: Copy the source file to the specified destination
cp "$source_path" "$backup_destination/copied_source_file"

# Step 1: Take a backup and compress it using tar
tar -czvf "$backup_destination/$backup_filename" "$backup_destination/copied_source_file"
# -c: Create a new archive
# -z: Compress the archive using gzip
# -v: Verbosely list the files processed
# -f: Use the following argument as the name of the archive file

# Step 2: Compress the compressed backup using gzip
gzip -c "$backup_destination/$backup_filename" > "$backup_destination/$double_compressed_filename"
# -c: Write the compressed output to the standard output (stdout)

# Optional: Remove the uncompressed backup file after compression
rm "$backup_destination/copied_source_file"

# Display a message indicating successful completion
echo "Backup, compression, and double compression completed successfully at $(date +"%Y-%m-%d %H:%M:%S")"
