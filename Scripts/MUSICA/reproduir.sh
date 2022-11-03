#!/bin/bash
sudo chmod 777 /home/pi/Downloads/pipe
if [ $# -eq 0 ];
then
    while true
    do
        songs=`cat /home/pi/Downloads/llista.txt`
        while IFS="" read -r -a line;
        do
            aux=($line)
            echo "LOADLIST ${aux[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
            echo "${aux[0]}" > /home/pi/Downloads/currentsong.txt
            sleep 60
        done <<< "$songs"
    done
else
    # MÈTODE AVANÇAR
    if [ $# -eq 1 ];
    then
        #sudo touch /home/pi/Downloads/prova.txt
        #echo
        bandera=0
        songs=`cat /home/pi/Downloads/llista.txt`
        current=`cat /home/pi/Downloads/currentsong.txt`
        while IFS="" read -r -a line;
        do
            aux=($line)

            if [ "$bandera" -eq 1 ];
            then
                echo "LOADLIST ${aux[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${aux[0]}" > /home/pi/Downloads/currentsong.txt
                sleep 60
            else
                if [ "$current" == "${aux[0]}" ];
                then
                    bandera=1
                fi
            fi
        done <<< "$songs"

        #bucle infinit
        songs=`cat /home/pi/Downloads/llista.txt`
        while true
        do
            songs=`cat /home/pi/Downloads/llista.txt`
            while IFS="" read -r -a line;
            do
                aux=($line)
                echo "LOADLIST ${aux[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${aux[0]}" > /home/pi/Downloads/currentsong.txt
                sleep 60
            done <<< "$songs"
        done
    else
        #METODE RETROCEDIR

        #buscar abans canço
        bandera=0
        ite=0
        songs=`cat /home/pi/Downloads/llista.txt`
        current=`cat /home/pi/Downloads/currentsong.txt`
        while IFS="" read -r -a line;
        do
            aux=($line)

            if [ "$bandera" -neq 1 ];
            then
                if [ "$current" == "${aux[0]}" ];
                then
                    bandera=1
                else
                    ite=$((ite+1))
                fi
            fi
        done <<< "$songs"


        var=1
        songs=`cat /home/pi/Downloads/llista.txt`
        while IFS="" read -r -a line;
        do
            aux=($line)

            if [ $var -ge $ite ];
            then
                echo "LOADLIST ${aux[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${aux[0]}" > /home/pi/Downloads/currentsong.txt
                sleep 60
            fi
            var=$((var+1))
        done <<< "$songs"


        #bucle infinit
        songs=`cat /home/pi/Downloads/llista.txt`
        while true
        do
            songs=`cat /home/pi/Downloads/llista.txt`
            while IFS="" read -r -a line;
            do
                aux=($line)
                echo "LOADLIST ${aux[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${aux[0]}" > /home/pi/Downloads/currentsong.txt
                sleep 60
            done <<< "$songs"
        done
    fi

fi
