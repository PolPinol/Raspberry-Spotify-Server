# Administration and System Design
## Practica 1 Fase 2

# Introduction

Per a realitzar la instal·lació de tot el programari hem creat un script anomenat Install.sh. Aquest script es l’encarregat de actualitzar i instal·lar totes les dependències necessàries per a el correcte funcionament del sistema. 

Dividirem aquest script en les següents fases: 

Fase de instal·lació I actualització del programari. Nomes començar procedirem a fer un update I upgrade de tots els paquets del sistema. Aquesta acció tot I no ser del tot necessaria (el upgrade) es considera una bona praxis per tal de mantenir tot el programari actualitzat. En aquesta fase també descarregarem I instal·larem els headers.  

A continuació ens baixarem el codi del repositori de github tot compilant els headers per els botons externs. També farà l’intent de instal·lar git per si fos el cas que no ho estigues instal·lat en la màquina.  

Com a penúltim pas realitzem la gestió I adquisició de permisos per www-data I realitzem una cosa destacable, consisteix en buscar tots els fitxers del codi de scripts en busca de newlines de Windows I substituir-les per les de Unix. Aquesta línia la hem trobat donat a que ens hem anat trobant incompatibilitats durant el procés de desenvolupament del projecte.  

Finalment iniciarem el servei remot I generarem la pipe per a donar-li els comandaments des de els altres scripts. Col·locarem la pipe a la localització /home/pi/Downloads tot I que ha estat un lloc per exemple, es podria modificar en qualsevol moment.  

A més, també crearem els fitxers llista.txt i currentsong.txt hardcodejant-los per fer funcionar la música del sistema.

<br>

# INSTALACIÓ
## Instalació a través del script (IMPORTANT)
Haureu de descarregar només l'script d'instal·lació amb el nom ```Install.sh``` a la carpeta Downloads. Amb aquest script, tot el procés, des de la clonació fins a la instal·lació, es fa per si mateix, només cal executar:
```
sh Install.sh
```
Important recordar que pel correcte funcionament, s'ha d'executar el script a la carpeta $HOME/Downloads.

## Modificaciones a posteriori de la instalació (FUNCIONALITATS MUSICALS)

A més, per activar les funcionalitats musicals a través d'apache i el seu usuari www-data hem hagut de modificar els següents arxius. Modificarem el fitxer \texttt{/etc/systemd/system/pulseaudio.service} per afegir:
```
Description=PulseAudio system server
    
[Service]
Type=notify
ExecStart=pulseaudio --daemonize=no --system --realtime --log-target=journal
    
[Install]
WantedBy=multi-user.target
```

Farem enable dels serveis corresponents:

```
sudo systemctl --system enable pulseaudio.service
sudo systemctl --system start pulseaudio.service
sudo systemctl --system status pulseaudio.service
```

Finalment editarem el fitxer /etc/pulse/client.conf en els següent atributs:
```
default-server = /var/run/pulse/native
autospawn = no
```

I afegirem el usuari www-data al grup corresponent: sudo adduser www-data pulse-access, sudo adduser www-data audio i sudo adduser www-data pulse. Finalment, fem un restart systemctl --user restart pulseaudio.service.



# Credits

Guillem Serra Cazorla (gserracazorla@gmail.com)
Pol Piñol Castuera (pol.pinolcastuera@gmail.com)
<br>
---
**NOTE:**

All this project has been developed and tested under the RaspberryPi Zero on the Raspberry Pi OS Lite.

---