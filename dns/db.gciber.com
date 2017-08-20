$ORIGIN .
$TTL 604800	; 1 week
gciber.com		IN SOA	ns.gciber.com. root.gciber.com. (
				3          ; serial
				604800     ; refresh (1 week)
				86400      ; retry (1 day)
				2419200    ; expire (4 weeks)
				604800     ; minimum (1 week)
				)
			NS	ns.gciber.com.
$ORIGIN gciber.com.
$TTL 300	; 5 minutes
debian			A	10.0.2.101
			TXT	"00586958b7e03ff798010083b2b325a066"
$TTL 604800	; 1 week
ns			A	10.0.2.1
