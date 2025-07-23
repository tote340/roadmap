clear
green=$(tput setaf 2)
bold=$(tput bold)
reset=$(tput sgr0)

stty -echoctl
trap 'tput cnorm; tput cup 30 0; exit' SIGINT

while true; do
        tput cup 1 0
        tput civis

        echo -e "${bold}${green} Total CPU usage${reset}\n"
        top -b -n1 | grep %Cpu | sed 's/.*, *\([0-9.]*\) id.*/\1/' | awk '{printf " %.1f%%\n", 100-$1'}


        echo -e "\n ${bold}${green}Total memory usage (%)${reset}\n"
        free | grep Mem: | awk '{printf " %.1f%%\n", $3/$7*100 }'


        echo -e "\n ${bold}${green}Disk usage${reset}\n"
        df -h --total | grep total | awk '{print " Total: "$2,"  Used :"$3, "  Free: "$4, "  Used (%): "$5}'


        echo -e  "\n ${bold}${green}Top 5 processes by CPU usage${reset}\n"
        ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6


        echo -e "\n ${bold}${green}Top 5 processes by memory usage${reset}\n"
        ps -eo pid,comm,%mem --sort=-%mem | head -n 6

done
