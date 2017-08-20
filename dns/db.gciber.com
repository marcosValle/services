;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns.gciber.com. root.gciber.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns.gciber.com.
ns	IN	A	192.168.0.32

;ftp	IN	A	192.168.0.11
