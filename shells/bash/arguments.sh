```text
echo -e "second argument: ${@:2:1}"  # ${@:which_arg_to_start_on:how_long_to_continue}

#array=( "$@" )
#unset "array[${#array[@]}-1]"    # Removes last element -- also see: help unset
#set "$array"
last_arg="${@:$#}"
set -- "${@:1:$(($#-1))}"  # all except last

# one or many
echo "$@"
# single string
echo "$*"

echo "$last_arg"


repos=()
echo "number of elemnts ${#repos}"
repos+=(asdf)
echo "number of elemnts ${#repos[@]}"
```

