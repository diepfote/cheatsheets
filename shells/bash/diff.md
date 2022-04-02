# Diff in bash

* 
  ```
  while IFS='' read -r line; do array+=("$line"); done < <(mycommand)
  diff <( echo -e "${pods}" ) <( oc -n "${NAMESPACE}" get po --selector="deployment=${deployment}" -o json | jq '.items[].metadata.name' | sed 's/"//g' ) > /dev/null; do
    # do something if no diff
  done
  ```
