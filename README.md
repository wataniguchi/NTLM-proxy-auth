# NTLM-proxy-auth
Patches for NTLM proxy auth in Perl

This is a collection of patches to enable NTLM proxy authentication, which is typically used in an enterprise with Active Directory, in Perl.

There are four files, excluding this README, in the repository:

1. googleGeoCode_sample.pl

 This is a sample Perl script to talk to an external web service (Google Geocoding API in this case) via a proxy with NTLM authentication.  Replace the below symbols in the script appropriately for your own environment:
  WORKSTATION
  DOMAIN\USER
  PASSWORD
  PROXY.SERVER.FQDN:PORT
  APPID (for Google Geocoding API)


2. Authen_NTLM.pm.diff

 A patch for Authen::NTLM in order to support NTLM v2 Authentication.  Refer to MS-NLMP for detals regarding the protocol.


3. LWP_Authen_Ntlm.pm.diff

 A patch for LWP::Authen::Ntlm in order to pass the control to Authen::NTLM during the use of a proxy.  The original code works with a web server requesting NTLM authentication and has been extended for the use of an NTLM proxy.  Except corrections in timing for invoking ntlm() and ntlm_reset(), this is largely a copy of work contributed by the GitHub user, benningm:
  https://github.com/libwww-perl/libwww-perl/pull/49/commits/5d831eea4049926b4483d2a06b2c3f83b290829c

4. LWP_Protocol_http.pm.diff

 A patch for LWP::Protocol in order to comform with the Keep Alive requirement to a client in NTLM authentication between Type 2 and Type 3 message, during the use of CONNECT proxy method.  Without this patch, a client recreate a socket for Type 3 message; and therefore, the proxy might refuse the authentication sequence to proceed.
