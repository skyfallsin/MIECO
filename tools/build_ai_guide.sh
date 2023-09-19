#!/bin/bash -x

SOURCE_PATH="templates/ai/content"
WRITE_PATH=$SOURCE_PATH # replace if you want to write to a different path
mkdir -p $WRITE_PATH
echo ">>>> Building AI Guide from $SOURCE_PATH..."

# # test if command `marked` exists
# if ! command -v marked &> /dev/null
# then
#     echo "marked could not be found"
#     echo "Installing marked..."
#     npm install marked@6.0.0
# fi

find $SOURCE_PATH -name "*.md" | while read -r file; 
    do echo ">>>> Building $file"; 
    echo
    # replace SOURCE_PATH in $file with WRITE_PATH and change file extension to html from md
    NEW_PATH="${file/$SOURCE_PATH/$WRITE_PATH}"
    mkdir -p $(dirname $NEW_PATH)
    marked -o "${NEW_PATH%.md}-content.html" "${file}"
    echo 
    node tools/build_ai_guide_content_pages.js "${file}"
done