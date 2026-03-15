#!/bin/bash -l

npm i @node-minify/cli -g
npm i @node-minify/terser -g
npm i @node-minify/clean-css -g
npm i @node-minify/html-minifier -g

SOURCE_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_SOURCE

echo "Source set to $SOURCE_DIRECTORY"
echo "Compress set to $INPUT_COMPRESS"
echo "JS options set to $INPUT_JS_OPTIONS"
echo "CSS options set to $INPUT_CSS_OPTIONS"
echo "HTML options set to $INPUT_HTML_OPTIONS"

if [[ $INPUT_COMPRESS == *"js"* ]]; then
    find ./_site/. -type f -iname \*.js | while read fname
        do
        node-minify --input ${fname} --compressor terser --output ${fname} --option "$INPUT_JS_OPTIONS"
        done
fi

if [[ $INPUT_COMPRESS == *"css"* ]]; then
    find ./_site/. -type f -iname \*.css | while read fname
        do
        node-minify --input ${fname} --compressor clean-css --output ${fname} --option "$INPUT_CSS_OPTIONS"
        done
fi

if [[ $INPUT_COMPRESS == *"html"* ]]; then
    find ./_site/. -type f -iname \*.html | while read fname
        do
        node-minify --input ${fname} --compressor html-minifier --output ${fname} --option "$INPUT_HTML_OPTIONS"
        done
fi
