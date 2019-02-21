#!/bin/bash
pods=$(kubectl get po  --all-namespaces |grep Error)
for i in "${pods[@]}"
do
    echo $i
done
x=0
pods=$(kubectl get ns)
for i in "${pods[@]}"
do
    IFS=$'\n' array=($i)
    for j in "${array[@]}"
    do
        IFS=$' ' array1=($j)
        if [ "$array1" == "NAME" ]; then
             echo  "*****"
        else
             echo $array1
             kubectl get pods -n $array1 | grep Error | cut -d' ' -f 1 | xargs kubectl delete pod
        fi
    done
done
