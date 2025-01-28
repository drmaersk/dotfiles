#!/usr/bin/env bash

adb root
adb remount
# Check if the file argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

FILENAME=$1
SEARCH_PATHS=(
  "$ANDROID_PRODUCT_OUT/vendor/lib"
  "$ANDROID_PRODUCT_OUT/vendor/lib64"
  "$ANDROID_PRODUCT_OUT/vendor/bin"
)

SEARCH_PATHS_KERNEL=(
  "$ANDROID_PRODUCT_OUT/dlkm/lib/modules"
)
# Flag to track if the file was found in any directory
file_found=false

# Loop through each directory in SEARCH_PATHS
for DIR in "${SEARCH_PATHS[@]}"; do
  # Check if the file exists in the current directory
  if [ -f "$DIR/$FILENAME" ]; then
    # Determine the corresponding path on the device
    TARGET_PATH=${DIR#"$ANDROID_PRODUCT_OUT"}

    # Push the file to the device
    echo "Found $FILENAME in $DIR. Pushing to device path: $TARGET_PATH"
    adb push "$DIR/$FILENAME" "$TARGET_PATH/$FILENAME"

    # Set the file_found flag to true
    file_found=true
  fi
done

for DIR in "${SEARCH_PATHS_KERNEL[@]}"; do
  # Check if the file exists in the current directory
  if [ -f "$DIR/$FILENAME" ]; then
  adb root && adb remount
    # Determine the corresponding path on the device
    TARGET_PATH="/vendor_dlkm/lib/modules"
    adb shell "rm $TARGET_PATH/$FILENAME"

    # Push the file to the device
    echo "Found $FILENAME in $DIR. Pushing to device path: $TARGET_PATH"
    adb push "$DIR/$FILENAME" "$TARGET_PATH/$FILENAME"

    # Set the file_found flag to true
    file_found=true
  fi
done


# Check if the file was not found in any directory
if [ "$file_found" = false ]; then
  echo "Error: $FILENAME not found in any of the specified directories."
  exit 1
fi

# Exit successfully if the file was found and pushed
exit 0
