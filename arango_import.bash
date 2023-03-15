for file in "splits"/*_modified.json; do
    arangoimport --file "$file" --type json --server.database "DBLP_v14" --collection "papers" --batch-size 400000000 --server.password "arangopass"

    echo "imported $file"
done