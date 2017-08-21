$ORIGIN gciber.com.

$TTL 604800	; 1 week
@	 IN		 SOA	gciber.com. root.gciber.com. (
				13         ; serial
				604800     ; refresh (1 week)
				86400      ; retry (1 day)
				2419200    ; expire (4 weeks)
				604800     ; minimum (1 week)
				)	

@	IN		NS	ns.gciber.com.
@   IN      MX  10 webmail.gciber.com  
@	IN		A	10.0.2.103

ns	    IN		A	10.0.2.1
mvalle	IN		A	10.0.2.103
webmail IN      A   10.0.2.103
