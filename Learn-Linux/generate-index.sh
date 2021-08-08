#!/usr/bin/env bash

directorys=('./commands' './commands/text')

output_file=cmd-index.md
tmp_file=tmp_file_name

touch $tmp_file

if [[ -e $output_file ]]; then
    rm $output_file
fi

echo -e "# 命令索引\n" > $output_file

for d in "${directorys[@]}"; do
    for file_name in $(ls $d); do
        if [[ "$file_name" =~ .+\.md ]]; then
            sed -n "/^\(## .*\)$/p" $d/${file_name} | \
                sed "s&## \(.*\)&* [\1]($d/$file_name)&g" \
                >> $tmp_file
        fi
    done
done

cat $tmp_file | sort | uniq >> $output_file

rm $tmp_file

