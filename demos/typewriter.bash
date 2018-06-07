#!/bin/bash
while read -r LINE; do
    if [[ "${LINE}" != "#!/bin/bash" ]]; then
        echo "${LINE}"
        T=$(( ( RANDOM % 3 )  + 1 ))
        sleep "$T"
    fi
done
