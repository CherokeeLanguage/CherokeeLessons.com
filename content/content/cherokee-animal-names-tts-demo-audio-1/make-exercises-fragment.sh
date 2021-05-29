
cp /dev/null exercises.txt
counter=0
(
    for x in Animals*mp3; do
        counter=$(($counter + 1))
        printf "* Exercise set %02d\n\n" $counter
        printf "    {{audio (file=\"$x\")}}\n\n"
    done
) >> exercises.txt

