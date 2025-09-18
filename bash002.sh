#!/opt/homebrew/bin/bash

cat > playground/fruits.txt <<EOF
apple|紅色|50
banana|黃色|30
grape|紫色|40
EOF

declare -A fruits
 

while IFS= read -r line; do
    key=$(echo "$line" | awk -F'|' '{print $1}')
    value=$(echo "$line" | awk -F'|' '{print $2","$3}')
    fruits["$key"]="$value"
done < playground/fruits.txt

# 3. 輸出表頭
printf "%-8s%-8s%-8s\n" "名稱" "顏色" "數量"

# 4. 依 key 排序並輸出
for k in $(printf "%s\n" "${!fruits[@]}" | sort); do
    color=$(echo "${fruits[$k]}" | awk -F',' '{print $1}')
    count=$(echo "${fruits[$k]}" | awk -F',' '{print $2}')
    printf "%-8s%-8s%-8s\n" "$k" "$color" "$count"
done