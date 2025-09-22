#!/opt/homebrew/bin/bash
update_fruit_stock() {
    if [[ -f $1 ]]; then
        min_fruit=$(awk -F: 'NR==1{name=$1;min=$2} $2<min{name=$1;min=$2} END{print name}' $1)
        old_qty=$(awk -F: -v f="$min_fruit" '$1==f{print $2}' $1)
        new_qty=$((old_qty + 10))

        # sed -i '' in only for macOS, for Linux use sed -i
        # ^ represents the start of the line, $ represents the end of the line
        sed -i '' "s/^$min_fruit:$old_qty\$/$min_fruit:$new_qty/" $1
        echo "Updated $min_fruit stock from $old_qty to $new_qty."
        cat $1
    else
        echo "$1 does not exist."
        return 1
    fi
}


touch playground/fruits.txt
target_file="playground/fruits.txt"
cat > playground/fruits.txt <<EOF
apple:10
banana:5
orange:8
EOF
update_fruit_stock $target_file
rm playground/fruits.txt