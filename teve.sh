#!/bin/bash
cd "$(dirname "$0")"
echo "Etessuk meg a nyeszlettet!"

if [ ! -f .env ]
then
  echo "Tolsd ki az .env filet az adatokkal!"
  exit
else
    # https://gist.github.com/mihow/9c7f559807069a03e302605691f85572
    set -a
    source <(cat .env | sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
    set +a
fi

# Generate random integer between $tippmin and $tippmax
tipp=$((RANDOM % (tippmax - tippmin + 1) + tippmin))

ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.147 Safari/537.36"

echo "Megprobalunk belepni..."

if curl --location --request POST "https://teveclub.hu/" \
    --header "$ua" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --cookie-jar "cookie.txt" \
    --cookie "cookie.txt" \
    --data-urlencode "tevenev=$tevenev" \
    --data-urlencode "pass=$pass" \
    --data-urlencode 'login=Gyere!' \
    --silent \
    --output - \
    | grep -q "/logout.pet"
then
    echo "Belepett!"
else
    echo "Nem volt logout link belepes utan, szal nem sikerult!"
    exit
fi

echo "Tanitunk..."

if curl --location --request POST "https://teveclub.hu/tanit.pet" \
    --header "$ua" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --cookie-jar "cookie.txt" \
    --cookie "cookie.txt" \
    --data-urlencode "farmdoit=tanit" \
    --data-urlencode "learn=Tanulj teve!" \
    --silent \
    --output - \
    | grep -q "csak holnap tud tanulni"
then
    echo "Sikerult tanitani!"
else
    echo "Nem sikerult tanitani!"
    exit
fi

echo "Egyszamozunk..."

if curl --location --request POST "https://teveclub.hu/egyszam.pet" \
    --header "$ua" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --cookie-jar "cookie.txt" \
    --cookie "cookie.txt" \
    --data-urlencode "honnan=$tipp" \
    --data-urlencode "tipp=Ez a tippem!" \
    --silent \
    --output - \
    | grep -q "l ebben a fordul"
then
    echo "Sikerult tippelni!"
else
    echo "Nem sikerult tippelni!"
    exit
fi

echo "Etessuk a girhest..."

if curl --location --request POST "https://teveclub.hu/myteve.pet" \
    --header "$ua" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --cookie-jar "cookie.txt" \
    --cookie "cookie.txt" \
    --data-urlencode "kaja=1" \
    --data-urlencode "pia=1" \
    --data-urlencode "etet=Mehet!" \
    --silent \
    --output - \
    | grep -q "mehet"
then
    echo "Nem sikerult megtomni a belet!"
    exit
else
   echo "Jollakott!"
fi

echo "Teved meg fogja erni a holnapot. YAY!"
