# Email Routing off-box dig capture — cherokeedictionary.net (SC-1 evidence, partial)

Captured 2026-11-12 (workstation, off-box). Zone pre-state of record was the
2026-11-02T18:58:37Z export (no MX/SPF/DKIM). These outputs show the
Email Routing onboarding records are LIVE, matching the auto-added
Cloudflare forms from #45's validated procedure:

## MX (dig +short MX cherokeedictionary.net)

```
100 route3.mx.cloudflare.net.
3 route2.mx.cloudflare.net.
55 route1.mx.cloudflare.net.
```

## SPF (dig +short TXT cherokeedictionary.net | grep spf)

```
"v=spf1 include:_spf.mx.cloudflare.net ~all"
```

## DKIM (dig +short TXT cf2024-1._domainkey.cherokeedictionary.net)

```
"v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78k" "m4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB"
```

## Sanity (apex A records remain the proxied Cloudflare edge addresses)

```
172.67.212.59
104.21.53.113
```

Developer attestation (2026-11-12, chat): "emails already verified" — the two
destination addresses (m.conrad.202+ia@gmail.com, standtrooper+ia@gmail.com)
added and verified by the operator. SC-1's remaining half is the Email
Routing Settings dashboard/API view showing the three records Locked.
