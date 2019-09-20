shift_date() {
    date --date="$1 $2" +%T,%N | cut -c 1-12
}

subSync() {
    while read -r line
    do
        if [[ $line =~ ^[0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9]\ --\>\ [0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9]$ ]]
        then
            read -r start_date separator end_date <<<"$line"
            new_start_date="$(shift_date "$start_date" "$1")"
            new_end_date="$(shift_date "$end_date" "$1")"
            printf "%s %s %s\n" "$new_start_date" "$separator" "$new_end_date" >> "$2.tmp"
        else
            printf "%s\n" "$line" >> "$2.tmp"
        fi
    done < "$2"
    mv "$2.tmp" "$2"
}