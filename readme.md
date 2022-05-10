# Automata teve eteto a teveclub.hu oldalra

1. Toltsd le a projektet vagy klonozd magadnak
    
    `git clone https://github.com/Firsh/camelfeeder.git`

2. Toltsd ki az .env.sample filet es nevezd at .env -re

    ```
    cd camelfeeder
    nano .env.sample
    mv .env.sample .env
    ```

3. Probald ki

    ```
    bash camelfeeder/teve.sh
    ```

4. Rakd be crontabba. Nekem egy raspberry pi csinalja :D

    ```
    crontab -e
    0 10 * * * /bin/ban /home/USERNEVED/camelfeeder/teve.sh
    ```

5. Esetleg windowsban task schedulerbe ha WSL-be raktad:
    ```
    wsl bash /home/USERNEVED/camelfeeder/teve.sh
    ```

## Vmit esetleg meg csinalni vele
- Lehetne logoltatni de ha csokken a kedve ugyis kapsz levelet hogy mivan, ha belepsz akkor meg latod h meg van etetve.
- Automatan mast tanitani neki? Nemtom mivan ha megtanulja a jelenlegit.
- Random szamra tippeljen vagy egy arraybol valogasson h miket szoktal.