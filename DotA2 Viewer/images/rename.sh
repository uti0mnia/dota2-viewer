for file in *.jpg.*; do
    mv "$file" "${file/jpg./}"
done
