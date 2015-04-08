parser grammar CiscoGrammarCommonParser;

options {
   tokenVocab = CiscoGrammarCommonLexer;
}

access_list_action
:
   PERMIT
   | DENY
;

community
:
   com = COMMUNITY_NUMBER
   | com = DEC
   | com = INTERNET
   | com = LOCAL_AS
   | com = NO_ADVERTISE
   | com = NO_EXPORT
;

description_line
:
   DESCRIPTION text = M_DESCRIPTION_NON_NEWLINE? NEWLINE
;

exact_match [String matchText]
:
   {(_input.LT(1).getType() == VARIABLE || _input.LT(1).getType() == COMMUNITY_LIST_NUM_EXPANDED) && _input.LT(1).getText().equals($matchText)}?

   (
      VARIABLE
      | COMMUNITY_LIST_NUM_EXPANDED
   )
;

exit_line
:
   EXIT NEWLINE
;

interface_name
:
   (
      name_prefix_alpha = M_Interface_PREFIX
      (
         name_middle_parts += DEC
         (
            name_middle_parts += FORWARD_SLASH
            | name_middle_parts += PERIOD
         )
      )* range
   )
   |
   (
      name = VARIABLE
      (
         FORWARD_SLASH DEC
      )?
   )
;

port_specifier
:
   (
      EQ
      (
         args += port
      )+
   )
   |
   (
      GT arg = port
   )
   |
   (
      NEQ arg = port
   )
   |
   (
      LT arg = port
   )
   |
   (
      RANGE arg1 = port arg2 = port
   )
;

port
:
   DEC
   | BOOTPC
   | BOOTPS
   | BGP
   | CMD
   | DAYTIME
   | DOMAIN
   | EXEC
   | FTP
   | FTP_DATA
   | HOSTNAME
   | IDENT
   | ISAKMP
   | LPD
   | MLAG
   | NAMESERVER
   | NETBIOS_DGM
   | NETBIOS_NS
   | NETBIOS_SS
   | NNTP
   | NON500_ISAKMP
   | NTP
   | PIM_AUTO_RP
   | POP3
   | RIP
   | SMTP
   | SNMP
   | SNMPTRAP
   | SSH
   | SUNRPC
   | SYSLOG
   | TACACS
   | TELNET
   | TFTP
   | WHOIS
   | WWW
;

protocol
:
   AHP
   | DEC
   | EIGRP
   | ESP
   | GRE
   | ICMP
   | IGMP
   | IP
   | IPINIP
   | IPV6
   | OSPF
   | PIM
   | SCTP
   | TCP
   | UDP
   | VRRP
;

range
:
   (
      range_list += subrange
      (
         COMMA range_list += subrange
      )*
   )
   | NONE
;

subrange
:
   low = DEC
   (
      DASH high = DEC
   )?
;

switchport_trunk_encapsulation
:
   DOT1Q
   | ISL
   | NEGOTIATE
;