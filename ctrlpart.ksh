#!/bin/ksh

###
#	Name: ctrlpart.ksh
#	Description: Test de montage des lecteurs partagés de CANNES et TOULOUSE
#
#	Date: 31/07/2011
#
#	Author: A.LECOUTRE
#	
#	Version 1.1 :
#		Utilisation de la commande 'lsshare' (à la place de 'mount')
#
#	13/04/2012 D.EGGER : 	ressource TLSTORE01\LIBRE remplacee par TLSTORE09\PUBLIC
#				ajout des serveurs TLSTORE08 et TLSTORE09
###

clear

awk 'BEGIN { FS = ";" ;ERROR_NB=0; ERROR="" ;printf("\n --- Verification des partages de CANNES et TOULOUSE ---\n\n")}
				{printf("\nServeur "$1": ");
				for(i=2;i<NF;i++){
							if ($i != "public" && $i != "public") {RESS = $i"$"} else { RESS = $i}
							if(system("lsshare -h \/\/"$1"\/"RESS" 1>/dev/null 2>&1") != 0 ) {
									ERROR_NB+=1
									ERROR=ERROR"\/\/"$1"\/"RESS"\n"
									printf("!!! "$i" NOK !!! ")
								}
								else {
									printf(RESS" ")
								}
				}
				}
	END { if (ERROR_NB != 0) {
		printf("\n\n%s partage(s) en erreur : !!! \n",ERROR_NB);
		printf(ERROR);
		}
		else printf("\n\nAucune erreur\n")}' list_part

