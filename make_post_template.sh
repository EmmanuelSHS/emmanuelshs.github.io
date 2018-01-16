#!/bin/bash

helper_doc="Usage: ${0} [title]"

should_exit=0

if [ -z $1 ]; then
    echo "please put a valid title!"
    should_exit=1
fi

if [ $should_exit -eq 1 ]; then
    echo ""
    echo $helper_doc
    exit
fi

title=$1
name=`date +%Y-%m-%d`-$1
echo "---" >> _drafts/$name.md
echo "layout: post" >> _drafts/$name.md
echo "title: ${title}" >> _drafts/$name.md
echo "date: `date +%Y-%m-%d`" >>_drafts/$name.md
echo "---" >> _drafts/$name.md

echo "post template generated "$title

