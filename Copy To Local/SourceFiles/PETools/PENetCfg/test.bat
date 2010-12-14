regsvr32 netcfgx.dll
factory.exe -minint
netcfg.exe -v -winpe
net start dhcp
net start nla