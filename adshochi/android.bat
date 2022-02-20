set adt="H:\karimpoor\temp\air17_7\bin\adt.bat"

rem this is for debugging V
set adl="H:\karimpoor\temp\air17_7\bin\adl.exe"

set name=Ghadamshomar


set contents=AppIconsForPublish Data
rem "AppIconsForPublish"
set ios_contents=Default-568h-Portrait@2x.png Default-Portrait.png
rem set ios_contents=Default-568h@2x.png Default-Landscape.png

set android_certificate=H:\karimpoor\temp\Certificates\MTeam Certifications\MTeam Certification File.p12
set android_pass=NewPass123$
set android_target=apk-captive-runtime



set dAA3=1024x768:1024x768
rem debugger V
rem %adl% -profile mobileDevice -screensize %dAA3% "%name%-app.xml"



rem 

rem android export V
%adt% -package -target %android_target% %ios_useLegacy% -storetype pkcs12 -storepass %android_pass% -keystore "%android_certificate%" "%name%.apk" "%name%-app.xml" "%name%.swf" %contents%
