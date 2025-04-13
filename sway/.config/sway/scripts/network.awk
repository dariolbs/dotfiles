function get_max(string, nmax) {
        return length(string) > nmax ?
            substr(string, 0, nmax) "..." :
            string
}

BEGIN {
    FS=":"
    ethernet = 0
    wifi = 0
    vpn = 0
}

$3 ~ /wireless$/ { wifi = 1; wifi_name = get_max($1, 10) }
$3 ~ /ethernet$/ { ethernet = 1 }
$3 ~ /(vpn$)/ { vpn = 1; vpn_name = $1 }
$3 ~ /(wireguard$)/ { vpn = 1; vpn_name = $4 }

END {
    if (ethernet) {
        printf vpn ?
            "ethernet - " vpn_name "\n" "ethernet - " vpn_name "\n00ff00\n" :
            "ethernet\nethernet\n00ff00\n"
    }
    else if (wifi) {
            printf vpn ?
                "wifi - " wifi_name  " - " vpn_name "\n" "wifi - " wifi_name  " - " vpn_name "\n00ff00\n" :
                "wifi - " wifi_name "\n" "wifi - " wifi_name "\n00ff00\n" 
    }
    else {
        printf "none\nnone\nff0000\n"
    }
}
