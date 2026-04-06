ldapsearch -x uid=lo288sys
ldapsearch -LLL uid=lo288sys
ldapsearch -x -Duid=lo288sys,ou=People,dc=cu,dc=subdomain,dc=domain,dc=local -W
ldapsearch -x -Duid=lo288net,ou=People,dc=cu,dc=subdomain,dc=domain,dc=local -W
ldapmodify -x -Dcn=manager,dc=cu,dc=subdomain,dc=domain,dc=local -w VNAC6JLqTm9O6nqRrCi9
ldapsearch -x uid=cedsys